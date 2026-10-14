enum AnswerCategory {
  animals('Animais'),
  humanBody('Corpo humano'),
  sports('Esportes'),
  technology('Tecnologia');

  const AnswerCategory(this.label);

  final String label;

  static AnswerCategory fromJson(Object? value) {
    for (final category in values) {
      if (category.name == value) {
        return category;
      }
    }
    throw FormatException('Categoria desconhecida: $value');
  }
}
