enum Difficulty {
  easy('Fácil'),
  medium('Médio'),
  hard('Difícil');

  const Difficulty(this.label);

  final String label;

  static Difficulty fromJson(Object? value) {
    for (final difficulty in values) {
      if (difficulty.name == value) {
        return difficulty;
      }
    }
    throw FormatException('Nível de dificuldade desconhecido: $value');
  }
}
