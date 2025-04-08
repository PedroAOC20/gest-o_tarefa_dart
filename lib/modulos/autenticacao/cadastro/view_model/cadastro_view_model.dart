import 'package:flutter/material.dart';
import '../../login/service/autenticacao_service.dart';

class CadastroViewModel extends ChangeNotifier {
  final AutenticacaoService _service;
  String _mensagemErro = '';
  bool _carregando = false;

  CadastroViewModel({required AutenticacaoService service})
    : _service = service;

  String get mensagemErro => _mensagemErro;
  bool get carregando => _carregando;

  Future<void> cadastrar({
    required String nome,
    required String email,
    required String telefone, // Adicionado
    required String senha,
  }) async {
    _carregando = true;
    _mensagemErro = '';
    notifyListeners();

    try {
      await _service.cadastrar(
        nome: nome,
        email: email,
        telefone: telefone, // Passando o telefone
        senha: senha,
      );
    } catch (e) {
      _mensagemErro = e.toString();
      rethrow;
    } finally {
      _carregando = false;
      notifyListeners();
    }
  }
}
