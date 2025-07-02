import 'package:flutter/material.dart';

class BoutonAnime extends StatefulWidget {
  final VoidCallback onPressed;
  final String texte;
  final Color couleur;

  const BoutonAnime({
    super.key,
    required this.onPressed,
    required this.texte,
    this.couleur = const Color(0xFF5D4037),
  });

  @override
  State<BoutonAnime> createState() => _BoutonAnimeState();
}

class _BoutonAnimeState extends State<BoutonAnime> {
  bool _survole = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _survole = true),
      onExit: (_) => setState(() => _survole = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: widget.couleur,
          borderRadius: BorderRadius.circular(12),
          boxShadow: _survole
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: widget.onPressed,
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 30),
              child: Center(
                child: Text(
                  widget.texte,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
