import 'package:flutter/material.dart';
import 'package:quiz_educatif/pages/historiques.dart';

class PageAccueil extends StatelessWidget {
  final String email;

  const PageAccueil({super.key, required this.email});

  void _lancerQuiz(BuildContext context) {
    Navigator.pushNamed(context, '/quiz');
  }

  void _seDeconnecter(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/connexion');
  }

  void _allerHistorique(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => PageHistorique(email: email)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accueil'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Déconnexion',
            onPressed: () => _seDeconnecter(context),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Bienvenue sur le Quiz Éducatif !',
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _lancerQuiz(context),
              child: const Text('Lancer le Quiz'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _allerHistorique(context),
              child: const Text('Voir l\'historique'),
            ),
          ],
        ),
      ),
    );
  }
}
