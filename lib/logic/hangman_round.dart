import '../models/answer.dart';
import '../models/answer_slot.dart';
import '../models/round_status.dart';
import 'text_normalizer.dart';

class HangmanRound {
  HangmanRound({required this.answer, required this.maxErrors})
    : _answerLetters = normalizeText(answer.text)
          .split('')
          .where(_isLetter)
          .toSet();

  static final _letterPattern = RegExp(r'^[A-Z]$');

  final Answer answer;
  final int maxErrors;
  final Set<String> _answerLetters;
  final Set<String> _guessedLetters = {};
  int _errors = 0;
  bool _hintUsed = false;

  int get errors => _errors;
  bool get hintUsed => _hintUsed;
  String get hint => answer.hints.first;
  List<String> get guessedLetters => _guessedLetters.toList();

  RoundStatus get status {
    if (_errors >= maxErrors) {
      return RoundStatus.lost;
    }
    if (_answerLetters.every(isGuessed)) {
      return RoundStatus.won;
    }
    return RoundStatus.playing;
  }

  bool get isFinished => status != RoundStatus.playing;

  List<List<AnswerSlot>> get words {
    return answer.text
        .split(' ')
        .where((word) => word.isNotEmpty)
        .map((word) => word.split('').map(_slotFor).toList())
        .toList();
  }

  bool isGuessed(String letter) => _guessedLetters.contains(letter);

  bool contains(String letter) => _answerLetters.contains(letter);

  void guess(String letter) {
    if (isFinished || !_isLetter(letter) || isGuessed(letter)) {
      return;
    }
    _guessedLetters.add(letter);
    if (!contains(letter)) {
      _errors++;
    }
  }

  void useHint() {
    if (isFinished) {
      return;
    }
    _hintUsed = true;
  }

  AnswerSlot _slotFor(String character) {
    final letter = normalizeText(character);
    final isLetter = _isLetter(letter);
    return AnswerSlot(
      character: character,
      isLetter: isLetter,
      isRevealed: !isLetter || isGuessed(letter) || isFinished,
    );
  }

  static bool _isLetter(String character) => _letterPattern.hasMatch(character);
}
