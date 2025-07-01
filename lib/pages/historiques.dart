import 'package:flutter/material.dart';
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
      appBar: AppBar(title: const Text("Historique des scores")),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _chargerScores(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final scores = snapshot.data ?? [];

          if (scores.isEmpty) {
            return const Center(child: Text("Aucun score enregistré."));
          }

          return ListView.builder(
            itemCount: scores.length,
            itemBuilder: (context, index) {
              final score = scores[index];
              return ListTile(
                title: Text("Score : ${score['score']} / ${score['total']}"),
                subtitle: Text("Date : ${score['date']}"),
              );
            },
          );
        },
      ),
    );
  }
}
