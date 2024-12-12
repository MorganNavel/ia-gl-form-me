import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:form_me/models/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserModel?> signUp({
    required String email,
    required String password,
    required String fullName,
    required UserType userType,
  }) async {
    try {
      // Créer l'utilisateur avec Firebase Auth
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      print('UserCredential type: ${result.runtimeType}');
      print('User type: ${result.user?.runtimeType}');

      // Créer le modèle utilisateur
      UserModel userModel = UserModel(
        id: result.user!.uid,
        email: email,
        fullName: fullName,
        userType: userType,
        createdAt: DateTime.now(),
      );
      print('UserModel created: $userModel');

      // Enregistrer les détails dans Firestore
      await _firestore
          .collection('users')
          .doc(result.user!.uid)
          .set(userModel.toFirestore());
      print('User data saved to Firestore');

      return userModel;
    } catch (e) {
      print('Error during sign up: $e');
      return null;
    }
  }

  Future<UserModel?> signIn(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      // Récupérer les détails de l'utilisateur depuis Firestore
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(result.user!.uid).get();

      return UserModel.fromFirestore(userDoc);
    } catch (e) {
      print('Erreur de connexion : $e');
      return null;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Récupérer l'utilisateur actuellement connecté
  Stream<UserModel?> get currentUser {
    return _auth.authStateChanges().asyncMap((User? user) async {
      if (user == null) return null;

      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(user.uid).get();

      return UserModel.fromFirestore(userDoc);
    });
  }
}
