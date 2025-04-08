import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/constantes.dart';
import '../model/tarefa_model.dart';
import '../view_model/matriz_eisenhower_view_model.dart';
import '../../../core/widgets/carregamento.dart';

class MatrizEisenhowerPage extends StatelessWidget {
  const MatrizEisenhowerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<MatrizEisenhowerViewModel>(context);

    // Carrega as tarefas após o build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!viewModel.carregando &&
          viewModel.tarefasUrgenteImportante.isEmpty &&
          viewModel.tarefasUrgenteNaoImportante.isEmpty &&
          viewModel.tarefasNaoUrgenteImportante.isEmpty &&
          viewModel.tarefasNaoUrgenteNaoImportante.isEmpty) {
        viewModel.carregarTarefas();
      }
    });

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Matriz Eisenhower'),
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
              child:
                  viewModel.carregando
                      ? const Carregamento()
                      : Column(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                  child: _buildQuadrante(
                                    context,
                                    viewModel,
                                    'Urgente e Importante',
                                    viewModel.tarefasUrgenteImportante
                                        .where((t) => !t.concluido)
                                        .toList(),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: _buildQuadrante(
                                    context,
                                    viewModel,
                                    'Urgente e Não Importante',
                                    viewModel.tarefasUrgenteNaoImportante
                                        .where((t) => !t.concluido)
                                        .toList(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                  child: _buildQuadrante(
                                    context,
                                    viewModel,
                                    'Não Urgente e Importante',
                                    viewModel.tarefasNaoUrgenteImportante
                                        .where((t) => !t.concluido)
                                        .toList(),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: _buildQuadrante(
                                    context,
                                    viewModel,
                                    'Não Urgente e Não Importante',
                                    viewModel.tarefasNaoUrgenteNaoImportante
                                        .where((t) => !t.concluido)
                                        .toList(),
                                  ),
                                ),
                              ],
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

  Widget _buildQuadrante(
    BuildContext context,
    MatrizEisenhowerViewModel viewModel,
    String titulo,
    List<TarefaModel> tarefas,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              titulo,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child:
                tarefas.isEmpty
                    ? const Center(
                      child: Text(
                        'Sem tarefas',
                        style: TextStyle(color: Colors.white70),
                      ),
                    )
                    : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      itemCount: tarefas.length,
                      itemBuilder: (context, index) {
                        final tarefa = tarefas[index];
                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: Checkbox(
                            value: tarefa.concluido,
                            onChanged: (value) {
                              viewModel.alternarConclusao(tarefa);
                            },
                            activeColor: Colors.green,
                            checkColor: Colors.white,
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
                          trailing: Chip(
                            label: Text(
                              tarefa.prioridade == Prioridade.baixa
                                  ? 'Baixa'
                                  : tarefa.prioridade == Prioridade.importante
                                  ? 'Média'
                                  : 'Alta',
                            ),
                            backgroundColor:
                                tarefa.prioridade == Prioridade.baixa
                                    ? Colors.green
                                    : tarefa.prioridade == Prioridade.importante
                                    ? Colors.orange
                                    : Colors.red,
                          ),
                        );
                      },
                    ),
          ),
        ],
      ),
    );
  }
}
