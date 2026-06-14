import 'package:flutter/material.dart';

class AppTheme {
  // colores institucionales
  static const Color azulOscuro = Color(0xFF003366);
  static const Color azulClaro = Color(0xFF0066B3);
  static const Color azulMarino = Color(0xFF0C1B2A);

  // colores emergencias
  static const Color emergenciaSalud = Color(0xFF003366);
  static const Color emergenciaBomberos = Color(0xFFFF0000);
  static const Color emergenciaSeguridad = Color(0xFFFFDE21);

  static const Color blanco = Color(0xFFFFFFFF);
  static const Color negro = Color(0xFF000000);
  static const Color grisFondo = Color(0xFFF5F5F5);

  // tema claro
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: azulOscuro,
      scaffoldBackgroundColor: grisFondo,
      fontFamily: 'Prompt',

      // estilo appbar
      appBarTheme: const AppBarTheme(
        backgroundColor: azulOscuro,
        foregroundColor: blanco,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontFamily: 'Prompt',
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: blanco,
        ),
      ),

      // estilo tarjetas
      cardTheme: const CardThemeData(
        color: blanco,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),

      
      // estilo botones
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: azulOscuro,
          foregroundColor: blanco,
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          textStyle: const TextStyle(
            fontFamily: 'Prompt',
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),

      // estilo textos
      textTheme: const TextTheme(
        displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.w700, color: azulOscuro),
        titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: azulOscuro),
        bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: negro),
        bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: azulMarino),
      ),

      // estilo inputs
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: blanco,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: azulClaro),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: azulClaro, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: azulOscuro, width: 2),
        ),
        labelStyle: const TextStyle(color: azulOscuro, fontFamily: 'Prompt'),
      ),
    );
  }

  // estilo botones emergencias
  static ButtonStyle estiloBotonEmergencia(Color colorFondo, Color colorTexto) {
    return ElevatedButton.styleFrom(
      backgroundColor: colorFondo,
      foregroundColor: colorTexto,
      elevation: 6,
      shadowColor: colorFondo.withOpacity(0.4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
    );
  }
}