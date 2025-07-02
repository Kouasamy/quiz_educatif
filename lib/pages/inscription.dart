import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:quiz_educatif/database/database.dart';
import 'package:quiz_educatif/pages/accueil.dart';

class PageInscription extends StatefulWidget {
  const PageInscription({super.key});

  @override
  State<PageInscription> createState() => _PageInscriptionState();
}

class _PageInscriptionState extends State<PageInscription> {
  final _email = TextEditingController();
  final _mdp = TextEditingController();
  String? _erreur;
  bool _chargement = false;

  Future<void> _creerCompte() async {
    final email = _email.text.trim();
    final mdp = _mdp.text.trim();
    if (email.isEmpty || mdp.isEmpty) {
      setState(() => _erreur = 'Tous les champs sont requis.');
      return;
    }

    setState(() {
      _chargement = true;
      _erreur = null;
    });

    try {
      await BaseQuiz.instance.inscrireUtilisateur(email, mdp);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => PageAccueil(email: email)),
      );
    } catch (e) {
      if (e.toString().contains('UNIQUE constraint failed')) {
        setState(() => _erreur = "Cet email est déjà utilisé.");
      } else {
        setState(() => _erreur = "Erreur lors de l'inscription.");
      }
    } finally {
      setState(() => _chargement = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD7CCC8), // Fond marron clair
      appBar: AppBar(
        title: const Text('Créer un compte'),
        backgroundColor: const Color(0xFF5D4037),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 40),
            const Text(
              "Inscription",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF5D4037),
              ),
            ).animate().fadeIn().slideY(begin: -0.3),
            const SizedBox(height: 30),
            TextField(
              controller: _email,
              decoration: const InputDecoration(
                labelText: 'Email',
                filled: true,
                fillColor: Colors.white,
              ),
            ).animate().fadeIn(delay: 200.ms),
            const SizedBox(height: 16),
            TextField(
              controller: _mdp,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Mot de passe',
                filled: true,
                fillColor: Colors.white,
              ),
            ).animate().fadeIn(delay: 400.ms),
            const SizedBox(height: 20),
            if (_erreur != null)
              Text(
                _erreur!,
                style: const TextStyle(color: Colors.red),
              ).animate().fadeIn(delay: 500.ms),
            const SizedBox(height: 30),
            AnimatedSwitcher(
              duration: 400.ms,
              child: _chargement
                  ? const CircularProgressIndicator(color: Color(0xFF5D4037))
                  : ElevatedButton(
                      onPressed: _creerCompte,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF5D4037),
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 32,
                        ),
                        textStyle: const TextStyle(fontSize: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('Créer un compte'),
                    ).animate().fadeIn(delay: 600.ms).scale(),
            ),
          ],
        ),
      ),
    );
  }
}
