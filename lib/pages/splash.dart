import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class PageSplash extends StatefulWidget {
  const PageSplash({super.key});

  @override
  State<PageSplash> createState() => _PageSplashState();
}

class _PageSplashState extends State<PageSplash> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/connexion');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD7CCC8), // marron clair
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Le Quiz Éducatif",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color(0xFF5D4037), // marron foncé
              ),
            ).animate().fadeIn(duration: 1000.ms).slideY(begin: -0.5),
            const SizedBox(height: 40),
            const CircularProgressIndicator(
              color: Color(0xFF5D4037),
            ).animate().fadeIn(duration: 1000.ms),
          ],
        ),
      ),
    );
  }
}
