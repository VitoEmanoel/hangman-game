import 'package:flutter/material.dart';

import '../logic/session_stats.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key, required this.stats});

  final SessionStats stats;

  String _formatPercentage(double value) {
    return '${value.toStringAsFixed(1).replaceAll('.', ',')}%';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Estatísticas')),
      body: SafeArea(
        child: ListView(
          children: [
            _StatTile(
              label: 'Rodadas realizadas',
              value: '${stats.totalRounds}',
            ),
            _StatTile(
              label: 'Vitórias',
              value:
                  '${stats.wins} (${_formatPercentage(stats.winPercentage)})',
            ),
            _StatTile(
              label: 'Derrotas',
              value:
                  '${stats.losses} (${_formatPercentage(stats.lossPercentage)})',
            ),
            _StatTile(label: 'Erros cometidos', value: '${stats.totalErrors}'),
            _StatTile(label: 'Dicas utilizadas', value: '${stats.hintsUsed}'),
          ],
        ),
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(label),
      trailing: Text(value, style: Theme.of(context).textTheme.titleMedium),
    );
  }
}
