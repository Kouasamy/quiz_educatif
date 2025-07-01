import 'package:flutter/material.dart';
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
    return Scaffold(
      appBar: AppBar(title: const Text("Résultat")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Votre score est $score / $total",
              style: const TextStyle(fontSize: 26),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => PageAccueil(email: email)),
                );
              },
              child: const Text("Retour à l'accueil"),
            ),
          ],
        ),
      ),
    );
  }
}
