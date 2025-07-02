import 'package:flutter/material.dart';
import 'package:quiz_educatif/pages/accueil.dart';
import 'package:quiz_educatif/pages/connexion.dart';
import 'package:quiz_educatif/pages/inscription.dart';
import 'package:quiz_educatif/pages/splash.dart';

void main() {
  runApp(const MonQuizApp());
}

class MonQuizApp extends StatelessWidget {
  const MonQuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Le Quiz Éducatif',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFD7CCC8),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF5D4037),
          foregroundColor: Colors.white,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const PageSplash(),
        '/connexion': (context) => const PageConnexion(),
        '/inscription': (context) => const PageInscription(),
        '/accueil': (context) => PageAccueil(email: ''),
      },
    );
  }
}
