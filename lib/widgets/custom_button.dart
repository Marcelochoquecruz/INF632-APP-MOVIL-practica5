import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed; // Acción que ejecuta el botón
  final String label; // Texto que aparece en el botón
  final IconData icon; // Ícono que acompaña al texto del botón
  final Color backgroundColor; // Color de fondo del botón
  final Color textColor; // Color del texto

  const CustomButton({
    super.key,
    required this.onPressed,
    required this.label,
    required this.icon,
    required this.backgroundColor,  // Agregado para customizar colores
    required this.textColor,        // Agregado para customizar colores
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed, // Asignación de la acción al botón
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor, // Fondo personalizado
        foregroundColor: textColor,        // Texto en color blanco o cualquier color
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12), // Espaciado interno
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25), // Bordes redondeados
        ),
        elevation: 3, // Sombra para un efecto ligero
      ),
      icon: Icon(
        icon,
        size: 20, // Tamaño del ícono ajustado
      ),
      label: Text(
        label, // Texto del botón
        style: TextStyle(
          fontSize: 16, // Tamaño de fuente legible
          fontWeight: FontWeight.w600, // Peso semi-negrita para un mejor énfasis
        ),
      ),
    );
  }
}
