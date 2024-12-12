import 'package:flutter/material.dart';
import 'package:form_me/models/user.dart';
import 'package:form_me/pages/home.dart';
import 'package:form_me/services/auth.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  void _register() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();
      final fullName = _fullNameController.text.trim();

      final authService = AuthService();
      final user = await authService.signUp(
        email: email,
        password: password,
        fullName: fullName,
        userType: UserType.student, // Par défaut, type utilisateur "étudiant"
      );

      setState(() => _isLoading = false);

      if (user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Erreur lors de l\'inscription.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Créer un compte')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _fullNameController,
                decoration: const InputDecoration(labelText: 'Nom complet'),
                validator: (value) => value != null && value.isNotEmpty
                    ? null
                    : 'Entrez votre nom complet',
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) => value != null && value.contains('@')
                    ? null
                    : 'Entrez un email valide',
              ),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Mot de passe'),
                obscureText: true,
                validator: (value) => value != null && value.length >= 6
                    ? null
                    : 'Mot de passe trop court',
              ),
              const SizedBox(height: 20),
              _isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _register,
                      child: const Text('Créer un compte'),
                    ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Retour à la connexion'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
