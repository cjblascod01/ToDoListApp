import 'package:flutter/material.dart';
import '../models/aptitude.dart';

class AptitudeCard extends StatelessWidget {
  final Aptitude aptitude;
  final VoidCallback onAddXp; // mantenido por compatibilidad

  const AptitudeCard({
    super.key,
    required this.aptitude,
    required this.onAddXp,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            // ------------------- Imagen Pokémon -------------------
            SizedBox(
              width: 60,
              height: 60,
              child: Image.asset(
                'assets/pokemons/${aptitude.currentPokemon.toLowerCase()}.png',
                fit: BoxFit.contain,
              ),
            ),

            const SizedBox(width: 16),

            // ------------------- Datos aptitud -------------------
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    aptitude.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    aptitude.currentPokemon,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text('Nivel ${aptitude.level}'),
                  const SizedBox(height: 6),

                  LinearProgressIndicator(
                    value: aptitude.progress,
                    backgroundColor: Colors.grey.shade800,
                    color: Colors.purpleAccent,
                    minHeight: 8,
                  ),

                  const SizedBox(height: 4),

                  Text(
                    '${aptitude.xp} / ${aptitude.xpToNextLevel} XP',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
