import '../service/autenticacao_service.dart';

class LoginRepository {
  final AutenticacaoService _autenticacaoService;

  LoginRepository(
    this._autenticacaoService, {
    required AutenticacaoService autenticacaoService,
  });

  Future<void> login(String email, String senha) async {
    return await _autenticacaoService.login(email: email, senha: senha);
  }

  Future<void> logout() async {
    return await _autenticacaoService.logout();
  }
}
