import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/game_provider.dart';

// Widget que muestra el estado final del juego (ganador o empate)
class GameStatus extends StatelessWidget {
  const GameStatus({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtenemos el estado del juego desde GameProvider
    final gameState = context.watch<GameProvider>().gameState;

    // Si el juego no ha terminado, no mostramos nada
    if (!gameState.gameOver) {
      return const SizedBox.shrink(); // Retorna un widget invisible
    }

    // Variables para el mensaje del resultado y el color asociado
    String message;
    Color color;

    // Determina el mensaje y el color según el resultado del juego
    if (gameState.winner == 'Draw') {
      // Caso de empate
      message = "¡Es un empate!";
      color = Colors.black; // Color neutral
    } else {
      // Caso de victoria de un jugador
      message = "¡Gana el jugador! ${gameState.winner}";
      // Color depende del jugador ganador (X o O)
      color = gameState.winner == 'X'
          ? Theme.of(context).colorScheme.primary
          : Theme.of(context).colorScheme.secondary;
    }

    // Construye un widget para mostrar el resultado final
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16.0), // Espaciado externo
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0), // Espaciado interno
      decoration: BoxDecoration(
        color: color.withOpacity(0.1), // Fondo con opacidad del color asociado
        borderRadius: BorderRadius.circular(30), // Bordes redondeados
        border: Border.all(color: color, width: 2), // Borde con el color del resultado
      ),
      child: Text(
        message, // Texto del mensaje
        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
          color: color, // Color del texto según el resultado
          fontSize: 24, // Tamaño de la fuente
        ),
      ),
    );
  }
}
