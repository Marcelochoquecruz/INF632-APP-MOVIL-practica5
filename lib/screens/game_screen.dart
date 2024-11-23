import 'package:flutter/material.dart';
import 'package:practica_5_app/screens/screen_pc_game.dart';
import 'package:provider/provider.dart';
import '../providers/game_provider.dart';  // Lógica de juego
import '../widgets/board_grid.dart';  // Tablero del juego
import '../widgets/player_score.dart';  // Puntuaciones de los jugadores
import '../widgets/game_status.dart';  // Estado del juego (¿ganó alguien?)
import '../widgets/custom_button.dart';  // Botones personalizados

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Fondo con un gradiente y colores personalizados
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF4A00E0), // Morado fuerte
                Color(0xFF8E2DE2), // Morado suave
                Color(0xFF00C9FF), // Azul claro
              ],
            ),
          ),
        ),
        title: Text(
          'Juego del Gato Tic-Tac-Toe',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.white,
              ),
        ),
        centerTitle: true,  // Título centrado
        backgroundColor: Colors.transparent,
        elevation: 0,  // Sin sombras
        actions: [
          // Botón para cambiar el tema
          IconButton(
            icon: Icon(
              Icons.brightness_6,  // Icono para cambiar de tema
              color: Colors.white,
            ),
            onPressed: () {
              final gameProvider = context.read<GameProvider>();
              gameProvider.toggleTheme();  // Cambia entre modo claro/oscuro
            },
          ),
        ],
      ),
      body: Container(
        color: Colors.black12,  // Fondo de pantalla oscuro para que los botones resalten
        child: SafeArea(
          child: Column(
            children: [
              // Sección de puntuaciones de los jugadores
              const PlayerScore(),
              
              // Tablero central del juego
              const Expanded(
                child: Center(
                  child: BoardGrid(),
                ),
              ),
              
              // Estado del juego: muestra si alguien ganó o si fue empate
              const GameStatus(),
              
              // Botones de acción debajo del juego
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    // Botón de Seguir jugando
                    CustomButton(
                      onPressed: () => context.read<GameProvider>().resetGame(),
                      label: 'Seguir jugando',  // Cambiado a "Seguir jugando"
                      icon: Icons.refresh_rounded,  // Icono de reiniciar con un toque moderno
                      backgroundColor: Colors.deepPurple,  // Botón morado
                      textColor: Colors.white,  // Texto blanco para resaltar
                    ),
                    const SizedBox(height: 16), // Un poco de espacio vertical
                    // Botón de Reiniciar puntuaciones
                    CustomButton(
                      onPressed: () => context.read<GameProvider>().resetScores(),
                      label: 'Reiniciar puntuaciones',
                      icon: Icons.sports_score,  // Icono de puntuación más apropiado
                      backgroundColor: Colors.orange,  // Botón naranja
                      textColor: Colors.white,  // Texto blanco
                    ),
                    const SizedBox(height: 16), // Un poco de espacio vertical
                    // Botón de jugar contra la PC
                    CustomButton(
  onPressed: () {
    // Navegar a la pantalla del juego
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ScreenPcGame(),
      ),
    ).then((_) {
      // Mostrar SnackBar después de que la pantalla esté cargada
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Modo PC Desactivado',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              foreground: Paint()
                ..shader = LinearGradient(
                  colors: [Colors.blue, Colors.purple, Colors.white],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
            ),
          ),
          duration: Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.black.withOpacity(0.6),
        ),
      );

    });
  },
  label: 'Jugar con la PC',
  icon: Icons.computer_rounded,
  backgroundColor: Colors.blue,
  textColor: Colors.white,
),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// Primero, crea un nuevo widget para el modal del juego
class GameModal extends StatelessWidget {
  const GameModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF4A00E0),
              Color(0xFF8E2DE2),
              Color(0xFF00C9FF),
            ],
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Título del modal
            const Text(
              'Juego contra la PC',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            
            // Selector de dificultad
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Dificultad:',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(width: 10),
                  DropdownButton<String>(
                    value: 'Normal',
                    dropdownColor: const Color(0xFF4A00E0),
                    style: const TextStyle(color: Colors.white),
                    items: ['Fácil', 'Normal', 'Difícil']
                        .map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        })
                        .toList(),
                    onChanged: (String? newValue) {
                      // Aquí implementarías la lógica para cambiar la dificultad
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            
            // Selector de símbolo del jugador
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Tu símbolo:',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(width: 10),
                  ToggleButtons(
                    borderRadius: BorderRadius.circular(10),
                    selectedColor: Colors.white,
                    fillColor: const Color(0xFF8E2DE2),
                    color: Colors.white60,
                    constraints: const BoxConstraints(
                      minWidth: 60,
                      minHeight: 40,
                    ),
                    isSelected: const [true, false],
                    onPressed: (index) {
                      // Aquí implementarías la lógica para cambiar el símbolo
                    },
                    children: const [
                      Text('X', style: TextStyle(fontSize: 20)),
                      Text('O', style: TextStyle(fontSize: 20)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            
            // Botones de acción
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 15,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancelar'),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 15,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    // Aquí implementarías la lógica para iniciar el juego
                    Navigator.of(context).pop();
                    // Iniciar el juego con la configuración seleccionada
                  },
                  child: const Text('¡Jugar!'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}