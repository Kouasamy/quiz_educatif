import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:quiz_educatif/donnees/liste_questions.dart';
import 'package:quiz_educatif/pages/resultat.dart';
import 'package:quiz_educatif/database/database.dart';

class PageQuiz extends StatefulWidget {
  final String email;
  const PageQuiz({super.key, required this.email});

  @override
  State<PageQuiz> createState() => _PageQuizState();
}

class _PageQuizState extends State<PageQuiz> {
  int _indexQuestion = 0;
  int _score = 0;

  void _choisirReponse(String reponse) async {
    final question = questions[_indexQuestion];
    final correcte = question['bonneReponse'];

    if (reponse == correcte) _score++;

    if (_indexQuestion < questions.length - 1) {
      setState(() => _indexQuestion++);
    } else {
      await BaseQuiz.instance.enregistrerScore(
        widget.email,
        _score,
        questions.length,
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => PageResultat(
            score: _score,
            total: questions.length,
            email: widget.email,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final question = questions[_indexQuestion];

    return Scaffold(
      backgroundColor: const Color(0xFFD7CCC8), // Marron clair
      appBar: AppBar(
        title: const Text("Quiz"),
        backgroundColor: const Color(0xFF5D4037),
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Question ${_indexQuestion + 1} / ${questions.length}",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF5D4037),
              ),
            ).animate().fadeIn().slideX(),
            const SizedBox(height: 20),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  question['texte'],
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ).animate().fadeIn(delay: 200.ms),
            const SizedBox(height: 30),
            ...List.generate((question['choix'] as List<String>).length, (i) {
              final option = question['choix'][i];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: ElevatedButton(
                  onPressed: () => _choisirReponse(option),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6D4C41), // marron foncé
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 1,
                  ),
                  child: Text(option, style: const TextStyle(fontSize: 16)),
                ).animate().fadeIn(delay: (300 + i * 100).ms),
              );
            }),
            const Spacer(),
            LinearProgressIndicator(
              value: (_indexQuestion + 1) / questions.length,
              color: const Color(0xFF5D4037),
              backgroundColor: Colors.brown.shade100,
              minHeight: 6,
            ).animate().fadeIn(),
            const SizedBox(height: 10),
            Center(
              child: Text(
                "Progression : ${((_indexQuestion + 1) / questions.length * 100).toStringAsFixed(0)}%",
                style: const TextStyle(fontSize: 14, color: Colors.black54),
              ),
            ).animate().fadeIn(),
          ],
        ),
      ),
    );
  }
}
