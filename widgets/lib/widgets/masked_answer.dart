import 'dart:math';

import 'package:flutter/material.dart';

import '../logic/hangman_round.dart';
import '../models/answer_slot.dart';

class MaskedAnswer extends StatelessWidget {
  const MaskedAnswer({super.key, required this.round});

  static const _maxSlotWidth = 32.0;

  final HangmanRound round;

  @override
  Widget build(BuildContext context) {
    final words = round.words;
    final longestWord = words.map((word) => word.length).reduce(max);

    return LayoutBuilder(
      builder: (context, constraints) {
        final slotWidth = min(
          _maxSlotWidth,
          (constraints.maxWidth / longestWord).floorToDouble(),
        );

        return Wrap(
          alignment: WrapAlignment.center,
          spacing: slotWidth,
          runSpacing: 12,
          children: [
            for (final word in words)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (final slot in word)
                    _CharacterSlot(slot: slot, width: slotWidth),
                ],
              ),
          ],
        );
      },
    );
  }
}

class _CharacterSlot extends StatelessWidget {
  const _CharacterSlot({required this.slot, required this.width});

  final AnswerSlot slot;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: width * 0.1),
        padding: const EdgeInsets.only(bottom: 4),
        decoration: BoxDecoration(
          border: slot.isLetter
              ? const Border(bottom: BorderSide(width: 2))
              : null,
        ),
        child: Text(
          slot.isRevealed ? slot.character : '',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineSmall
              ?.copyWith(fontSize: width * 0.75),
        ),
      ),
    );
  }
}
