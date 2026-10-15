import 'package:flutter/material.dart';

import '../logic/hangman_round.dart';

class LetterKeyboard extends StatelessWidget {
  const LetterKeyboard({
    super.key,
    required this.round,
    required this.onLetterPressed,
  });

  static const _letters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';

  final HangmanRound round;
  final ValueChanged<String> onLetterPressed;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 6,
      runSpacing: 6,
      children: [
        for (final letter in _letters.split(''))
          FilledButton(
            onPressed: round.isGuessed(letter)
                ? null
                : () => onLetterPressed(letter),
            style: FilledButton.styleFrom(
              minimumSize: const Size(40, 44),
              padding: EdgeInsets.zero,
              disabledBackgroundColor: round.contains(letter)
                  ? Colors.green
                  : colors.error,
              disabledForegroundColor: Colors.white,
            ),
            child: Text(letter),
          ),
      ],
    );
  }
}
