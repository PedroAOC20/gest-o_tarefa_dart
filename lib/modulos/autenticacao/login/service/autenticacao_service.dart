import 'package:shared_preferences/shared_preferences.dart';

class AutenticacaoService {
  static const String _chaveUsuarioLogado = 'usuario_logado';
  static const String _chaveEmailUsuario = 'email_usuario';

  var usuarioAtual;

  Future<void> cadastrar({
    required String nome,
    required String email,
    required String senha,
    String? telefone, // Adicionado para suportar telefone
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_chaveEmailUsuario, email);
    await prefs.setBool(_chaveUsuarioLogado, true);
    if (telefone != null) {
      await prefs.setString('telefone_usuario', telefone);
    }
  }

  Future<void> login({required String email, required String senha}) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_chaveEmailUsuario, email);
    await prefs.setBool(_chaveUsuarioLogado, true);
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_chaveEmailUsuario);
    await prefs.remove('telefone_usuario');
    await prefs.setBool(_chaveUsuarioLogado, false);
  }

  Future<bool> estaLogado() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_chaveUsuarioLogado) ?? false;
  }

  Future<String?> getEmailUsuario() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_chaveEmailUsuario);
  }

  Future<bool> verificarEmailExistente(String email) async {
    final prefs = await SharedPreferences.getInstance();
    final emailSalvo = prefs.getString(_chaveEmailUsuario);
    return emailSalvo == email;
  }
}
