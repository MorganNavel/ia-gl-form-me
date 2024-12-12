import 'package:cloud_firestore/cloud_firestore.dart';

enum UserType { student, teacher, parent, professional }

class UserModel {
  final String id;
  final String email;
  final String fullName;
  final UserType userType;
  final DateTime createdAt;
  final String? profileImageUrl;
  final List<String> enrolledCourses;

  UserModel({
    required this.id,
    required this.email,
    required this.fullName,
    required this.userType,
    required this.createdAt,
    this.profileImageUrl,
    this.enrolledCourses = const [],
  });

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    try {
      return UserModel(
        id: doc.id,
        email: data['email'] ?? '',
        fullName: data['fullName'] ?? '',
        userType: UserType.values.byName(data['userType'] ?? 'student'),
        createdAt: (data['createdAt'] as Timestamp).toDate(),
        profileImageUrl: data['profileImageUrl'],
        enrolledCourses: List<String>.from(data['enrolledCourses'] ?? []),
      );
    } catch (e) {
      print("Error retrieving user data: $e");
      rethrow;
    }
  }

  Map<String, dynamic> toFirestore() {
    return {
      'email': email,
      'fullName': fullName,
      'userType': userType.name,
      'createdAt': Timestamp.fromDate(createdAt),
      'profileImageUrl': profileImageUrl,
      'enrolledCourses': enrolledCourses,
    };
  }
}
