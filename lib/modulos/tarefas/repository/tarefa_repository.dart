import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../model/tarefa_model.dart';

class TarefaRepository {
  static const String _chaveTarefas = 'tarefas';

  Future<List<TarefaModel>> listarTarefas() async {
    final prefs = await SharedPreferences.getInstance();
    final tarefasJson = prefs.getString(_chaveTarefas);
    if (tarefasJson == null) return [];
    final List<dynamic> tarefasMap = jsonDecode(tarefasJson);
    return tarefasMap.map((map) => TarefaModel.fromMap(map)).toList();
  }

  Future<TarefaModel> criarTarefa(TarefaModel tarefa) async {
    final tarefas = await listarTarefas();
    tarefas.add(tarefa);
    await _salvarTarefas(tarefas);
    return tarefa;
  }

  Future<TarefaModel> atualizarTarefa(TarefaModel tarefaAtualizada) async {
    final tarefas = await listarTarefas();
    final index = tarefas.indexWhere((t) => t.id == tarefaAtualizada.id);
    if (index == -1) {
      throw Exception('Tarefa não encontrada');
    }
    tarefas[index] = tarefaAtualizada;
    await _salvarTarefas(tarefas);
    return tarefaAtualizada;
  }

  Future<void> removerTarefa(String id) async {
    final tarefas = await listarTarefas();
    tarefas.removeWhere((t) => t.id == id);
    await _salvarTarefas(tarefas);
  }

  Future<void> _salvarTarefas(List<TarefaModel> tarefas) async {
    final prefs = await SharedPreferences.getInstance();
    final tarefasMap = tarefas.map((t) => t.toMap()).toList();
    await prefs.setString(_chaveTarefas, jsonEncode(tarefasMap));
  }
}
