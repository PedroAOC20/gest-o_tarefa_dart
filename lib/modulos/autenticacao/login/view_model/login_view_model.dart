import 'package:flutter/material.dart';
import '../repository/login_repository.dart';
import '../service/autenticacao_service.dart';

class LoginViewModel extends ChangeNotifier {
  final LoginRepository _repository;
  final AutenticacaoService _service;

  bool _carregando = false;
  String _mensagemErro = '';

  bool get carregando => _carregando;
  String get mensagemErro => _mensagemErro;

  LoginViewModel({
    required LoginRepository repository,
    required AutenticacaoService service,
  }) : _repository = repository,
       _service = service;

  Future<void> login(String email, String senha) async {
    _setCarregando(true);
    _mensagemErro = '';

    try {
      await _repository.login(email, senha);
    } catch (e) {
      _mensagemErro = e.toString();
      rethrow;
    } finally {
      _setCarregando(false);
    }
  }

  Future<void> logout() async {
    await _repository.logout();
    notifyListeners();
  }

  void _setCarregando(bool valor) {
    _carregando = valor;
    notifyListeners();
  }
}
