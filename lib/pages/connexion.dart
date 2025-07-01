import 'package:flutter/material.dart';
import 'package:quiz_educatif/database/database.dart';
import 'package:quiz_educatif/pages/accueil.dart';

class PageConnexion extends StatefulWidget {
  const PageConnexion({super.key});

  @override
  State<PageConnexion> createState() => _PageConnexionState();
}

class _PageConnexionState extends State<PageConnexion> {
  final _email = TextEditingController();
  final _mdp = TextEditingController();
  String? _erreur;

  Future<void> _connecter() async {
    final email = _email.text.trim();
    final mdp = _mdp.text.trim();
    if (email.isEmpty || mdp.isEmpty) {
      setState(() => _erreur = 'Tous les champs sont requis.');
      return;
    }

    final user = await BaseQuiz.instance.getUtilisateur(email);
    if (user == null || user['mot_de_passe'] != mdp) {
      setState(() => _erreur = 'Email ou mot de passe incorrect.');
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => PageAccueil(email: email)),
    );
  }

  void _allerInscription() => Navigator.pushNamed(context, '/inscription');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Connexion')),
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
              onPressed: _connecter,
              child: const Text('Se connecter'),
            ),
            TextButton(
              onPressed: _allerInscription,
              child: const Text('Créer un compte'),
            ),
          ],
        ),
      ),
    );
  }
}
