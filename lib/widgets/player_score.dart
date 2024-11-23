import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/game_provider.dart';

class PlayerScore extends StatelessWidget {
  const PlayerScore({super.key});

  @override
  Widget build(BuildContext context) {
    final gameState = context.watch<GameProvider>().gameState;
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildPlayerScore(
            context,
            'Jugador X',
            gameState.playerXScore,
            gameState.currentPlayer == 'X',
            Theme.of(context).colorScheme.primary,
          ),
          _buildPlayerScore(
            context,
            'Jugador O',
            gameState.playerOScore,
            gameState.currentPlayer == 'O',
            Theme.of(context).colorScheme.secondary,
          ),
        ],
      ),
    );
  }

  Widget _buildPlayerScore(
    BuildContext context,
    String player,
    int score,
    bool isCurrentPlayer,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: isCurrentPlayer ? color.withOpacity(0.1) : Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isCurrentPlayer ? color : Colors.transparent,
          width: 2,
        ),
      ),
      child: Column(
        children: [
          Text(
            player,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            score.toString(),
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}