import 'package:flutter/material.dart';
import 'package:form_me/models/course.dart';
import 'package:form_me/services/course.dart';

class CourseListPage extends StatelessWidget {
  const CourseListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final courseService = CourseService();

    return Scaffold(
      appBar: AppBar(title: const Text('Tous les cours')),
      body: StreamBuilder<List<CourseModel>>(
        stream: courseService.getCourses(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Erreur de chargement des cours'));
          }

          final courses = snapshot.data ?? [];
          return ListView.builder(
            itemCount: courses.length,
            itemBuilder: (context, index) {
              final course = courses[index];
              return ListTile(
                leading: course.thumbnailUrl.isNotEmpty
                    ? Image.network(course.thumbnailUrl,
                        width: 50, height: 50, fit: BoxFit.cover)
                    : const Icon(Icons.book, size: 50),
                title: Text(course.title),
                subtitle: Text(course.description),
                onTap: () {
                  // Naviguer vers les détails du cours
                },
              );
            },
          );
        },
      ),
    );
  }
}
