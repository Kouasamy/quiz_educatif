import 'package:flutter/material.dart';
import 'package:quiz_educatif/pages/connexion.dart';
import 'package:quiz_educatif/pages/inscription.dart';
import 'package:quiz_educatif/pages/accueil.dart';
import 'package:quiz_educatif/pages/quiz.dart';

void main() {
  runApp(const MonQuizApp());
}

class MonQuizApp extends StatelessWidget {
  const MonQuizApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz Educatif',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.indigo),
      initialRoute: '/connexion',
      routes: {
        '/connexion': (context) => const PageConnexion(),
        '/inscription': (context) => const PageInscription(),
        '/accueil': (context) => PageAccueil(email: ''),
        '/quiz': (context) => PageQuiz(email: ''),
      },
    );
  }
}
