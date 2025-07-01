import 'package:flutter/material.dart';
import 'package:quiz_educatif/database/database.dart';
import 'package:quiz_educatif/pages/accueil.dart';

class PageInscription extends StatefulWidget {
  const PageInscription({super.key});

  @override
  State<PageInscription> createState() => _PageInscriptionState();
}

class _PageInscriptionState extends State<PageInscription> {
  final _email = TextEditingController();
  final _mdp = TextEditingController();
  String? _erreur;

  Future<void> _creerCompte() async {
    final email = _email.text.trim();
    final mdp = _mdp.text.trim();
    if (email.isEmpty || mdp.isEmpty) {
      setState(() => _erreur = 'Tous les champs sont requis.');
      return;
    }

    try {
      await BaseQuiz.instance.inscrireUtilisateur(email, mdp);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => PageAccueil(email: email)),
      );
    } catch (e) {
      print("ERREUR INSCRIPTION : $e"); // Ajoute ceci pour la console
      if (e.toString().contains('UNIQUE constraint failed')) {
        setState(() => _erreur = "Cet email est déjà utilisé.");
      } else {
        setState(() => _erreur = "Erreur lors de l'inscription : $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Inscription')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _email,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _mdp,
              decoration: const InputDecoration(labelText: 'Mot de passe'),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            if (_erreur != null)
              Text(_erreur!, style: const TextStyle(color: Colors.red)),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _creerCompte,
              child: const Text('Créer un compte'),
            ),
          ],
        ),
      ),
    );
  }
}
