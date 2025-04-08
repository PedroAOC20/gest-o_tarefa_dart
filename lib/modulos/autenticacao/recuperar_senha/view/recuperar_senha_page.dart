import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/utils/constantes.dart';
import '../../../../core/utils/validadores.dart';
import '../../../../core/widgets/botao_padrao.dart';
import '../../../../core/widgets/campo_texto.dart';
import '../../../../core/widgets/carregamento.dart';
import '../view_model/recuperar_senha_view_model.dart';
import '../../../../infraestrutura/rotas/rotas_app.dart';

class RecuperarSenhaPage extends StatefulWidget {
  const RecuperarSenhaPage({Key? key}) : super(key: key);

  @override
  _RecuperarSenhaPageState createState() => _RecuperarSenhaPageState();
}

class _RecuperarSenhaPageState extends State<RecuperarSenhaPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<RecuperarSenhaViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Recuperar Senha'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage(Constantes.caminhoImagemFundo),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.7),
              BlendMode.darken,
            ),
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(Constantes.paddingPadrao),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: Constantes.margemGrande),
                  Text(
                    'Informe seu e-mail para recuperar a senha',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Colors.white70,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: Constantes.margemGrande),
                  CampoTexto(
                    controller: _emailController,
                    label: 'E-mail',
                    hint: 'Digite seu e-mail',
                    prefixIcon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                    validator: Validadores.validarEmail,
                    maxLines: 1,
                    onTap: () async {
                      return;
                    },
                  ),
                  const SizedBox(height: Constantes.margemGrande),
                  if (viewModel.mensagemSucesso.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: Constantes.margemPequena,
                      ),
                      child: Text(
                        viewModel.mensagemSucesso,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Colors.green.shade200,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  if (viewModel.mensagemErro.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: Constantes.margemPequena,
                      ),
                      child: Text(
                        viewModel.mensagemErro,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Colors.red.shade300,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  const SizedBox(height: Constantes.margemPequena),
                  viewModel.carregando
                      ? const Carregamento()
                      : BotaoPadrao(
                        texto: 'ENVIAR',
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            viewModel
                                .recuperarSenha(_emailController.text.trim())
                                .then((_) {
                                  // Opcional: voltar ao login após sucesso
                                });
                          }
                        },
                        icone: Icons.send_outlined,
                        corDeFundo: Colors.blue,
                      ),
                  const SizedBox(height: Constantes.margemPequena),
                  TextButton(
                    onPressed:
                        () =>
                            Navigator.popAndPushNamed(context, RotasApp.login),
                    child: const Text(
                      'Voltar ao login',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
