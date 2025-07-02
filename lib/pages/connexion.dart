import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:quiz_educatif/database/database.dart';
import 'package:quiz_educatif/pages/accueil.dart';
import 'package:quiz_educatif/pages/inscription.dart';
import 'package:quiz_educatif/widgets/bouton_animated.dart';

class PageConnexion extends StatefulWidget {
  const PageConnexion({super.key});

  @override
  State<PageConnexion> createState() => _PageConnexionState();
}

class _PageConnexionState extends State<PageConnexion> {
  final _email = TextEditingController();
  final _mdp = TextEditingController();
  String? _erreur;
  bool _chargement = false;

  Future<void> _connecter() async {
    final email = _email.text.trim();
    final mdp = _mdp.text.trim();
    if (email.isEmpty || mdp.isEmpty) {
      setState(() => _erreur = 'Tous les champs sont requis.');
      return;
    }

    setState(() {
      _erreur = null;
      _chargement = true;
    });

    final user = await BaseQuiz.instance.getUtilisateur(email);
    if (user == null || user['mot_de_passe'] != mdp) {
      setState(() {
        _erreur = 'Email ou mot de passe incorrect.';
        _chargement = false;
      });
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => PageAccueil(email: email)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD7CCC8),
      appBar: AppBar(
        title: const Text('Connexion'),
        backgroundColor: const Color(0xFF5D4037),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 30),
            const Text(
              'Bienvenue',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF5D4037),
              ),
            ).animate().fadeIn(duration: 600.ms).slideY(begin: -0.2),
            const SizedBox(height: 40),
            TextField(
              controller: _email,
              decoration: const InputDecoration(
                labelText: 'Email',
                filled: true,
                fillColor: Colors.white,
              ),
            ).animate().fadeIn(delay: 200.ms),
            const SizedBox(height: 20),
            TextField(
              controller: _mdp,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Mot de passe',
                filled: true,
                fillColor: Colors.white,
              ),
            ).animate().fadeIn(delay: 300.ms),
            if (_erreur != null)
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text(
                  _erreur!,
                  style: const TextStyle(color: Colors.red),
                ),
              ).animate().fadeIn(delay: 400.ms),
            const SizedBox(height: 30),
            AnimatedSwitcher(
              duration: 300.ms,
              child: _chargement
                  ? const CircularProgressIndicator(color: Color(0xFF5D4037))
                  : BoutonAnime(
                      texte: "Se connecter",
                      onPressed: _connecter,
                    ).animate().fadeIn(delay: 500.ms),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const PageInscription()),
                );
              },
              child: const Text(
                'Créer un compte',
                style: TextStyle(
                  color: Color(0xFF5D4037),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ).animate().fadeIn(delay: 600.ms),
          ],
        ),
      ),
    );
  }
}
