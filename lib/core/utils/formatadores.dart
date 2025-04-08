import 'package:intl/intl.dart';
import 'constantes.dart';

class Formatadores {
  static String formatarData(DateTime data) {
    return DateFormat(Constantes.formatoData).format(data);
  }

  static String formatarDataHora(DateTime data) {
    return DateFormat(Constantes.formatoDataHora).format(data);
  }

  //(ex.: "Hoje", "Em 3 dias")
  static String formatarPrazoRelativo(DateTime prazo) {
    final agora = DateTime.now();
    final diferencaDias = prazo.difference(agora).inDays;

    if (diferencaDias == 0) return 'Hoje';
    if (diferencaDias == 1) return 'Amanhã';
    if (diferencaDias == -1) return 'Ontem';
    if (diferencaDias < 0) return '${-diferencaDias} dias atrás';
    return 'Em $diferencaDias dias';
  }

  // Formata texto cortando-o com reticências se exceder o limite
  static String formatarTextoCurto(String texto, {int limite = 100}) {
    if (texto.length <= limite) return texto;
    return '${texto.substring(0, limite - 3)}...';
  }

  // Formata prioridade para exibição (ex.: "BAIXA" -> "Baixa")
  static String formatarPrioridade(String prioridade) {
    return prioridade.toLowerCase().replaceFirst(
      prioridade[0].toLowerCase(),
      prioridade[0].toUpperCase(),
    );
  }

  // Formata número de estrelas para dificuldade (ex.: 3 -> ★★★☆☆)
  static String formatarDificuldade(int dificuldade) {
    const estrelaCheia = '★';
    const estrelaVazia = '☆';
    return estrelaCheia * dificuldade +
        estrelaVazia * (Constantes.dificuldadeMaxima - dificuldade);
  }

  // Converte string de data (dd/MM/yyyy) para DateTime
  static DateTime parseData(String data) {
    final partes = data.split('/');
    if (partes.length != 3) throw FormatException('Formato de data inválido');
    return DateTime(
      int.parse(partes[2]),
      int.parse(partes[1]),
      int.parse(partes[0]),
    );
  }
}
