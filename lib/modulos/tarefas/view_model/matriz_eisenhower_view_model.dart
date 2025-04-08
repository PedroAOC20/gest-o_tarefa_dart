import 'package:flutter/material.dart';
import '../model/tarefa_model.dart';
import '../repository/tarefa_repository.dart';

class MatrizEisenhowerViewModel extends ChangeNotifier {
  final TarefaRepository _repository;

  List<TarefaModel> _tarefas = [];
  bool _carregando = false;
  String _mensagemErro = '';
  bool _hasLoaded = false; // Controle para evitar chamadas repetidas

  List<TarefaModel> get tarefasUrgenteImportante =>
      _tarefas
          .where(
            (t) =>
                t.classificacaoEisenhower == 'Urgente e Importante' &&
                !t.concluido,
          )
          .toList();
  List<TarefaModel> get tarefasUrgenteNaoImportante =>
      _tarefas
          .where(
            (t) =>
                t.classificacaoEisenhower == 'Urgente e Não Importante' &&
                !t.concluido,
          )
          .toList();
  List<TarefaModel> get tarefasNaoUrgenteImportante =>
      _tarefas
          .where(
            (t) =>
                t.classificacaoEisenhower == 'Não Urgente e Importante' &&
                !t.concluido,
          )
          .toList();
  List<TarefaModel> get tarefasNaoUrgenteNaoImportante =>
      _tarefas
          .where(
            (t) =>
                t.classificacaoEisenhower == 'Não Urgente e Não Importante' &&
                !t.concluido,
          )
          .toList();

  bool get carregando => _carregando;
  String get mensagemErro => _mensagemErro;

  MatrizEisenhowerViewModel({required TarefaRepository repository})
    : _repository = repository;

  Future<void> carregarTarefas() async {
    if (_hasLoaded) return; // Evita chamadas repetidas
    _setCarregando(true);
    _mensagemErro = '';

    try {
      _tarefas = await _repository.listarTarefas();
      _hasLoaded = true;
    } catch (e) {
      _mensagemErro = 'Erro ao carregar tarefas: $e';
      _tarefas = [];
    } finally {
      _setCarregando(false);
    }
  }

  Future<void> alternarConclusao(TarefaModel tarefa) async {
    _setCarregando(true);

    try {
      final tarefaAtualizada = tarefa.copyWith(
        concluido: !tarefa.concluido,
        modificadoEm: DateTime.now(),
      );
      await _repository.atualizarTarefa(tarefaAtualizada);
      // Recarrega todas as tarefas para garantir sincronização
      _tarefas = await _repository.listarTarefas();
      notifyListeners();
    } catch (e) {
      _mensagemErro = 'Erro ao atualizar tarefa: $e';
    } finally {
      _setCarregando(false);
    }
  }

  void _setCarregando(bool valor) {
    _carregando = valor;
    notifyListeners();
  }
}
