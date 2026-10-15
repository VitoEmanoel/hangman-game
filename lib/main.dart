import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'data/answer_repository.dart';
import 'logic/game_controller.dart';
import 'screens/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(HangmanApp(controller: GameController(const AnswerRepository())));
}

class HangmanApp extends StatelessWidget {
  const HangmanApp({super.key, required this.controller});

  final GameController controller;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jogo da Forca',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.indigo),
      home: HomeScreen(controller: controller),
    );
  }
}
