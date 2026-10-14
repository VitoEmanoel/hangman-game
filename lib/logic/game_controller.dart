import 'package:flutter/foundation.dart';

import '../data/answer_repository.dart';
import '../models/answer.dart';
import '../models/answer_category.dart';
import '../models/difficulty.dart';
import 'answer_picker.dart';
import 'hangman_round.dart';
import 'session_stats.dart';

class GameController extends ChangeNotifier {
  GameController(this._repository);

  static const maxErrors = 6;

  final AnswerRepository _repository;
  final AnswerPicker _picker = AnswerPicker();
  final SessionStats stats = SessionStats();

  List<Answer> _answers = [];
  HangmanRound? _currentRound;
  bool _isLoading = true;
  String? _loadError;

  HangmanRound? get currentRound => _currentRound;
  bool get isLoading => _isLoading;
  String? get loadError => _loadError;

  List<AnswerCategory> get categories {
    return AnswerCategory.values
        .where(
          (category) => _answers.any((answer) => answer.category == category),
        )
        .toList();
  }

  List<Difficulty> difficultiesFor(AnswerCategory category) {
    return Difficulty.values
        .where(
          (difficulty) => _answers.any(
            (answer) =>
                answer.category == category && answer.difficulty == difficulty,
          ),
        )
        .toList();
  }

  Future<void> loadAnswers() async {
    _isLoading = true;
    _loadError = null;
    notifyListeners();

    try {
      _answers = await _repository.loadAnswers();
    } on FormatException catch (error) {
      _loadError = error.message;
    } catch (_) {
      _loadError = 'Não foi possível carregar o arquivo de respostas.';
    }

    _isLoading = false;
    notifyListeners();
  }

  bool startRound(AnswerCategory category, Difficulty difficulty) {
    final candidates = _answers
        .where(
          (answer) =>
              answer.category == category && answer.difficulty == difficulty,
        )
        .toList();
    final answer = _picker.pick(candidates);

    if (answer == null) {
      return false;
    }

    _currentRound = HangmanRound(answer: answer, maxErrors: maxErrors);
    notifyListeners();
    return true;
  }

  void guess(String letter) {
    final round = _currentRound;
    if (round == null || round.isFinished) {
      return;
    }

    round.guess(letter);
    if (round.isFinished) {
      stats.registerRound(round);
    }
    notifyListeners();
  }

  void useHint() {
    final round = _currentRound;
    if (round == null || round.isFinished || round.hintUsed) {
      return;
    }

    round.useHint();
    stats.registerHint();
    notifyListeners();
  }
}
