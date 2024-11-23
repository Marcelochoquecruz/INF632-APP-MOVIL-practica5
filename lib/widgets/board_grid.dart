import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/game_provider.dart';

class BoardGrid extends StatelessWidget {
  const BoardGrid({super.key});

  @override
  Widget build(BuildContext context) {
    // Sacamos el estado del juego, como quien chequea el marcador en tiempo real
    final gameState = context.watch<GameProvider>().gameState;
    
    return Container(
      // Esto asegura que no se pase de ancho
      constraints: const BoxConstraints(maxWidth: 400),
      padding: const EdgeInsets.all(16.0),
      child: AspectRatio(
        aspectRatio: 1, // Un cuadrado perfecto
        child: Container(
          // Fondo de la cuadrícula con estilo fancy
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(16), // Esquinas redondeadas 
            boxShadow: const [
              BoxShadow(
                color: Colors.black, // Un toquecito de sombra para el drama
                blurRadius: 2, // Difuminado de las sombras, pa' que quede nice
                offset: Offset(0, 5), // Sombras con inclinación, ¡detalle pro!
              ),
            ],
          ),
          // Aquí va la magia de la cuadrícula 3x3
          child: GridView.builder(
            padding: const EdgeInsets.all(8.0), // Espacio entre los bordes y las celdas
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, 
              mainAxisSpacing: 8, // Espaciado entre filas
              crossAxisSpacing: 8, // Espaciado entre columnas
            ),
            itemCount: 9, //9 celdas exactas para jugar
            itemBuilder: (context, index) {
              // Calculamos la fila y columna en base al índice. ¡Geometría básica!
              final row = index ~/ 3; // División entera: índice entre 3
              final col = index % 3; // El resto para encontrar la columna
              final cell = gameState.board[row][col]; // Sacamos el valor de la celda
              
              return GestureDetector(
                // ¡Aquí está la chamba! Al hacer clic en una celda, se hace un movimiento
                onTap: () => context.read<GameProvider>().makeMove(row, col),
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor, // Color del fondo según el tema
                    borderRadius: BorderRadius.circular(12), // Celdas redonditas 
                    border: Border.all(
                      color: Colors.black, // Bordes en color negro para que se vean bien
                      width: 1, // Bordes 
                    ),
                  ),
                  child: Center(
                    // Aquí vive el contenido de cada celda (X, O o vacío)
                    child: Text(
                      cell, // Mostramos si es 'X', 'O', o nada
                      style: TextStyle(
                        fontSize: 48, // ¡Letra tamaño grande para que todos vean!
                        fontWeight: FontWeight.bold, 
                        color: cell == 'X' 
                          ? Theme.of(context).colorScheme.primary // X en color primario
                          : Theme.of(context).colorScheme.secondary, // O en color secundario
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
