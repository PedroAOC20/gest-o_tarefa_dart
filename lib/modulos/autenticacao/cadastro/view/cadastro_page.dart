import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/utils/constantes.dart';
import '../../../../core/utils/validadores.dart';
import '../../../../core/widgets/botao_padrao.dart';
import '../../../../core/widgets/campo_texto.dart';
import '../../../../core/widgets/carregamento.dart';
import '../view_model/cadastro_view_model.dart';
import '../../../../infraestrutura/rotas/rotas_app.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({Key? key}) : super(key: key);

  @override
  _CadastroPageState createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _senhaController = TextEditingController();
  final _confirmarSenhaController = TextEditingController();

  @override
  void dispose() {
    _nomeController.dispose();
    _emailController.dispose();
    _telefoneController.dispose();
    _senhaController.dispose();
    _confirmarSenhaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<CadastroViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar Conta'),
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
                  CampoTexto(
                    controller: _nomeController,
                    label: 'Nome',
                    hint: 'Digite seu nome',
                    prefixIcon: Icons.person_outline,
                    validator:
                        (value) =>
                            Validadores.validarCampoObrigatorio(value, 'Nome'),
                    onTap: () async {
                      return Future.value();
                    },
                    maxLines: 1,
                  ),
                  const SizedBox(height: Constantes.margemPequena),
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
                    controller: _telefoneController,
                    label: 'Telefone',
                    hint: 'Digite seu telefone (ex.: 11999999999)',
                    prefixIcon: Icons.phone_outlined,
                    keyboardType: TextInputType.phone,
                    validator: (value) => Validadores.validarTelefone(value),
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
                  CampoTexto(
                    controller: _confirmarSenhaController,
                    label: 'Confirmar Senha',
                    hint: 'Confirme sua senha',
                    prefixIcon: Icons.lock_outline,
                    onTap: () async {
                      return Future.value();
                    },
                    maxLines: 1,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, confirme sua senha';
                      }
                      if (value != _senhaController.text) {
                        return 'As senhas não coincidem';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: Constantes.margemGrande),
                  viewModel.carregando
                      ? const Carregamento()
                      : BotaoPadrao(
                        texto: 'CADASTRAR',
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            viewModel
                                .cadastrar(
                                  nome: _nomeController.text.trim(),
                                  email: _emailController.text.trim(),
                                  telefone: _telefoneController.text.trim(),
                                  senha: _senhaController.text.trim(),
                                )
                                .then((_) {
                                  Navigator.popAndPushNamed(
                                    context,
                                    RotasApp.login,
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(Constantes.operacaoSucesso),
                                      backgroundColor: Colors.green,
                                    ),
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
                        icone: Icons.person_add_outlined,
                        corDeFundo: Colors.blue,
                      ),
                  const SizedBox(height: Constantes.margemPequena),
                  TextButton(
                    onPressed:
                        () =>
                            Navigator.popAndPushNamed(context, RotasApp.login),
                    child: const Text(
                      'Já tem conta? Faça login',
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
