import 'package:flutter/material.dart';

import '../models/answer_category.dart';
import '../models/difficulty.dart';

void showExhaustedAnswersMessage(
  BuildContext context,
  AnswerCategory category,
  Difficulty difficulty,
) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        'Todas as respostas de ${category.label} - ${difficulty.label} '
        'já foram usadas nesta sessão. Escolha outra combinação.',
      ),
    ),
  );
}
