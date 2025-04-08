import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/constantes.dart';
import '../../../core/widgets/botao_padrao.dart';
import '../../../core/widgets/campo_texto.dart';
import '../model/tarefa_model.dart';
import '../view_model/listar_tarefas_view_model.dart';

class CriarTarefaPage extends StatefulWidget {
  const CriarTarefaPage({Key? key}) : super(key: key);

  @override
  _CriarTarefaPageState createState() => _CriarTarefaPageState();
}

class _CriarTarefaPageState extends State<CriarTarefaPage> {
  final _formKey = GlobalKey<FormState>();
  final _tituloController = TextEditingController();
  final _descricaoController = TextEditingController();
  DateTime? _prazo;
  Prioridade _prioridade = Prioridade.baixa;
  int _dificuldade = 1;

  @override
  void dispose() {
    _tituloController.dispose();
    _descricaoController.dispose();
    super.dispose();
  }

  Future<void> _selecionarPrazo(BuildContext context) async {
    final hoje = DateTime.now();
    final dataSelecionada = await showDatePicker(
      context: context,
      initialDate: hoje,
      firstDate: hoje,
      lastDate: hoje.add(const Duration(days: 365)),
    );
    if (dataSelecionada != null) {
      setState(() {
        _prazo = dataSelecionada;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ListarTarefasViewModel>(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Criar Tarefa'),
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
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(Constantes.paddingPadrao),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: Constantes.margemGrande),
                    CampoTexto(
                      controller: _tituloController,
                      label: 'Título',
                      hint: 'Digite o título da tarefa',
                      prefixIcon: Icons.title,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, digite o título';
                        }
                        return null;
                      },
                      maxLines: 1,

                      onTap: () async {
                        return Future.value();
                      },
                    ),
                    const SizedBox(height: Constantes.margemPequena),
                    CampoTexto(
                      controller: _descricaoController,
                      label: 'Descrição',
                      hint: 'Digite a descrição da tarefa',
                      prefixIcon: Icons.description,
                      maxLines: 3,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, digite a descrição';
                        }
                        return null;
                      },
                      onTap: () async {
                        return Future.value();
                      },
                    ),
                    const SizedBox(height: Constantes.margemPequena),
                    ListTile(
                      title: Text(
                        _prazo == null
                            ? 'Selecionar Prazo'
                            : 'Prazo: ${_prazo!.day}/${_prazo!.month}/${_prazo!.year}',
                        style: const TextStyle(color: Colors.white),
                      ),
                      trailing: const Icon(
                        Icons.calendar_today,
                        color: Colors.white70,
                      ),
                      onTap: () => _selecionarPrazo(context),
                    ),
                    const SizedBox(height: Constantes.margemPequena),
                    DropdownButtonFormField<Prioridade>(
                      value: _prioridade,
                      decoration: const InputDecoration(
                        labelText: 'Prioridade',
                        labelStyle: TextStyle(color: Colors.white),
                        prefixIcon: Icon(
                          Icons.priority_high,
                          color: Colors.white70,
                        ),
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white70),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                      dropdownColor: Colors.black87,
                      style: const TextStyle(color: Colors.white),
                      items:
                          Prioridade.values.map((Prioridade prioridade) {
                            return DropdownMenuItem<Prioridade>(
                              value: prioridade,
                              child: Text(
                                prioridade == Prioridade.baixa
                                    ? 'Baixa'
                                    : prioridade == Prioridade.importante
                                    ? 'Importante'
                                    : 'Urgente',
                              ),
                            );
                          }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _prioridade = value!;
                        });
                      },
                    ),
                    const SizedBox(height: Constantes.margemPequena),
                    DropdownButtonFormField<int>(
                      value: _dificuldade,
                      decoration: const InputDecoration(
                        labelText: 'Dificuldade',
                        labelStyle: TextStyle(color: Colors.white),
                        prefixIcon: Icon(Icons.star, color: Colors.white70),
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white70),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                      dropdownColor: Colors.black87,
                      style: const TextStyle(color: Colors.white),
                      items: List.generate(5, (index) {
                        return DropdownMenuItem<int>(
                          value: index + 1,
                          child: Text(
                            '${index + 1} Estrela${index + 1 > 1 ? 's' : ''}',
                          ),
                        );
                      }),
                      onChanged: (value) {
                        setState(() {
                          _dificuldade = value!;
                        });
                      },
                    ),
                    const SizedBox(height: Constantes.margemGrande),
                    BotaoPadrao(
                      texto: 'CADASTRAR TAREFA',
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          if (_prazo == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Por favor, selecione o prazo'),
                                backgroundColor: Colors.red,
                              ),
                            );
                            return;
                          }
                          final novaTarefa = TarefaModel(
                            id:
                                DateTime.now().millisecondsSinceEpoch
                                    .toString(),
                            titulo: _tituloController.text.trim(),
                            descricao: _descricaoController.text.trim(),
                            prazo: _prazo!,
                            prioridade: _prioridade,
                            dificuldade: _dificuldade,
                            criadoEm: DateTime.now(),
                            modificadoEm: DateTime.now(),
                          );
                          viewModel
                              .criarTarefa(novaTarefa)
                              .then((_) {
                                Navigator.pop(context);
                              })
                              .catchError((e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Erro ao criar tarefa: $e'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              });
                        }
                      },
                      icone: Icons.add_task,
                      corDeFundo: Colors.blue,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
