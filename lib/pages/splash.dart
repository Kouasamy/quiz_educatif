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
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFD7CCC8), Color(0xFFBCAAA4)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Le Quiz Éducatif",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF5D4037),
                  shadows: [
                    Shadow(
                      blurRadius: 6,
                      color: Colors.black26,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
              ).animate().fadeIn(duration: 1000.ms).slideY(begin: -0.3),
              const SizedBox(height: 40),
              const CircularProgressIndicator(
                color: Color(0xFF5D4037),
                strokeWidth: 3,
              ).animate().fadeIn(duration: 1000.ms),
            ],
          ),
        ),
      ),
    );
  }
}
