import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:form_me/models/course.dart';

class CourseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Créer un nouveau cours
  Future<CourseModel?> createCourse(CourseModel course) async {
    try {
      DocumentReference docRef =
          await _firestore.collection('courses').add(course.toFirestore());

      return CourseModel.fromFirestore(await docRef.get());
    } catch (e) {
      print('Erreur lors de la création du cours : $e');
      return null;
    }
  }

  // Récupérer tous les cours
  Stream<List<CourseModel>> getCourses() {
    return _firestore.collection('courses').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => CourseModel.fromFirestore(doc)).toList());
  }

  // Récupérer un cours par son ID
  Future<CourseModel?> getCourseById(String courseId) async {
    try {
      DocumentSnapshot doc =
          await _firestore.collection('courses').doc(courseId).get();

      return CourseModel.fromFirestore(doc);
    } catch (e) {
      print('Erreur lors de la récupération du cours : $e');
      return null;
    }
  }

  // Filtrer les cours par catégorie
  Stream<List<CourseModel>> getCoursesByCategory(CourseCategory category) {
    return _firestore
        .collection('courses')
        .where('category', isEqualTo: category.name)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => CourseModel.fromFirestore(doc))
            .toList());
  }

  // Récupérer les cours disponibles hors ligne
  Stream<List<CourseModel>> getOfflineCourses() {
    return _firestore
        .collection('courses')
        .where('isOfflineAvailable', isEqualTo: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => CourseModel.fromFirestore(doc))
            .toList());
  }
}
