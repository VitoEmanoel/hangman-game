import 'package:flutter/material.dart';

import '../logic/game_controller.dart';
import '../logic/hangman_round.dart';
import '../widgets/exhausted_answers_message.dart';
import '../widgets/hangman_drawing.dart';
import '../widgets/letter_keyboard.dart';
import '../widgets/masked_answer.dart';
import '../widgets/round_result_panel.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key, required this.controller});

  final GameController controller;

  void _startNewRound(BuildContext context, HangmanRound round) {
    final category = round.answer.category;
    final difficulty = round.answer.difficulty;
    final started = controller.startRound(category, difficulty);

    if (!started) {
      showExhaustedAnswersMessage(context, category, difficulty);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rodada')),
      body: SafeArea(
        child: ListenableBuilder(
          listenable: controller,
          builder: (context, _) {
            final round = controller.currentRound!;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        Chip(
                          label: Text(
                            'Categoria: ${round.answer.category.label}',
                          ),
                        ),
                        Chip(
                          label: Text(
                            'Dificuldade: ${round.answer.difficulty.label}',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    HangmanDrawing(errors: round.errors),
                    const SizedBox(height: 8),
                    Text('Erros: ${round.errors} de ${round.maxErrors}'),
                    const SizedBox(height: 24),
                    MaskedAnswer(round: round),
                    const SizedBox(height: 24),
                    _buildHint(round),
                    const SizedBox(height: 8),
                    Text(
                      'Letras utilizadas: ${round.guessedLetters.join(', ')}',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    if (round.isFinished)
                      RoundResultPanel(
                        round: round,
                        onNewRound: () => _startNewRound(context, round),
                        onBackToHome: () => Navigator.of(context).pop(),
                      )
                    else
                      LetterKeyboard(
                        round: round,
                        onLetterPressed: controller.guess,
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHint(HangmanRound round) {
    if (round.hintUsed) {
      return Text('Dica: ${round.hint}', textAlign: TextAlign.center);
    }
    return TextButton.icon(
      onPressed: round.isFinished ? null : controller.useHint,
      icon: const Icon(Icons.lightbulb_outline),
      label: const Text('Ver dica'),
    );
  }
}
