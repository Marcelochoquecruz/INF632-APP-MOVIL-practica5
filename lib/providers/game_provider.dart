import 'package:flutter/material.dart';
import '../models/game_state.dart';

// Clase GameProvider que gestiona el estado del juego y notifica a los widgets cuando hay cambios
class GameProvider extends ChangeNotifier {
  // Estado interno del juego
  GameState _gameState = GameState();
  GameState get gameState => _gameState; // Getter para acceder al estado del juego

  // Controlador para el tema (oscuro por defecto)
  bool _isDarkTheme = true;
  bool get isDarkTheme => _isDarkTheme; // Getter para saber si el tema es oscuro

  // Método para alternar entre el tema oscuro y claro
  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme; // Cambia el valor entre true (oscuro) y false (claro)
    notifyListeners(); // Notifica a los listeners (widgets) para que se actualicen
  }

  // Realiza un movimiento en la posición especificada del tablero
  void makeMove(int row, int col) {
    // Verifica que la celda esté vacía y que el juego no haya terminado
    if (_gameState.board[row][col].isEmpty && !_gameState.gameOver) {
      // Crea una copia del tablero actual
      final newBoard = List<List<String>>.from(_gameState.board);
      // Marca la celda con el jugador actual
      newBoard[row][col] = _gameState.currentPlayer;

      // Actualiza el estado del juego, cambiando el turno al otro jugador
      _gameState = _gameState.copyWith(
        board: newBoard,
        currentPlayer: _gameState.currentPlayer == 'X' ? 'O' : 'X',
      );

      // Verifica si hay un ganador o un empate después del movimiento
      checkWinner();
      notifyListeners(); // Notifica a los widgets para que se actualicen
    }
  }

  // Verifica si hay un ganador, un empate, o si el juego continúa
  void checkWinner() {
    // Verifica las filas
    for (int i = 0; i < 3; i++) {
      if (_gameState.board[i][0] != '' &&
          _gameState.board[i][0] == _gameState.board[i][1] &&
          _gameState.board[i][1] == _gameState.board[i][2]) {
        _setWinner(_gameState.board[i][0]); // Establece el ganador
        return;
      }
    }

    // Verifica las columnas
    for (int i = 0; i < 3; i++) {
      if (_gameState.board[0][i] != '' &&
          _gameState.board[0][i] == _gameState.board[1][i] &&
          _gameState.board[1][i] == _gameState.board[2][i]) {
        _setWinner(_gameState.board[0][i]); // Establece el ganador
        return;
      }
    }

    // Verifica las diagonales
    if (_gameState.board[0][0] != '' &&
        _gameState.board[0][0] == _gameState.board[1][1] &&
        _gameState.board[1][1] == _gameState.board[2][2]) {
      _setWinner(_gameState.board[0][0]); // Establece el ganador
      return;
    }

    if (_gameState.board[0][2] != '' &&
        _gameState.board[0][2] == _gameState.board[1][1] &&
        _gameState.board[1][1] == _gameState.board[2][0]) {
      _setWinner(_gameState.board[0][2]); // Establece el ganador
      return;
    }

    // Verifica si todas las celdas están llenas (empate)
    bool isDraw = _gameState.board.every((row) => row.every((cell) => cell.isNotEmpty));
    if (isDraw) {
      _gameState = _gameState.copyWith(
        gameOver: true, // Marca el juego como terminado
        winner: 'Draw', // Indica que fue un empate
      );
      notifyListeners(); // Notifica a los widgets
    }
  }

  // Establece el ganador y actualiza las puntuaciones
  void _setWinner(String winner) {
    _gameState = _gameState.copyWith(
      gameOver: true, // Marca el juego como terminado
      winner: winner, // Establece el ganador
      // Actualiza la puntuación del jugador ganador
      playerXScore: winner == 'X' ? _gameState.playerXScore + 1 : _gameState.playerXScore,
      playerOScore: winner == 'O' ? _gameState.playerOScore + 1 : _gameState.playerOScore,
    );
    notifyListeners(); // Notifica a los widgets
  }

  // Reinicia el tablero para un nuevo juego, pero conserva las puntuaciones
  void resetGame() {
    _gameState = _gameState.copyWith(
      board: List.generate(3, (_) => List.filled(3, '')), // Reinicia el tablero vacío
      currentPlayer: 'X', // El jugador X comienza
      gameOver: false, // Indica que el juego no ha terminado
      winner: '', // No hay ganador al inicio
    );
    notifyListeners(); // Notifica a los widgets
  }

  // Reinicia las puntuaciones de ambos jugadores
  void resetScores() {
    _gameState = _gameState.copyWith(
      playerXScore: 0, // Reinicia la puntuación del jugador X
      playerOScore: 0, // Reinicia la puntuación del jugador O
    );
    notifyListeners(); // Notifica a los widgets
  }
}
