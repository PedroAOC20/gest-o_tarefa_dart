import '../model/mensagem_model.dart';

class SuporteRepository {
  final List<MensagemModel> _mensagens = [];

  SuporteRepository() {
    _adicionarMensagemInicial();
  }

  void _adicionarMensagemInicial() {
    _mensagens.add(
      MensagemModel(
        id: '1',
        usuarioId: '1', // Usuário de teste
        texto: 'Preciso de ajuda com o login',
        enviadoEm: DateTime.now().subtract(const Duration(days: 1)),
      ),
    );
  }

  Future<MensagemModel> enviarMensagem(MensagemModel mensagem) async {
    await Future.delayed(const Duration(milliseconds: 300)); // Simula latência
    _mensagens.add(mensagem);
    return mensagem;
  }

  Future<List<MensagemModel>> listarMensagens(String usuarioId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return _mensagens.where((m) => m.usuarioId == usuarioId).toList();
  }

  Future<MensagemModel> responderMensagem(
    String mensagemId,
    String resposta,
  ) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final index = _mensagens.indexWhere((m) => m.id == mensagemId);
    if (index == -1) {
      throw Exception('Mensagem não encontrada');
    }
    final mensagemAtualizada =
        _mensagens[index].clone()
          ..respondida = true
          ..resposta = resposta
          ..respondidoEm = DateTime.now();
    _mensagens[index] = mensagemAtualizada;
    return mensagemAtualizada;
  }
}
