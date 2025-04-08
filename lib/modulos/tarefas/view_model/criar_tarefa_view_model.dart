import 'package:flutter/material.dart';
import '../model/tarefa_model.dart';
import '../repository/tarefa_repository.dart';

class CriarTarefaViewModel extends ChangeNotifier {
  final TarefaRepository _repository;
  bool _carregando = false;
  String _mensagemErro = '';

  bool get carregando => _carregando;
  String get mensagemErro => _mensagemErro;

  CriarTarefaViewModel({required TarefaRepository repository})
    : _repository = repository;

  Future<bool> criarTarefa(TarefaModel tarefa) async {
    _carregando = true;
    _mensagemErro = '';
    notifyListeners();

    try {
      await _repository.criarTarefa(tarefa);
      return true;
    } catch (e) {
      _mensagemErro = 'Erro ao criar tarefa: $e';
      return false;
    } finally {
      _carregando = false;
      notifyListeners();
    }
  }
}
