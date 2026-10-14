import 'answer_category.dart';
import 'difficulty.dart';

class Answer {
  const Answer({
    required this.text,
    required this.category,
    required this.difficulty,
    required this.hints,
  });

  factory Answer.fromJson(Map<String, dynamic> json) {
    final text = json['answer'];
    final hints = json['hints'];

    if (text is! String || text.trim().isEmpty) {
      throw FormatException('Resposta inválida: $json');
    }
    if (hints is! List ||
        hints.isEmpty ||
        hints.any((hint) => hint is! String)) {
      throw FormatException('Dicas inválidas para a resposta $text');
    }

    return Answer(
      text: text.trim(),
      category: AnswerCategory.fromJson(json['category']),
      difficulty: Difficulty.fromJson(json['difficulty']),
      hints: List<String>.from(hints),
    );
  }

  final String text;
  final AnswerCategory category;
  final Difficulty difficulty;
  final List<String> hints;
}
