import 'package:flutter/material.dart';
import '../../modulos/autenticacao/login/view/login_page.dart';
import '../../modulos/autenticacao/cadastro/view/cadastro_page.dart';
import '../../modulos/autenticacao/recuperar_senha/view/recuperar_senha_page.dart';
import '../../modulos/sobre/view/sobre_page.dart';
import '../../modulos/suporte/view/suporte_page.dart';
import '../../modulos/tarefas/view/listar_tarefas_page.dart';
import '../../modulos/tarefas/view/criar_tarefa_page.dart';
import '../../modulos/tarefas/view/tarefas_hoje_page.dart';
import '../../modulos/tarefas/view/tarefas_7dias_page.dart';
import '../../modulos/tarefas/view/tarefas_15dias_page.dart';
import '../../modulos/tarefas/view/tarefas_concluidas_page.dart';
import '../../modulos/tarefas/view/matriz_eisenhower_page.dart';

class RotasApp {
  static const String inicial = '/login';
  static const String login = '/login';
  static const String cadastro = '/cadastro';
  static const String recuperarSenha = '/recuperar-senha';
  static const String sobre = '/sobre';
  static const String suporte = '/suporte';
  static const String listarTarefas = '/listar-tarefas';
  static const String criarTarefa = '/criar-tarefa';
  static const String tarefasHoje = '/tarefas-hoje';
  static const String tarefas7Dias = '/tarefas-7dias';
  static const String tarefas15Dias = '/tarefas-15dias';
  static const String tarefasConcluidas = '/tarefas-concluidas';
  static const String matrizEisenhower = '/matriz-eisenhower';

  static Map<String, WidgetBuilder> getRotas() {
    return {
      login: (context) => const LoginPage(),
      cadastro: (context) => const CadastroPage(),
      recuperarSenha: (context) => const RecuperarSenhaPage(),
      sobre: (context) => const SobrePage(),
      suporte: (context) => const SuportePage(),
      listarTarefas: (context) => const ListarTarefasPage(),
      criarTarefa: (context) => const CriarTarefaPage(),
      tarefasHoje: (context) => const TarefasHojePage(),
      tarefas7Dias: (context) => const Tarefas7DiasPage(),
      tarefas15Dias: (context) => const Tarefas15DiasPage(),
      tarefasConcluidas: (context) => const TarefasConcluidasPage(),
      matrizEisenhower: (context) => const MatrizEisenhowerPage(),
    };
  }
}
