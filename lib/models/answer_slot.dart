class AnswerSlot {
  const AnswerSlot({
    required this.character,
    required this.isLetter,
    required this.isRevealed,
  });

  final String character;
  final bool isLetter;
  final bool isRevealed;
}
