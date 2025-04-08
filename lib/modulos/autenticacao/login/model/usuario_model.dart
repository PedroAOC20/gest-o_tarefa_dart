class UsuarioModel {
  final String id;
  final String nome;
  final String email;
  final String telefone;
  final String? imagemUrl;
  final DateTime criadoEm;

  UsuarioModel({
    required this.id,
    required this.nome,
    required this.email,
    required this.telefone,
    this.imagemUrl,
    required this.criadoEm,
  }) {
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
      throw ArgumentError('Email inválido');
    }
  }

  factory UsuarioModel.fromMap(Map<String, dynamic> map) {
    return UsuarioModel(
      id: map['id'],
      nome: map['nome'],
      email: map['email'],
      telefone: map['telefone'],
      imagemUrl: map['imagem_url'],
      criadoEm: DateTime.parse(map['criado_em']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'email': email,
      'telefone': telefone,
      'imagem_url': imagemUrl,
      'criado_em': criadoEm.toIso8601String(),
    };
  }
}
