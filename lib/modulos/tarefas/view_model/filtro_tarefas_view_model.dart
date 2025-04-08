import 'package:flutter/material.dart';
import '../model/tarefa_model.dart';
import '../service/tarefa_service.dart';

class FiltroTarefasViewModel extends ChangeNotifier {
  final TarefaService _tarefaService;

  List<TarefaModel> _tarefas = [];
  List<TarefaModel> _tarefasFiltradas = [];
  bool _carregando = false;
  String _mensagemErro = '';

  // Filtros
  Prioridade? _filtroPrioridade;
  bool? _filtroConcluido;
  DateTime? _filtroDataInicio;
  DateTime? _filtroDataFim;

  List<TarefaModel> get tarefasFiltradas => _tarefasFiltradas;
  bool get carregando => _carregando;
  String get mensagemErro => _mensagemErro;

  FiltroTarefasViewModel({required TarefaService tarefaService})
    : _tarefaService = tarefaService;

  Future<void> carregarTarefas() async {
    _setCarregando(true);
    _mensagemErro = '';

    try {
      _tarefas = await _tarefaService.listarTarefas();
      aplicarFiltros();
    } catch (e) {
      _mensagemErro = 'Erro ao carregar tarefas: $e';
      _tarefas = [];
      _tarefasFiltradas = [];
    } finally {
      _setCarregando(false);
    }
  }

  void aplicarFiltros() {
    _tarefasFiltradas =
        _tarefas.where((tarefa) {
          if (_filtroPrioridade != null &&
              tarefa.prioridade != _filtroPrioridade) {
            return false;
          }

          if (_filtroConcluido != null &&
              tarefa.concluido != _filtroConcluido) {
            return false;
          }

          if (_filtroDataInicio != null &&
              tarefa.prazo.isBefore(_filtroDataInicio!)) {
            return false;
          }
          if (_filtroDataFim != null && tarefa.prazo.isAfter(_filtroDataFim!)) {
            return false;
          }

          return true;
        }).toList();
    notifyListeners();
  }

  // Métodos para definir filtros
  void setFiltroPrioridade(Prioridade? prioridade) {
    _filtroPrioridade = prioridade;
    aplicarFiltros();
  }

  void setFiltroConcluido(bool? concluido) {
    _filtroConcluido = concluido;
    aplicarFiltros();
  }

  void setFiltroData(DateTime? inicio, DateTime? fim) {
    _filtroDataInicio = inicio;
    _filtroDataFim = fim;
    aplicarFiltros();
  }

  void limparFiltros() {
    _filtroPrioridade = null;
    _filtroConcluido = null;
    _filtroDataInicio = null;
    _filtroDataFim = null;
    aplicarFiltros();
  }

  Future<void> alternarConclusao(TarefaModel tarefa) async {
    _setCarregando(true);

    try {
      final tarefaAtualizada =
          tarefa.clone()
            ..concluido = !tarefa.concluido
            ..modificadoEm = DateTime.now();
      await _tarefaService.atualizarTarefa(tarefaAtualizada);
      _tarefas =
          _tarefas
              .map((t) => t.id == tarefa.id ? tarefaAtualizada : t)
              .toList();
      aplicarFiltros();
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
