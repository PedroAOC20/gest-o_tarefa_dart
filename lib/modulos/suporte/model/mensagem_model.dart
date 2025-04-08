class MensagemModel {
  final String id;
  final String usuarioId;
  final String texto;
  final DateTime enviadoEm;
  bool respondida;
  String? resposta;
  DateTime? respondidoEm;

  MensagemModel({
    required this.id,
    required this.usuarioId,
    required this.texto,
    required this.enviadoEm,
    this.respondida = false,
    this.resposta,
    this.respondidoEm,
  }) {
    if (texto.isEmpty) throw ArgumentError('Texto não pode ser vazio');
  }

  factory MensagemModel.fromMap(Map<String, dynamic> map) {
    return MensagemModel(
      id: map['id'],
      usuarioId: map['usuario_id'],
      texto: map['texto'],
      enviadoEm: DateTime.parse(map['enviado_em']),
      respondida: map['respondida'] == 1,
      resposta: map['resposta'],
      respondidoEm:
          map['respondido_em'] != null
              ? DateTime.parse(map['respondido_em'])
              : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'usuario_id': usuarioId,
      'texto': texto,
      'enviado_em': enviadoEm.toIso8601String(),
      'respondida': respondida ? 1 : 0,
      'resposta': resposta,
      'respondido_em': respondidoEm?.toIso8601String(),
    };
  }

  MensagemModel clone() {
    return MensagemModel(
      id: id,
      usuarioId: usuarioId,
      texto: texto,
      enviadoEm: enviadoEm,
      respondida: respondida,
      resposta: resposta,
      respondidoEm: respondidoEm,
    );
  }
}
