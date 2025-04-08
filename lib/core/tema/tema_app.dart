import 'package:flutter/material.dart';
import 'cores.dart';
import 'estilos_texto.dart';

class TemaApp {
  static final ThemeData temaEscuro = ThemeData(
    scaffoldBackgroundColor: Cores.fundoPrincipal,
    appBarTheme: AppBarTheme(
      backgroundColor: Cores.fundoPrincipal,
      elevation: 0,
      titleTextStyle: EstilosTexto.tituloAppBar,
      iconTheme: IconThemeData(color: Colors.white),
    ),
    textTheme: TextTheme(
      displayLarge: EstilosTexto.titulo,
      bodyLarge: EstilosTexto.corpo,
      bodyMedium: EstilosTexto.corpoMedio,
      labelLarge: EstilosTexto.botao,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Cores.azulDestaque,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        textStyle: EstilosTexto.botao,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Cores.fundoInput,
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Cores.bordaInput, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Cores.azulDestaque, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Cores.urgente, width: 1),
      ),
      hintStyle: TextStyle(color: Colors.white54),
      labelStyle: TextStyle(color: Colors.white70),
    ),
    colorScheme: ColorScheme.dark(
      primary: Cores.azulDestaque,
      secondary: Cores.importante,
      error: Cores.urgente,
    ),
    cardTheme: CardTheme(
      color: Cores.fundoCard,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Cores.bordaCard, width: 1),
      ),
    ),
    dividerTheme: DividerThemeData(color: Cores.divider, thickness: 1),
  );
}
