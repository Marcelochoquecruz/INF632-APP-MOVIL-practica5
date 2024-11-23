import 'package:flutter/material.dart';

// Clase que define los temas personalizados de la aplicación
class AppTheme {
  // Tema claro (light theme)
  static final lightTheme = ThemeData(
    // Color principal utilizado en la aplicación (e.g., barras de herramientas, botones)
    primaryColor: Colors.blue,
    // Color de fondo principal para pantallas y widgets Scaffold
    scaffoldBackgroundColor: Colors.white,
    // Esquema de colores específico para el tema claro
    colorScheme: const ColorScheme.light(
      primary: Colors.blue, // Color principal para elementos interactivos
      secondary: Colors.orange, // Color secundario, usado para resaltar
    ),
    // Estilos de texto predeterminados para el tema claro
    textTheme: const TextTheme(
      headlineMedium: TextStyle(
        color: Colors.black, // Color del texto para encabezados
        fontSize: 28, // Tamaño del texto del encabezado
        fontWeight: FontWeight.bold, // Peso de fuente para resaltar
      ),
      bodyLarge: TextStyle(
        color: Colors.black87, // Color del texto para contenido general
        fontSize: 18, // Tamaño del texto estándar
      ),
    ),
  );

  // Tema oscuro (dark theme)
  static final darkTheme = ThemeData(
    // Color principal utilizado en la aplicación (e.g., barras de herramientas, botones)
    primaryColor: const Color(0xFF6C63FF), // Un tono púrpura moderno
    // Color de fondo principal para pantallas y widgets Scaffold
    scaffoldBackgroundColor: const Color(0xFF1A1A2E), // Fondo oscuro para menos fatiga visual
    // Esquema de colores específico para el tema oscuro
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF6C63FF), // Color principal en el tema oscuro
      secondary: Color(0xFFFF6584), // Color secundario vibrante para contrastar
      surface: Color(0xFF252A34), // Color de fondo para tarjetas y superficies
    ),
    // Estilos de texto predeterminados para el tema oscuro
    textTheme: const TextTheme(
      headlineMedium: TextStyle(
        color: Colors.white, // Color blanco para encabezados
        fontSize: 28, // Tamaño del texto del encabezado
        fontWeight: FontWeight.bold, // Peso de fuente para resaltar
      ),
      bodyLarge: TextStyle(
        color: Colors.white70, // Color ligeramente desaturado para texto estándar
        fontSize: 18, // Tamaño del texto estándar
      ),
    ),
  );
}
