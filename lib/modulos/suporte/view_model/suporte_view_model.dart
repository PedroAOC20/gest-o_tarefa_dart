import 'package:flutter/material.dart';
import 'package:gestor_tarefa/modulos/suporte/repository/suporte_repository.dart';
import '../../autenticacao/login/service/autenticacao_service.dart';

class SuporteViewModel extends ChangeNotifier {
  final AutenticacaoService _autenticacaoService;
  String _mensagemErro = '';
  bool _carregando = false;

  SuporteViewModel({
    required AutenticacaoService autenticacaoService,
    required usuarioAtual,
    required SuporteRepository repository,
  }) : _autenticacaoService = autenticacaoService;

  String get mensagemErro => _mensagemErro;
  bool get carregando => _carregando;

  Future<void> enviarMensagem(String trim, {required String mensagem}) async {
    _carregando = true;
    _mensagemErro = '';
    notifyListeners();

    try {
      // Verifica se o usuário está logado
      final estaLogado = await _autenticacaoService.estaLogado();
      if (!estaLogado) {
        throw Exception('Usuário não está logado');
      }

      // Obtém o e-mail do usuário logado
      final emailUsuario = await _autenticacaoService.getEmailUsuario();
      if (emailUsuario == null) {
        throw Exception('Não foi possível obter o e-mail do usuário');
      }

      // Simula o envio da mensagem (substitua por sua lógica real, ex.: API)
      await Future.delayed(const Duration(milliseconds: 500));
      print('Mensagem enviada: $mensagem, por $emailUsuario');
    } catch (e) {
      _mensagemErro = e.toString().replaceFirst('Exception: ', '');
      rethrow;
    } finally {
      _carregando = false;
      notifyListeners();
    }
  }
}
