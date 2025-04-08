import 'package:flutter/material.dart';

class EstilosTexto {
  static const TextStyle titulo = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.white,
    letterSpacing: 0.5,
    fontFamily: 'Poppins',
  );

  static const TextStyle tituloAppBar = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: Colors.white,
    letterSpacing: 0.5,
    fontFamily: 'Poppins',
  );

  //Corpo referente ao texto
  static const TextStyle corpo = TextStyle(
    fontSize: 16,
    color: Colors.white,
    letterSpacing: 0.3,
    fontFamily: 'Roboto',
  );

  static const TextStyle corpoMedio = TextStyle(
    fontSize: 14,
    color: Colors.black26,
    letterSpacing: 0.2,
    fontFamily: 'Roboto',
  );

  static const TextStyle botao = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
    fontFamily: 'Poppins',
  );

  static const TextStyle legenda = TextStyle(
    fontSize: 12,
    color: Colors.white60,
    letterSpacing: 0.2,
    fontFamily: 'Roboto',
  );

  static const TextStyle dataHora = TextStyle(
    fontSize: 12,
    color: Colors.white54,
    fontStyle: FontStyle.italic,
    fontFamily: 'Roboto',
  );

  static const TextStyle prioridade = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
    fontFamily: 'Roboto',
  );
}
