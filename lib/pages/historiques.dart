import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:quiz_educatif/database/database.dart';

class PageHistorique extends StatelessWidget {
  final String email;

  const PageHistorique({super.key, required this.email});

  Future<List<Map<String, dynamic>>> _chargerScores() {
    return BaseQuiz.instance.getScoresParEmail(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD7CCC8), // Marron clair
      appBar: AppBar(
        title: const Text("Historique des scores"),
        backgroundColor: const Color(0xFF5D4037),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _chargerScores(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF5D4037)),
            );
          }

          final scores = snapshot.data ?? [];

          if (scores.isEmpty) {
            return const Center(
              child: Text(
                "Aucun score enregistré.",
                style: TextStyle(fontSize: 18, color: Colors.black54),
              ),
            ).animate().fadeIn();
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: scores.length,
            itemBuilder: (context, index) {
              final score = scores[index];
              return Card(
                color: Colors.white,
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: ListTile(
                  leading: const Icon(Icons.star, color: Color(0xFF5D4037)),
                  title: Text(
                    "Score : ${score['score']} / ${score['total']}",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text("Date : ${score['date']}"),
                ),
              ).animate().fadeIn(delay: (100 * index).ms);
            },
          );
        },
      ),
    );
  }
}
