import 'package:cloud_firestore/cloud_firestore.dart';

enum CourseLevel { beginner, intermediate, advanced }

enum CourseCategory { programming, design, business, language, science }

class CourseModel {
  final String id;
  final String title;
  final String description;
  final CourseLevel level;
  final CourseCategory category;
  final String instructorId;
  final String thumbnailUrl;
  final List<String> chapters;
  final bool isOfflineAvailable;
  final double price;
  final DateTime createdAt;

  CourseModel({
    required this.id,
    required this.title,
    required this.description,
    required this.level,
    required this.category,
    required this.instructorId,
    required this.thumbnailUrl,
    this.chapters = const [],
    this.isOfflineAvailable = false,
    this.price = 0.0,
    required this.createdAt,
  });

  factory CourseModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return CourseModel(
      id: doc.id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      level: CourseLevel.values.byName(data['level'] ?? 'beginner'),
      category: CourseCategory.values.byName(data['category'] ?? 'programming'),
      instructorId: data['instructorId'] ?? '',
      thumbnailUrl: data['thumbnailUrl'] ?? '',
      chapters: List<String>.from(data['chapters'] ?? []),
      isOfflineAvailable: data['isOfflineAvailable'] ?? false,
      price: (data['price'] ?? 0.0).toDouble(),
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'description': description,
      'level': level.name,
      'category': category.name,
      'instructorId': instructorId,
      'thumbnailUrl': thumbnailUrl,
      'chapters': chapters,
      'isOfflineAvailable': isOfflineAvailable,
      'price': price,
      'createdAt': createdAt,
    };
  }
}
