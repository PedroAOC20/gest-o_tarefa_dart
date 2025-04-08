import 'package:flutter/material.dart';
import '../../../core/tema/cores.dart';

enum Prioridade { baixa, importante, urgente }

class TarefaModel {
  final String id;
  String titulo;
  String descricao;
  bool concluido;
  DateTime prazo;
  Prioridade prioridade;
  int dificuldade; // 1 a 5 estrelas
  final DateTime criadoEm;
  DateTime modificadoEm;

  TarefaModel({
    required this.id,
    required this.titulo,
    required this.descricao,
    this.concluido = false,
    required this.prazo,
    this.prioridade = Prioridade.baixa,
    this.dificuldade = 1,
    required this.criadoEm,
    required this.modificadoEm,
  }) {
    if (titulo.isEmpty) throw ArgumentError('Título não pode ser vazio');
    if (dificuldade < 1 || dificuldade > 5)
      throw RangeError('Dificuldade deve ser entre 1 e 5');
  }

  factory TarefaModel.fromMap(Map<String, dynamic> map) {
    return TarefaModel(
      id: map['id'],
      titulo: map['titulo'],
      descricao: map['descricao'],
      concluido: map['concluido'] == 1,
      prazo: DateTime.parse(map['prazo']),
      prioridade: Prioridade.values[map['prioridade']],
      dificuldade: map['dificuldade'],
      criadoEm: DateTime.parse(map['criado_em']),
      modificadoEm: DateTime.parse(map['modificado_em']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titulo': titulo,
      'descricao': descricao,
      'concluido': concluido ? 1 : 0,
      'prazo': prazo.toIso8601String(),
      'prioridade': prioridade.index,
      'dificuldade': dificuldade,
      'criado_em': criadoEm.toIso8601String(),
      'modificado_em': modificadoEm.toIso8601String(),
    };
  }

  Color get corPrioridade {
    switch (prioridade) {
      case Prioridade.baixa:
        return Cores.baixaPrioridade;
      case Prioridade.importante:
        return Cores.importante;
      case Prioridade.urgente:
        return Cores.urgente;
    }
  }

  bool get estaPrestes {
    final agora = DateTime.now();
    final diferenca = prazo.difference(agora).inDays;
    return diferenca <= 1 && !concluido;
  }

  bool get estaAtrasada {
    final agora = DateTime.now();
    return prazo.isBefore(agora) && !concluido;
  }

  // Classificação Eisenhower
  String? _eisenhowerCache;
  String get classificacaoEisenhower {
    _eisenhowerCache ??= () {
      bool eUrgente =
          prioridade == Prioridade.urgente || estaPrestes || estaAtrasada;
      bool eImportante =
          dificuldade >= 3 || prioridade == Prioridade.importante;
      if (eUrgente && eImportante) return "Urgente e Importante";
      if (eUrgente && !eImportante) return "Urgente e Não Importante";
      if (!eUrgente && eImportante) return "Não Urgente e Importante";
      return "Não Urgente e Não Importante";
    }();
    return _eisenhowerCache!;
  }

  TarefaModel clone() {
    return TarefaModel(
      id: id,
      titulo: titulo,
      descricao: descricao,
      concluido: concluido,
      prazo: prazo,
      prioridade: prioridade,
      dificuldade: dificuldade,
      criadoEm: criadoEm,
      modificadoEm: modificadoEm,
    );
  }

  // Novo método copyWith
  TarefaModel copyWith({
    String? id,
    String? titulo,
    String? descricao,
    bool? concluido,
    DateTime? prazo,
    Prioridade? prioridade,
    int? dificuldade,
    DateTime? criadoEm,
    DateTime? modificadoEm,
  }) {
    return TarefaModel(
      id: id ?? this.id,
      titulo: titulo ?? this.titulo,
      descricao: descricao ?? this.descricao,
      concluido: concluido ?? this.concluido,
      prazo: prazo ?? this.prazo,
      prioridade: prioridade ?? this.prioridade,
      dificuldade: dificuldade ?? this.dificuldade,
      criadoEm: criadoEm ?? this.criadoEm,
      modificadoEm: modificadoEm ?? this.modificadoEm,
    );
  }
}
