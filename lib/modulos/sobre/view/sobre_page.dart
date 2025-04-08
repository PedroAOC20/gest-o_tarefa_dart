import 'package:flutter/material.dart';
import '../../../core/tema/cores.dart';
import '../../../core/utils/constantes.dart';

class SobrePage extends StatelessWidget {
  const SobrePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sobre o Aplicativo'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: const DecorationImage(
            image: AssetImage('assets/images/solo_leveling_bg4.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black, BlendMode.darken),
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(Constantes.paddingPadrao), // Ajustado
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Logo do aplicativo
                Image.asset('assets/images/solo_task_logo.png', height: 120),
                const SizedBox(height: Constantes.margemGrande), // Ajustado
                // Nome do app
                Text(
                  'TASK SOLO',
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(
                    fontSize: 28,
                    letterSpacing: 2.0,
                    color: Colors.white, // Adicionado
                    shadows: [
                      Shadow(
                        color: Colors.blue.withOpacity(0.7),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: Constantes.margemPequena), // Ajustado
                // Versão
                Text(
                  'Versão 1.0.0',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium!.copyWith(color: Colors.white70),
                ),

                const SizedBox(height: Constantes.margemGrande), // Ajustado
                // Card com informações sobre o aplicativo
                Card(
                  margin: EdgeInsets.zero,
                  color: Cores.fundoCard.withOpacity(0.9),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: BorderSide(
                      color: Cores.azulDestaque.withOpacity(0.5),
                      width: 1,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(
                      Constantes.paddingPadrao,
                    ), // Ajustado
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Objetivo do Projeto',
                          style: Theme.of(
                            context,
                          ).textTheme.titleLarge!.copyWith(
                            fontSize: 22,
                            color: Colors.white, // Adicionado
                          ),
                        ),
                        const SizedBox(
                          height: Constantes.margemPequena,
                        ), // Ajustado
                        Text(
                          'O Task Solo é um aplicativo de gestão de tarefas inspirado na estética visual do anime Solo Leveling, focado em proporcionar uma experiência de usuário única e envolvente. O aplicativo utiliza o método da Matriz de Eisenhower para priorização de tarefas, permitindo que você organize suas atividades de forma eficiente e visual.',
                          style: Theme.of(
                            context,
                          ).textTheme.bodyLarge!.copyWith(
                            color: Colors.white70, // Adicionado
                          ),
                        ),

                        const SizedBox(
                          height: Constantes.margemGrande,
                        ), // Ajustado

                        Text(
                          'Desenvolvedores',
                          style: Theme.of(
                            context,
                          ).textTheme.titleLarge!.copyWith(
                            fontSize: 22,
                            color: Colors.white, // Adicionado
                          ),
                        ),
                        const SizedBox(
                          height: Constantes.margemPequena,
                        ), // Ajustado

                        _buildDesenvolvedorCard(
                          context,
                          nome: 'Pedro Augusto de Oliveira Cardoso',
                          ra: '837652',
                          imagemAsset: 'assets/images/dev_pedro.jpg',
                        ),

                        const SizedBox(
                          height: Constantes.margemPequena,
                        ), // Ajustado

                        _buildDesenvolvedorCard(
                          context,
                          nome: 'Luiz Felipe Spadaro Goes',
                          ra: '837695',
                          imagemAsset: 'assets/images/dev_luiz.jpg',
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: Constantes.margemGrande), // Ajustado
                // Card com informações técnicas
                Card(
                  margin: EdgeInsets.zero,
                  color: Cores.fundoCard.withOpacity(0.9),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: BorderSide(
                      color: Cores.azulDestaque.withOpacity(0.5),
                      width: 1,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(
                      Constantes.paddingPadrao,
                    ), // Ajustado
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tecnologias Utilizadas',
                          style: Theme.of(
                            context,
                          ).textTheme.titleLarge!.copyWith(
                            fontSize: 22,
                            color: Colors.white, // Adicionado
                          ),
                        ),
                        const SizedBox(
                          height: Constantes.margemPequena,
                        ), // Ajustado

                        _buildTecnologiaItem(
                          context,
                          'Flutter',
                          'Framework multiplataforma para desenvolvimento mobile',
                          Icons.flutter_dash,
                        ),

                        _buildTecnologiaItem(
                          context,
                          'Dart',
                          'Linguagem de programação',
                          Icons.code,
                        ),

                        _buildTecnologiaItem(
                          context,
                          'Visual Studio Code',
                          'IDE utilizada para desenvolvimento',
                          Icons.code,
                        ),

                        _buildTecnologiaItem(
                          context,
                          'Provider',
                          'Gerenciamento de estado',
                          Icons.refresh,
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: Constantes.margemGrande), // Ajustado

                Text(
                  '© 2025 Task Solo. Todos os direitos reservados.',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium!.copyWith(color: Colors.white54),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDesenvolvedorCard(
    BuildContext context, {
    required String nome,
    required String ra,
    required String imagemAsset,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black26,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Cores.bordaCard, width: 1),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Image.asset(
              imagemAsset,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
              errorBuilder:
                  (context, error, stackTrace) => const Icon(
                    Icons.person,
                    size: 60,
                    color: Colors.white70,
                  ), // Fallback para erro de imagem
            ),
          ),
          const SizedBox(width: Constantes.margemPequena), // Ajustado
          // Informações
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  nome,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Adicionado
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'RA: $ra',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.white70, // Adicionado
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTecnologiaItem(
    BuildContext context,
    String nome,
    String descricao,
    IconData icone,
  ) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: Constantes.margemPequena,
      ), // Ajustado
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Cores.azulDestaque.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icone, color: Cores.azulDestaque, size: 24),
          ),
          const SizedBox(width: Constantes.margemPequena), // Ajustado
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  nome,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Adicionado
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  descricao,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.white70, // Adicionado
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
