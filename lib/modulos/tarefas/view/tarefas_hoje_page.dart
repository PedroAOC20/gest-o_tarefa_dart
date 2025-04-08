import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/constantes.dart';
import '../model/tarefa_model.dart';
import '../view_model/listar_tarefas_view_model.dart';
import '../../../core/widgets/carregamento.dart';

class TarefasHojePage extends StatelessWidget {
  const TarefasHojePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ListarTarefasViewModel>(context);

    // Filtra tarefas para o dia atual (incluindo atrasadas), mas apenas não concluídas
    final hoje = DateTime.now();
    final tarefasHoje =
        viewModel.tarefas.where((tarefa) {
          final isHoje =
              tarefa.prazo.year == hoje.year &&
              tarefa.prazo.month == hoje.month &&
              tarefa.prazo.day == hoje.day;
          return (isHoje || tarefa.estaAtrasada) && !tarefa.concluido;
        }).toList();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Tarefas Hoje'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
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
                        viewModel.carregando
                            ? const Carregamento()
                            : tarefasHoje.isEmpty
                            ? const Center(
                              child: Text(
                                'Nenhuma tarefa pendente para hoje.',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 18,
                                ),
                              ),
                            )
                            : ListView.builder(
                              itemCount: tarefasHoje.length,
                              itemBuilder: (context, index) {
                                final tarefa = tarefasHoje[index];
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
                                      onChanged: (value) {
                                        viewModel.atualizarTarefa(
                                          tarefa.copyWith(
                                            concluido: value ?? false,
                                          ),
                                        );
                                      },
                                      activeColor: Colors.green,
                                    ),
                                    title: Text(
                                      tarefa.titulo,
                                      style: TextStyle(
                                        color: Colors.white,
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
}
