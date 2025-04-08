class Constantes {
  // Tamanhos e espaçamentos padrão
  static const double paddingPadrao = 16.0;
  static const double margemPequena = 8.0;
  static const double margemGrande = 24.0;
  static const double tamanhoIconePadrao = 24.0;
  static const double elevacaoCard = 4.0;

  static const Duration duracaoAnimacao = Duration(milliseconds: 300);
  static const Duration latenciaSimulada = Duration(milliseconds: 500);

  static const String chaveUsuarioLogado = 'usuario_logado';
  static const String chaveTemaEscuro = 'tema_escuro';

  // Mensagens padrão
  static const String erroGenerico = 'Ocorreu um erro inesperado';
  static const String semConexao = 'Sem conexão com a internet';
  static const String operacaoSucesso = 'Operação realizada com sucesso';

  static const String caminhoImagemFundo = 'assets/images/solo_leveling_bg.jpg';
  static const String caminhoLogo = 'assets/images/solo_task_logo.png';

  static const int limiteTamanhoTexto = 500;
  static const int dificuldadeMinima = 1;
  static const int dificuldadeMaxima = 5;

  static const String formatoData = 'dd/MM/yyyy';
  static const String formatoDataHora = 'dd/MM/yyyy HH:mm';
}
