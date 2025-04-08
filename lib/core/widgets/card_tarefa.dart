import 'package:flutter/material.dart';
import '../../modulos/tarefas/model/tarefa_model.dart';
import '../utils/constantes.dart';
import '../utils/formatadores.dart';

class CardTarefa extends StatelessWidget {
  final TarefaModel tarefa;
  final VoidCallback? onTap;
  final VoidCallback? onConcluir;

  const CardTarefa({
    Key? key,
    required this.tarefa,
    this.onTap,
    this.onConcluir,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: Constantes.elevacaoCard,
      color: Colors.grey.withOpacity(0.2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.only(bottom: Constantes.margemPequena),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(Constantes.paddingPadrao),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Checkbox(
                value: tarefa.concluido,
                onChanged: onConcluir != null ? (_) => onConcluir!() : null,
                activeColor: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(width: Constantes.margemPequena),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tarefa.titulo,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Colors.white,
                        fontSize: 16,
                        height: 1.3,
                        decoration:
                            tarefa.concluido
                                ? TextDecoration.lineThrough
                                : null,
                      ),
                    ),
                    const SizedBox(height: Constantes.margemPequena),
                    Text(
                      Formatadores.formatarTextoCurto(
                        tarefa.descricao ?? '',
                        limite: 100,
                      ),
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium!.copyWith(color: Colors.white70),
                    ),
                    const SizedBox(height: Constantes.margemPequena),
                    Row(
                      children: [
                        Text(
                          Formatadores.formatarPrazoRelativo(tarefa.prazo),
                          style: Theme.of(
                            context,
                          ).textTheme.bodySmall!.copyWith(
                            color:
                                tarefa.estaAtrasada
                                    ? Colors.red
                                    : tarefa.estaPrestes
                                    ? Colors.orange
                                    : Colors.white70,
                          ),
                        ),
                        const SizedBox(width: Constantes.margemPequena),
                        Text(
                          'Dificuldade: ${Formatadores.formatarDificuldade(tarefa.dificuldade)}',
                          style: Theme.of(context).textTheme.bodySmall!
                              .copyWith(color: Colors.white70),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: Constantes.margemPequena,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: _corPrioridade(tarefa.prioridade),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  Formatadores.formatarPrioridade(tarefa.prioridade.name),
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _corPrioridade(Prioridade prioridade) {
    switch (prioridade) {
      case Prioridade.urgente:
        return Colors.red.withOpacity(0.7);
      case Prioridade.importante:
        return Colors.orange.withOpacity(0.7);
      case Prioridade.baixa:
        return Colors.green.withOpacity(0.7);
    }
  }
}
