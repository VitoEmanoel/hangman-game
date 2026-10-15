import 'package:flutter/material.dart';

import '../logic/hangman_round.dart';
import '../models/round_status.dart';

class RoundResultPanel extends StatelessWidget {
  const RoundResultPanel({
    super.key,
    required this.round,
    required this.onNewRound,
    required this.onBackToHome,
  });

  final HangmanRound round;
  final VoidCallback onNewRound;
  final VoidCallback onBackToHome;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final won = round.status == RoundStatus.won;

    return Card(
      color: won ? colors.primaryContainer : colors.errorContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              won ? 'Você venceu!' : 'Você perdeu!',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text('Resposta: ${round.answer.text}'),
            Text('Erros: ${round.errors} de ${round.maxErrors}'),
            Text('Dica utilizada: ${round.hintUsed ? 'Sim' : 'Não'}'),
            const SizedBox(height: 16),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 8,
              runSpacing: 8,
              children: [
                OutlinedButton(
                  onPressed: onBackToHome,
                  child: const Text('Voltar ao início'),
                ),
                FilledButton(
                  onPressed: onNewRound,
                  child: const Text('Nova rodada'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
