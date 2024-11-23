import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/game_provider.dart';
import 'screens/game_screen.dart';
import 'config/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => GameProvider(),
      child: Consumer<GameProvider>(
        builder: (context, gameProvider, _) {
          return MaterialApp(
            title: 'Juego del Gato Tic Tac Toe',
            debugShowCheckedModeBanner: false,
            theme: gameProvider.isDarkTheme 
                ? AppTheme.darkTheme  // Tema oscuro por defecto
                : AppTheme.lightTheme,  // Tema claro si el estado lo indica
            home: const GameScreen(),
          );
        },
      ),
    );
  }
}
