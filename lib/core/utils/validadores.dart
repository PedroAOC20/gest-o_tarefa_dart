class Validadores {
  static String? validarCampoObrigatorio(String? value, String campo) {
    if (value == null || value.isEmpty) {
      return 'Por favor, digite o $campo';
    }
    return null;
  }

  static String? validarEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, digite seu e-mail';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Por favor, digite um e-mail válido';
    }
    return null;
  }

  static String? validarSenha(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, digite sua senha';
    }
    if (value.length < 6) {
      return 'A senha deve ter pelo menos 6 caracteres';
    }
    return null;
  }

  static String? validarTelefone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, digite seu telefone';
    }
    final telefoneRegex = RegExp(r'^\d{10,11}$');
    if (!telefoneRegex.hasMatch(value)) {
      return 'Digite um telefone válido (ex.: 11999999999)';
    }
    return null;
  }
}
