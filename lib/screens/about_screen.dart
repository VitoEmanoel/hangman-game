import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  static const _teamMembers = [
    'Richard Costa de Brito',
    'Victor Emanoel Lima Silva',
    'Francisco Osmar Santos Silva',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Equipe')),
      body: SafeArea(
        child: ListView(
          children: [
            for (final member in _teamMembers)
              ListTile(leading: const Icon(Icons.person), title: Text(member)),
          ],
        ),
      ),
    );
  }
}
