import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:quiz_educatif/pages/quiz.dart';
import 'package:quiz_educatif/pages/historiques.dart';
import 'package:quiz_educatif/pages/connexion.dart';

class PageAccueil extends StatelessWidget {
  final String email;

  const PageAccueil({super.key, required this.email});

  void _lancerQuiz(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => PageQuiz(email: email)),
    );
  }

  void _allerHistorique(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => PageHistorique(email: email)),
    );
  }

  void _seDeconnecter(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const PageConnexion()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD7CCC8),
      appBar: AppBar(
        title: const Text('Accueil'),
        actions: [
          IconButton(
            tooltip: 'Déconnexion',
            icon: const Icon(Icons.logout),
            onPressed: () => _seDeconnecter(context),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Le Quiz Éducatif",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF5D4037),
                ),
              ).animate().fadeIn().slideY(begin: -0.2),
              const SizedBox(height: 10),
              Text(
                "Connecté : $email",
                style: const TextStyle(fontSize: 16, color: Colors.black54),
              ).animate().fadeIn(delay: 300.ms),
              const SizedBox(height: 30),
              ElevatedButton.icon(
                onPressed: () => _lancerQuiz(context),
                icon: const Icon(Icons.play_arrow),
                label: const Text("Lancer le Quiz"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF5D4037),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 16,
                  ),
                  textStyle: const TextStyle(fontSize: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ).animate().fadeIn(delay: 500.ms),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () => _allerHistorique(context),
                icon: const Icon(Icons.history),
                label: const Text("Voir l'historique"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown.shade300,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 16,
                  ),
                  textStyle: const TextStyle(fontSize: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ).animate().fadeIn(delay: 700.ms),
            ],
          ),
        ),
      ),
    );
  }
}
