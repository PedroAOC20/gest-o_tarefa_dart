import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../infraestrutura/rotas/rotas_app.dart';
import '../../../core/utils/constantes.dart';
import '../model/tarefa_model.dart';
import '../view_model/listar_tarefas_view_model.dart';
import '../../autenticacao/login/view_model/login_view_model.dart';

class ListarTarefasPage extends StatelessWidget {
  const ListarTarefasPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ListarTarefasViewModel>(context);

    final tarefasNaoConcluidas =
        viewModel.tarefas.where((tarefa) => !tarefa.concluido).toList();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Minhas Tarefas'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.black87,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/solo_leveling_bg4.jpg'),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.black54,
                      BlendMode.darken,
                    ),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/solo_task_logo.png', height: 80),
                    const SizedBox(height: 8),
                    const Text(
                      'Task Solo',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              _buildDrawerItem(
                context,
                icon: Icons.add_task,
                title: 'Criar Tarefa',
                route: RotasApp.criarTarefa,
              ),
              _buildDrawerItem(
                context,
                icon: Icons.today,
                title: 'Tarefas Hoje',
                route: RotasApp.tarefasHoje,
              ),
              _buildDrawerItem(
                context,
                icon: Icons.calendar_today,
                title: 'Tarefas 7 Dias',
                route: RotasApp.tarefas7Dias,
              ),
              _buildDrawerItem(
                context,
                icon: Icons.calendar_month,
                title: 'Tarefas 15 Dias',
                route: RotasApp.tarefas15Dias,
              ),
              _buildDrawerItem(
                context,
                icon: Icons.check_circle,
                title: 'Tarefas Concluídas',
                route: RotasApp.tarefasConcluidas,
              ),
              _buildDrawerItem(
                context,
                icon: Icons.grid_on,
                title: 'Matriz Eisenhower',
                route: RotasApp.matrizEisenhower,
              ),
              _buildDrawerItem(
                context,
                icon: Icons.support_agent,
                title: 'Suporte',
                route: RotasApp.suporte,
              ),
              _buildDrawerItem(
                context,
                icon: Icons.logout,
                title: 'Sair',
                onTap: () async {
                  final viewModel = Provider.of<LoginViewModel>(
                    context,
                    listen: false,
                  );
                  await viewModel.logout();
                  Navigator.pushReplacementNamed(context, RotasApp.login);
                },
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/solo_leveling_bg4.jpg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(Constantes.paddingPadrao),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  Expanded(
                    child:
                        tarefasNaoConcluidas.isEmpty
                            ? const Center(
                              child: Text(
                                'Nenhuma tarefa pendente.',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 18,
                                ),
                              ),
                            )
                            : ListView.builder(
                              itemCount: tarefasNaoConcluidas.length,
                              itemBuilder: (context, index) {
                                final tarefa = tarefasNaoConcluidas[index];
                                return Card(
                                  color: Colors.black26,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    side: const BorderSide(
                                      color: Colors.white10,
                                    ),
                                  ),
                                  child: ListTile(
                                    leading: Checkbox(
                                      value: tarefa.concluido,
                                      onChanged: (bool? novoValor) {
                                        if (novoValor != null) {
                                          final tarefaAtualizada = tarefa
                                              .copyWith(
                                                concluido: novoValor,
                                                modificadoEm: DateTime.now(),
                                              );
                                          viewModel.atualizarTarefa(
                                            tarefaAtualizada,
                                          );
                                        }
                                      },
                                      activeColor: Colors.blue,
                                      checkColor: Colors.white,
                                    ),
                                    title: Text(
                                      tarefa.titulo,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        decoration:
                                            tarefa.concluido
                                                ? TextDecoration.lineThrough
                                                : null,
                                      ),
                                    ),
                                    subtitle: Text(
                                      '${tarefa.descricao}\n${tarefa.prazo.day}/${tarefa.prazo.month}/${tarefa.prazo.year} - Dificuldade: ${'★' * tarefa.dificuldade}',
                                      style: const TextStyle(
                                        color: Colors.white70,
                                      ),
                                    ),
                                    trailing:
                                        tarefa.prioridade == Prioridade.baixa
                                            ? const Chip(
                                              label: Text('Baixa'),
                                              backgroundColor: Colors.green,
                                            )
                                            : tarefa.prioridade ==
                                                Prioridade.importante
                                            ? const Chip(
                                              label: Text('Média'),
                                              backgroundColor: Colors.orange,
                                            )
                                            : const Chip(
                                              label: Text('Alta'),
                                              backgroundColor: Colors.red,
                                            ),
                                  ),
                                );
                              },
                            ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    String? route,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.white70),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white70, fontSize: 16),
      ),
      onTap:
          onTap ??
          () {
            Navigator.pop(context);
            Navigator.pushNamed(context, route!);
          },
    );
  }
}
