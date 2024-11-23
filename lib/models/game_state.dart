// Modelo que representa el estado del juego
class GameState {
  // Tablero del juego (matriz de 3x3 que almacena "X", "O" o cadenas vacías)
  List<List<String>> board;

  // Jugador actual (puede ser "X" o "O")
  String currentPlayer;

  // Indica si el juego ha terminado
  bool gameOver;

  // Nombre del ganador ("X", "O", o "Draw" si fue empate)
  String winner;

  // Puntuación del jugador X
  int playerXScore;

  // Puntuación del jugador O
  int playerOScore;

  // Constructor que inicializa el estado del juego con valores predeterminados
  GameState({
    List<List<String>>? board, // Tablero inicial (opcional, por defecto es un tablero vacío)
    this.currentPlayer = 'X', // Por defecto, el jugador X empieza
    this.gameOver = false, // Por defecto, el juego no ha terminado
    this.winner = '', // Por defecto, no hay ganador
    this.playerXScore = 0, // Puntuación inicial del jugador X
    this.playerOScore = 0, // Puntuación inicial del jugador O
  }) : board = board ?? List.generate(3, (_) => List.filled(3, '')); // Si no se proporciona un tablero, se genera uno vacío

  // Método para crear una nueva instancia de GameState copiando el estado actual,
  // pero permitiendo modificar algunos valores.
  GameState copyWith({
    List<List<String>>? board, // Nuevo tablero (opcional)
    String? currentPlayer, // Nuevo jugador actual (opcional)
    bool? gameOver, // Nuevo estado del juego (opcional)
    String? winner, // Nuevo ganador (opcional)
    int? playerXScore, // Nueva puntuación del jugador X (opcional)
    int? playerOScore, // Nueva puntuación del jugador O (opcional)
  }) {
    return GameState(
      // Si se proporciona un valor, lo usa; de lo contrario, mantiene el valor actual
      board: board ?? this.board,
      currentPlayer: currentPlayer ?? this.currentPlayer,
      gameOver: gameOver ?? this.gameOver,
      winner: winner ?? this.winner,
      playerXScore: playerXScore ?? this.playerXScore,
      playerOScore: playerOScore ?? this.playerOScore,
    );
  }
}
