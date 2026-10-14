import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/answer.dart';

class AnswerRepository {
  const AnswerRepository();

  static const _assetPath = 'assets/data/hangman_entries.json';

  Future<List<Answer>> loadAnswers() async {
    final jsonString = await rootBundle.loadString(_assetPath);
    final data = jsonDecode(jsonString);
    final entries = data is Map<String, dynamic> ? data['entries'] : null;

    if (entries is! List || entries.isEmpty) {
      throw const FormatException(
        'O arquivo de respostas está vazio ou em formato inválido.',
      );
    }

    return entries.map(_parseAnswer).toList();
  }

  Answer _parseAnswer(dynamic entry) {
    if (entry is! Map<String, dynamic>) {
      throw const FormatException('Item inválido na lista de respostas.');
    }
    return Answer.fromJson(entry);
  }
}
