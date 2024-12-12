import 'package:flutter/material.dart';
import 'package:form_me/pages/courses.dart';
import 'package:form_me/services/auth.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accueil'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              // Déconnexion
              final authService = AuthService();
              await authService.signOut();

              // Redirection vers la page de connexion
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Bienvenue sur la plateforme',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Explorez nos cours, vos statistiques, et bien plus encore.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                children: [
                  _buildHomeCard(
                    context,
                    title: 'Tous les cours',
                    icon: Icons.book,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CourseListPage(),
                        ),
                      );
                    },
                  ),
                  _buildHomeCard(
                    context,
                    title: 'Mes cours',
                    icon: Icons.playlist_play,
                    onTap: () {
                      // Naviguer vers la page des cours inscrits
                    },
                  ),
                  _buildHomeCard(
                    context,
                    title: 'Profil',
                    icon: Icons.person,
                    onTap: () {
                      // Naviguer vers la page de profil utilisateur
                    },
                  ),
                  _buildHomeCard(
                    context,
                    title: 'Mode hors ligne',
                    icon: Icons.download,
                    onTap: () {
                      // Naviguer vers la page des cours hors ligne
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHomeCard(BuildContext context,
      {required String title,
      required IconData icon,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 40, color: Theme.of(context).primaryColor),
              const SizedBox(height: 10),
              Text(
                title,
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
