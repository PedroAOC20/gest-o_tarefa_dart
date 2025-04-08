import 'package:flutter/material.dart';
import '../model/tarefa_model.dart';
import '../repository/tarefa_repository.dart';

class ListarTarefasViewModel extends ChangeNotifier {
  final TarefaRepository _repository;
  List<TarefaModel> _tarefas = [];
  bool _carregando = false;
  String _mensagemErro = '';

  ListarTarefasViewModel({required TarefaRepository repository})
    : _repository = repository {
    carregarTarefas();
  }

  List<TarefaModel> get tarefas => _tarefas;
  bool get carregando => _carregando;
  String get mensagemErro => _mensagemErro;

  Future<void> carregarTarefas() async {
    _carregando = true;
    _mensagemErro = '';
    notifyListeners();
    try {
      _tarefas = await _repository.listarTarefas();
    } catch (e) {
      _tarefas = [];
      _mensagemErro = 'Erro ao carregar tarefas: $e';
    } finally {
      _carregando = false;
      notifyListeners();
    }
  }

  Future<void> atualizarTarefa(TarefaModel tarefaAtualizada) async {
    _carregando = true;
    _mensagemErro = '';
    notifyListeners();
    try {
      await _repository.atualizarTarefa(
        tarefaAtualizada.copyWith(modificadoEm: DateTime.now()),
      );
      // Recarrega todas as tarefas para garantir sincronização
      await carregarTarefas();
    } catch (e) {
      _mensagemErro = 'Erro ao atualizar tarefa: $e';
    } finally {
      _carregando = false;
      notifyListeners();
    }
  }

  Future<void> criarTarefa(TarefaModel novaTarefa) async {
    _carregando = true;
    _mensagemErro = '';
    notifyListeners();
    try {
      await _repository.criarTarefa(novaTarefa);
      await carregarTarefas();
    } catch (e) {
      _mensagemErro = 'Erro ao criar tarefa: $e';
    } finally {
      _carregando = false;
      notifyListeners();
    }
  }

  Future<void> removerTarefa(String id) async {
    _carregando = true;
    _mensagemErro = '';
    notifyListeners();
    try {
      await _repository.removerTarefa(id);
      await carregarTarefas();
    } catch (e) {
      _mensagemErro = 'Erro ao remover tarefa: $e';
    } finally {
      _carregando = false;
      notifyListeners();
    }
  }
}
