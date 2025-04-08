import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/constantes.dart';
import '../../../core/widgets/botao_padrao.dart';
import '../../../core/widgets/campo_texto.dart';
import '../view_model/suporte_view_model.dart';

class SuportePage extends StatefulWidget {
  const SuportePage({Key? key}) : super(key: key);

  @override
  _SuportePageState createState() => _SuportePageState();
}

class _SuportePageState extends State<SuportePage> {
  final _formKey = GlobalKey<FormState>();
  final _mensagemController = TextEditingController();

  @override
  void dispose() {
    _mensagemController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<SuporteViewModel>(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Suporte'),
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
                    const Text(
                      'Entre em Contato',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: Constantes.margemGrande),
                    CampoTexto(
                      controller: _mensagemController,
                      label: 'Mensagem',
                      hint: 'Digite sua mensagem',
                      prefixIcon: Icons.message,
                      maxLines: 5,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, digite sua mensagem';
                        }
                        return null;
                      },
                      onTap: () async {
                        return Future.value();
                      },
                    ),
                    const SizedBox(height: Constantes.margemGrande),
                    BotaoPadrao(
                      texto: 'ENVIAR',
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          viewModel
                              .enviarMensagem(
                                _mensagemController.text.trim(),
                                mensagem: '',
                              )
                              .then((_) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Mensagem enviada com sucesso!',
                                    ),
                                    backgroundColor: Colors.green,
                                  ),
                                );
                                _mensagemController.clear();
                              })
                              .catchError((e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Erro: ${viewModel.mensagemErro}',
                                    ),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              });
                        }
                      },
                      icone: Icons.send,
                      corDeFundo: Colors.transparent,
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
