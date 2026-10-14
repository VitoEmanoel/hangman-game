const _accentedLetters = {
  'Á': 'A',
  'À': 'A',
  'Â': 'A',
  'Ã': 'A',
  'É': 'E',
  'Ê': 'E',
  'Í': 'I',
  'Ó': 'O',
  'Ô': 'O',
  'Õ': 'O',
  'Ú': 'U',
  'Ç': 'C',
};

String normalizeText(String text) {
  return text
      .toUpperCase()
      .split('')
      .map((letter) => _accentedLetters[letter] ?? letter)
      .join();
}
