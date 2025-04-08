import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/utils/constantes.dart';
import '../../../../core/utils/validadores.dart';
import '../../../../core/widgets/botao_padrao.dart';
import '../../../../core/widgets/campo_texto.dart';
import '../../../../core/widgets/carregamento.dart';
import '../view_model/login_view_model.dart';
import '../../../../infraestrutura/rotas/rotas_app.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _senhaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<LoginViewModel>(context);

    return Scaffold(
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: Constantes.margemGrande),
                  Text(
                    'Solo Task',
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
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
                    onTap: () async {
                      return Future.value();
                    },
                    maxLines: 1,
                  ),
                  const SizedBox(height: Constantes.margemPequena),
                  CampoTexto(
                    controller: _senhaController,
                    label: 'Senha',
                    hint: 'Digite sua senha',
                    prefixIcon: Icons.lock_outline,
                    validator: Validadores.validarSenha,
                    onTap: () async {
                      return Future.value();
                    },
                    maxLines: 1,
                  ),
                  const SizedBox(height: Constantes.margemPequena),
                  TextButton(
                    onPressed:
                        () => Navigator.pushNamed(
                          context,
                          RotasApp.recuperarSenha,
                        ),
                    child: const Text(
                      'Esqueceu a senha?',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ),
                  const SizedBox(height: Constantes.margemGrande),
                  viewModel.carregando
                      ? const Carregamento()
                      : BotaoPadrao(
                        texto: 'ENTRAR',
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            viewModel
                                .login(
                                  _emailController.text.trim(),
                                  _senhaController.text.trim(),
                                )
                                .then((_) {
                                  Navigator.pushReplacementNamed(
                                    context,
                                    RotasApp.listarTarefas,
                                  );
                                })
                                .catchError((e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(viewModel.mensagemErro),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                });
                          }
                        },
                        icone: Icons.login_outlined,
                        corDeFundo: Colors.blue,
                      ),
                  const SizedBox(height: Constantes.margemPequena),
                  TextButton(
                    onPressed:
                        () => Navigator.pushNamed(context, RotasApp.cadastro),
                    child: const Text(
                      'Não tem conta? Cadastre-se',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ),
                  TextButton(
                    onPressed:
                        () => Navigator.pushNamed(context, RotasApp.sobre),
                    child: const Text(
                      'Sobre o App',
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
