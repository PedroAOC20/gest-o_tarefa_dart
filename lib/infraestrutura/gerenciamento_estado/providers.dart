import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../modulos/autenticacao/cadastro/view_model/cadastro_view_model.dart';
import '../../modulos/autenticacao/login/repository/login_repository.dart';
import '../../modulos/autenticacao/login/service/autenticacao_service.dart';
import '../../modulos/autenticacao/login/view_model/login_view_model.dart';
import '../../modulos/autenticacao/recuperar_senha/view_model/recuperar_senha_view_model.dart';
import '../../modulos/suporte/repository/suporte_repository.dart';
import '../../modulos/suporte/view_model/suporte_view_model.dart';
import '../../modulos/tarefas/repository/tarefa_repository.dart';
import '../../modulos/tarefas/service/tarefa_service.dart';
import '../../modulos/tarefas/view_model/criar_tarefa_view_model.dart';
import '../../modulos/tarefas/view_model/filtro_tarefas_view_model.dart';
import '../../modulos/tarefas/view_model/listar_tarefas_view_model.dart';
import '../../modulos/tarefas/view_model/matriz_eisenhower_view_model.dart';

class Providers {
  static MultiProvider configurarProviders({required Widget child}) {
    return MultiProvider(
      providers: [
        Provider<AutenticacaoService>(create: (_) => AutenticacaoService()),
        Provider<LoginRepository>(
          create:
              (context) => LoginRepository(
                Provider.of<AutenticacaoService>(context, listen: false),
                autenticacaoService: Provider.of<AutenticacaoService>(
                  context,
                  listen: false,
                ),
              ),
        ),
        ChangeNotifierProvider<LoginViewModel>(
          create:
              (context) => LoginViewModel(
                repository: Provider.of<LoginRepository>(
                  context,
                  listen: false,
                ),
                service: Provider.of<AutenticacaoService>(
                  context,
                  listen: false,
                ),
              ),
        ),
        ChangeNotifierProvider<RecuperarSenhaViewModel>(
          create:
              (context) => RecuperarSenhaViewModel(
                autenticacaoService: Provider.of<AutenticacaoService>(
                  context,
                  listen: false,
                ),
              ),
        ),
        // Adicionando o CadastroViewModel
        ChangeNotifierProvider<CadastroViewModel>(
          create:
              (context) => CadastroViewModel(
                service: Provider.of<AutenticacaoService>(
                  context,
                  listen: false,
                ),
              ),
        ),
        // Tarefas
        Provider<TarefaRepository>(create: (_) => TarefaRepository()),
        Provider<TarefaService>(
          create:
              (context) => TarefaService(
                repository: Provider.of<TarefaRepository>(
                  context,
                  listen: false,
                ),
              ),
        ),
        ChangeNotifierProvider<CriarTarefaViewModel>(
          create:
              (context) => CriarTarefaViewModel(
                repository: Provider.of<TarefaRepository>(
                  context,
                  listen: false,
                ),
              ),
        ),
        ChangeNotifierProvider<ListarTarefasViewModel>(
          create:
              (context) => ListarTarefasViewModel(
                repository: Provider.of<TarefaRepository>(
                  context,
                  listen: false,
                ),
              ),
        ),
        ChangeNotifierProvider<MatrizEisenhowerViewModel>(
          create:
              (context) => MatrizEisenhowerViewModel(
                repository: Provider.of<TarefaRepository>(
                  context,
                  listen: false,
                ),
              ),
        ),
        ChangeNotifierProvider<FiltroTarefasViewModel>(
          create:
              (context) => FiltroTarefasViewModel(
                tarefaService: Provider.of<TarefaService>(
                  context,
                  listen: false,
                ),
              ),
        ),
        // Suporte
        Provider<SuporteRepository>(create: (_) => SuporteRepository()),
        ChangeNotifierProvider<SuporteViewModel>(
          create:
              (context) => SuporteViewModel(
                repository: Provider.of<SuporteRepository>(
                  context,
                  listen: false,
                ),
                usuarioAtual:
                    Provider.of<AutenticacaoService>(
                      context,
                      listen: false,
                    ).usuarioAtual,
                autenticacaoService: Provider.of<AutenticacaoService>(
                  context,
                  listen: false,
                ),
              ),
        ),
      ],
      child: child,
    );
  }
}
