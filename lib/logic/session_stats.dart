import '../models/round_status.dart';
import 'hangman_round.dart';

class SessionStats {
  int _wins = 0;
  int _losses = 0;
  int _totalErrors = 0;
  int _hintsUsed = 0;

  int get wins => _wins;
  int get losses => _losses;
  int get totalErrors => _totalErrors;
  int get hintsUsed => _hintsUsed;
  int get totalRounds => _wins + _losses;
  double get winPercentage => _percentageOf(_wins);
  double get lossPercentage => _percentageOf(_losses);

  void registerRound(HangmanRound round) {
    if (round.status == RoundStatus.won) {
      _wins++;
    } else {
      _losses++;
    }
    _totalErrors += round.errors;
  }

  void registerHint() {
    _hintsUsed++;
  }

  double _percentageOf(int value) {
    if (totalRounds == 0) {
      return 0;
    }
    return value * 100 / totalRounds;
  }
}
