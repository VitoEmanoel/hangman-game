import 'dart:math';

import '../models/answer.dart';

class AnswerPicker {
  final _random = Random();
  final Set<Answer> _usedAnswers = {};

  Answer? pick(List<Answer> candidates) {
    final availableAnswers = candidates
        .where((answer) => !_usedAnswers.contains(answer))
        .toList();

    if (availableAnswers.isEmpty) {
      return null;
    }

    final answer = availableAnswers[_random.nextInt(availableAnswers.length)];
    _usedAnswers.add(answer);
    return answer;
  }
}
