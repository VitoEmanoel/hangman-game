import 'package:flutter/material.dart';

import '../logic/game_controller.dart';
import '../models/answer_category.dart';
import '../models/difficulty.dart';
import '../widgets/exhausted_answers_message.dart';
import '../widgets/option_selector.dart';
import 'about_screen.dart';
import 'game_screen.dart';
import 'stats_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.controller});

  final GameController controller;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AnswerCategory? _category;
  Difficulty? _difficulty;

  GameController get _controller => widget.controller;

  @override
  void initState() {
    super.initState();
    _controller.loadAnswers();
  }

  void _selectCategory(AnswerCategory category) {
    setState(() {
      _category = category;
      if (!_controller.difficultiesFor(category).contains(_difficulty)) {
        _difficulty = null;
      }
    });
  }

  void _selectDifficulty(Difficulty difficulty) {
    setState(() => _difficulty = difficulty);
  }

  void _startRound(AnswerCategory category, Difficulty difficulty) {
    final started = _controller.startRound(category, difficulty);
    if (!started) {
      showExhaustedAnswersMessage(context, category, difficulty);
      return;
    }
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => GameScreen(controller: _controller)),
    );
  }

  void _openScreen(Widget screen) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => screen));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Jogo da Forca')),
      body: SafeArea(
        child: ListenableBuilder(
          listenable: _controller,
          builder: (context, _) {
            if (_controller.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            final loadError = _controller.loadError;
            if (loadError != null) {
              return _buildLoadError(loadError);
            }
            return _buildSetup();
          },
        ),
      ),
    );
  }

  Widget _buildLoadError(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(message, textAlign: TextAlign.center),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: _controller.loadAnswers,
              child: const Text('Tentar novamente'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSetup() {
    final category = _category;
    final difficulty = _difficulty;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          OptionSelector<AnswerCategory>(
            title: 'Categoria',
            options: _controller.categories,
            selected: category,
            labelOf: (option) => option.label,
            onSelected: _selectCategory,
          ),
          const SizedBox(height: 24),
          if (category == null)
            const Text('Escolha uma categoria para ver os níveis.')
          else
            OptionSelector<Difficulty>(
              title: 'Dificuldade',
              options: _controller.difficultiesFor(category),
              selected: difficulty,
              labelOf: (option) => option.label,
              onSelected: _selectDifficulty,
            ),
          const SizedBox(height: 24),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Categoria: ${category?.label ?? '-'}'),
                  Text('Dificuldade: ${difficulty?.label ?? '-'}'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          FilledButton(
            onPressed: category == null || difficulty == null
                ? null
                : () => _startRound(category, difficulty),
            child: const Text('Iniciar rodada'),
          ),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            onPressed: () => _openScreen(StatsScreen(stats: _controller.stats)),
            icon: const Icon(Icons.bar_chart),
            label: const Text('Estatísticas'),
          ),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            onPressed: () => _openScreen(const AboutScreen()),
            icon: const Icon(Icons.groups),
            label: const Text('Equipe'),
          ),
        ],
      ),
    );
  }
}
