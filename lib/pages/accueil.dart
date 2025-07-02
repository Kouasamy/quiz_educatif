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
        backgroundColor: Colors.lightBlue.shade300,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Déconnexion',
            onPressed: () => _seDeconnecter(context),
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade50, Colors.red.shade50],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Bienvenue sur le Quiz Éducatif !',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade700,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () => _lancerQuiz(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlue.shade400,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 15,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                  child: const Text('Lancer le Quiz'),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => _allerHistorique(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent.shade100,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 15,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                  child: const Text("Voir l'historique"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
