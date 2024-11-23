import 'package:flutter/material.dart';
import 'dart:math';

class ScreenPcGame extends StatefulWidget {
  const ScreenPcGame({super.key});

  @override
  State<ScreenPcGame> createState() => _ScreenPcGameState();
}

class _ScreenPcGameState extends State<ScreenPcGame> {
  List<String> board = List.filled(9, '');
  bool isPlayerTurn = true;
  bool gameOver = false;
  String winner = '';
  int playerScore = 0;
  int pcScore = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60), // AppBar más grande
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
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
          title: const Text(
            'Tic Tac Toe',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white, // Título en blanco para contraste
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white), // Icono blanco para buen contraste
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF4A00E0),
              Color(0xFF8E2DE2),
            
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Marcador con diseño mejorado
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white24),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildScoreColumn('JUGADOR', playerScore, 'X'),
                    Container(
                      height: 40,
                      width: 1,
                      color: Colors.white24,
                    ),
                    _buildScoreColumn('CPU', pcScore, 'O'),
                  ],
                ),
              ),

              // Tablero de juego
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                      ),
                      itemCount: 9,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () => _makeMove(index),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: Colors.white24),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 5,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                board[index],
                                style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  color: board[index] == 'X'
                                      ? Colors.white
                                      : const Color(0xFF00C9FF),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),

              // Estado del juego
              Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                decoration: BoxDecoration(
                  color: gameOver
                      ? (winner.isEmpty ? Colors.orange.withOpacity(0.2) : Colors.green.withOpacity(0.2))
                      : Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  gameOver
                      ? winner.isEmpty
                          ? '¡EMPATE!'
                          : '¡${winner.toUpperCase()} GANA!'
                      : 'TURNO: ${isPlayerTurn ? "JUGADOR" : "CPU"}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),

              // Botones de reinicio
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: _resetGame,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white.withOpacity(0.2),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        elevation: 0,
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.gamepad),
                          SizedBox(width: 8),
                          Text(
                            'NUEVO JUEGO',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _resetScores,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white.withOpacity(0.2),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        elevation: 0,
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.games_sharp),
                          SizedBox(width: 8),
                          Text(
                            'REINICIAR PUNTAJES',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
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

  Widget _buildScoreColumn(String label, int score, String symbol) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.white70,
          ),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Text(
              symbol,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: symbol == 'X' ? Colors.white : const Color(0xFF00C9FF),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              score.toString(),
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _makeMove(int index) {
    if (board[index].isEmpty && !gameOver && isPlayerTurn) {
      setState(() {
        board[index] = 'X';
        isPlayerTurn = false;
        _checkWinner();
        if (!gameOver) {
          _pcMove();
        }
      });
    }
  }

  void _pcMove() {
    Future.delayed(const Duration(milliseconds: 500), () {
      if (!gameOver) {
        int bestMove = _findBestMove();
        setState(() {
          board[bestMove] = 'O';
          isPlayerTurn = true;
          _checkWinner();
        });
      }
    });
  }

  int _findBestMove() {
    for (int i = 0; i < 9; i++) {
      if (board[i].isEmpty) {
        board[i] = 'O';
        if (_checkWinningCondition('O')) {
          board[i] = '';
          return i;
        }
        board[i] = '';
      }
    }

    for (int i = 0; i < 9; i++) {
      if (board[i].isEmpty) {
        board[i] = 'X';
        if (_checkWinningCondition('X')) {
          board[i] = '';
          return i;
        }
        board[i] = '';
      }
    }

    if (board[4].isEmpty) return 4;

    List<int> corners = [0, 2, 6, 8];
    corners.shuffle();
    for (int corner in corners) {
      if (board[corner].isEmpty) return corner;
    }

    List<int> availableMoves = [];
    for (int i = 0; i < 9; i++) {
      if (board[i].isEmpty) availableMoves.add(i);
    }
    if (availableMoves.isNotEmpty) {
      return availableMoves[Random().nextInt(availableMoves.length)];
    }

    return 0;
  }

  bool _checkWinningCondition(String player) {
    for (int i = 0; i < 9; i += 3) {
      if (board[i] == player &&
          board[i + 1] == player &&
          board[i + 2] == player) {
        return true;
      }
    }

    for (int i = 0; i < 3; i++) {
      if (board[i] == player &&
          board[i + 3] == player &&
          board[i + 6] == player) {
        return true;
      }
    }

    if (board[0] == player && board[4] == player && board[8] == player) {
      return true;
    }
    if (board[2] == player && board[4] == player && board[6] == player) {
      return true;
    }

    return false;
  }

  void _checkWinner() {
    if (_checkWinningCondition('X')) {
      setState(() {
        gameOver = true;
        winner = 'Jugador';
        playerScore++;
      });
    } else if (_checkWinningCondition('O')) {
      setState(() {
        gameOver = true;
        winner = 'CPU';
        pcScore++;
      });
    } else if (!board.contains('')) {
      setState(() {
        gameOver = true;
        winner = ''; // Es un empate
      });
    }
  }

  void _resetGame() {
    setState(() {
      board = List.filled(9, '');
      gameOver = false;
      winner = '';
      isPlayerTurn = true;
    });
  }

  void _resetScores() {
    setState(() {
      playerScore = 0;
      pcScore = 0;
    });
  }
}
