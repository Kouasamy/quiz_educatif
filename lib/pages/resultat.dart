import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:quiz_educatif/pages/accueil.dart';

class PageResultat extends StatelessWidget {
  final int score;
  final int total;
  final String email;

  const PageResultat({
    super.key,
    required this.score,
    required this.total,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    double pourcentage = (score / total) * 100;

    return Scaffold(
      backgroundColor: const Color(0xFFD7CCC8), // Fond marron clair
      appBar: AppBar(
        title: const Text("Résultat"),
        backgroundColor: const Color(0xFF5D4037), // Marron foncé
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Résultat final",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF5D4037),
                ),
              ).animate().fadeIn(duration: 600.ms).slideY(begin: -0.3),
              const SizedBox(height: 30),
              Text(
                "$score / $total",
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ).animate().scale(duration: 400.ms),
              const SizedBox(height: 10),
              Text(
                "Soit ${pourcentage.toStringAsFixed(0)}%",
                style: const TextStyle(fontSize: 20, color: Colors.black54),
              ).animate().fadeIn(delay: 300.ms),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PageAccueil(email: email),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF5D4037),
                  padding: const EdgeInsets.symmetric(
                    vertical: 14,
                    horizontal: 30,
                  ),
                  textStyle: const TextStyle(fontSize: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text("Retour à l'accueil"),
              ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.3),
            ],
          ),
        ),
      ),
    );
  }
}
