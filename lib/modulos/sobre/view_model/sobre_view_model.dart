import 'package:flutter/material.dart';

class Desenvolvedor {
  final String nome;
  final String ra;
  final String imagemAsset;

  Desenvolvedor({
    required this.nome,
    required this.ra,
    required this.imagemAsset,
  });
}

class Tecnologia {
  final String nome;
  final String descricao;
  final IconData icone;

  Tecnologia({
    required this.nome,
    required this.descricao,
    required this.icone,
  });
}

class SobreViewModel {
  static const String nomeAplicativo = 'TASK SOLO';
  static const String versao = 'Versão 1.0.0';
  static const String descricaoProjeto =
      'O Task Solo é um aplicativo de gestão de tarefas inspirado na estética visual do anime Solo Leveling, '
      'focado em proporcionar uma experiência de usuário única e envolvente. '
      'O aplicativo utiliza o método da Matriz de Eisenhower para priorização de tarefas, '
      'permitindo que você organize suas atividades de forma eficiente e visual.';

  static const String direitosAutorais =
      '© 2025 Task Solo. Todos os direitos reservados.';

  static List<Desenvolvedor> get desenvolvedores => [
    Desenvolvedor(
      nome: 'Pedro Augusto de Oliveira Cardoso',
      ra: '837652',
      imagemAsset: 'assets/images/dev_pedro.jpg',
    ),
    Desenvolvedor(
      nome: 'Luiz Felipe Spadaro Goes',
      ra: '837695',
      imagemAsset: 'assets/images/dev_luiz.jpg',
    ),
  ];

  static List<Tecnologia> get tecnologias => [
    Tecnologia(
      nome: 'Flutter',
      descricao: 'Framework multiplataforma para desenvolvimento mobile',
      icone: Icons.flutter_dash,
    ),
    Tecnologia(
      nome: 'Dart',
      descricao: 'Linguagem de programação',
      icone: Icons.code,
    ),
    Tecnologia(
      nome: 'Visual Studio Code',
      descricao: 'IDE utilizada para desenvolvimento',
      icone: Icons.code,
    ),
    Tecnologia(
      nome: 'Provider',
      descricao: 'Gerenciamento de estado',
      icone: Icons.refresh,
    ),
  ];
}
