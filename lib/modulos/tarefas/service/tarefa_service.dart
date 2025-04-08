import '../model/tarefa_model.dart';
import '../repository/tarefa_repository.dart';

class TarefaService {
  final TarefaRepository _repository;

  TarefaService({required TarefaRepository repository})
    : _repository = repository;

  Future<TarefaModel> criarTarefa(TarefaModel tarefa) async {
    try {
      return await _repository.criarTarefa(tarefa);
    } catch (e) {
      throw Exception('Erro ao criar tarefa: $e');
    }
  }

  Future<List<TarefaModel>> listarTarefas() async {
    try {
      return await _repository.listarTarefas();
    } catch (e) {
      throw Exception('Erro ao listar tarefas: $e');
    }
  }

  Future<TarefaModel> atualizarTarefa(TarefaModel tarefa) async {
    try {
      return await _repository.atualizarTarefa(tarefa);
    } catch (e) {
      throw Exception('Erro ao atualizar tarefa: $e');
    }
  }

  Future<void> removerTarefa(String id) async {
    try {
      await _repository.removerTarefa(id);
    } catch (e) {
      throw Exception('Erro ao remover tarefa: $e');
    }
  }

  //buscar tarefa por ID
  Future<TarefaModel> buscarPorId(String id) async {
    try {
      final tarefas = await listarTarefas();
      return tarefas.firstWhere((t) => t.id == id);
    } catch (e) {
      throw Exception('Tarefa não encontrada: $e');
    }
  }
}
