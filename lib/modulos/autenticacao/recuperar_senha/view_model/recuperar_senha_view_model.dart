import 'package:flutter/material.dart';
import '../../login/service/autenticacao_service.dart';

class RecuperarSenhaViewModel extends ChangeNotifier {
  final AutenticacaoService _autenticacaoService;

  bool _carregando = false;
  String _mensagemErro = '';
  String _mensagemSucesso = '';

  bool get carregando => _carregando;
  String get mensagemErro => _mensagemErro;
  String get mensagemSucesso => _mensagemSucesso;

  RecuperarSenhaViewModel({required AutenticacaoService autenticacaoService})
    : _autenticacaoService = autenticacaoService;

  Future<void> recuperarSenha(String email) async {
    _setCarregando(true);
    _mensagemErro = '';
    _mensagemSucesso = '';

    try {
      if (!await _autenticacaoService.verificarEmailExistente(email)) {
        throw Exception('E-mail não encontrado');
      }
      // Simula envio de e-mail
      await Future.delayed(const Duration(milliseconds: 1000));
      _mensagemSucesso = 'Instruções de recuperação enviadas para $email';
    } catch (e) {
      _mensagemErro = e.toString();
    } finally {
      _setCarregando(false);
    }
  }

  void _setCarregando(bool valor) {
    _carregando = valor;
    notifyListeners();
  }
}
