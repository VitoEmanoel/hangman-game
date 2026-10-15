**Integrantes:**

- Victor Emanoel Lima Silva
- Richard Costa de Brito
- Francisco Osmar Santos Silva

# Jogo da Forca (hangman-game)

Aplicativo do Jogo da Forca para Android, desenvolvido em Flutter como trabalho da disciplina de Programação para Dispositivos Móveis (UESPI). O jogador escolhe uma categoria e um nível de dificuldade e tenta descobrir a resposta oculta escolhendo letras, antes que o boneco da forca seja completado.

O aplicativo funciona totalmente offline: respostas, categorias, níveis e dicas vêm de um arquivo JSON incluído nos assets do projeto e carregado em tempo de execução.

## Funcionalidades

- Escolha de categoria (Animais, Corpo humano, Esportes, Tecnologia) e dificuldade (Fácil, Médio, Difícil), com as opções selecionadas exibidas antes do início da rodada.
- Sorteio de respostas sem repetição durante a sessão, com aviso quando as respostas de uma combinação se esgotam.
- Respostas com uma ou mais palavras; espaços e hífens aparecem automaticamente desde o início da rodada.
- Tentativas apenas por letras, por meio de um teclado na tela que destaca acertos e erros.
- Comparação de letras ignorando acentos, preservando a grafia original da resposta.
- Desenho progressivo da forca, com limite de 6 erros.
- Dica por rodada, contabilizada uma única vez.
- Resultado da rodada com indicação de vitória ou derrota, resposta completa, quantidade de erros e uso de dica.
- Nova rodada mantendo as estatísticas e o controle das respostas já usadas, ou retorno à seleção de categoria e nível.
- Estatísticas da sessão: rodadas, vitórias, derrotas, percentuais, erros e dicas.
- Tela com os nomes completos dos integrantes da equipe.

## Tecnologias

- [Flutter](https://flutter.dev/) 3.47 e [Dart](https://dart.dev/) 3.13
- Material Design 3
- `flutter_lints` para análise estática

Não são usados banco de dados, serviços web nem pacotes externos para as regras do jogo.

## Como executar

Pré-requisitos: Flutter SDK instalado e um dispositivo ou emulador Android.

```bash
git clone https://github.com/VitoEmanoel/hangman-game.git
cd hangman-game
flutter pub get
flutter run
```

Para verificar e formatar o código:

```bash
flutter analyze
dart format .
```

## Dependências

Apenas as dependências padrão de um projeto Flutter (`cupertino_icons` e `flutter_lints`). Nenhuma dependência adicional é necessária.

## Estrutura

```text
assets/
  data/
    hangman_entries.json            # respostas, categorias, níveis e dicas
lib/
  main.dart                         # ponto de entrada do aplicativo
  models/
    answer.dart                     # resposta com categoria, dificuldade e dicas
    answer_category.dart            # enum de categorias
    answer_slot.dart                # caractere da resposta exibida
    difficulty.dart                 # enum de dificuldades
    round_status.dart               # enum do estado da rodada
  data/
    answer_repository.dart          # carrega e valida o JSON
  logic/
    text_normalizer.dart            # remove acentos para comparar letras
    hangman_round.dart              # regras de uma rodada
    answer_picker.dart              # sorteio sem repetição
    session_stats.dart              # estatísticas da sessão
    game_controller.dart            # estado do jogo usado pelas telas
  screens/
    home_screen.dart                # escolha de categoria e dificuldade
    game_screen.dart                # rodada e resultado
    stats_screen.dart               # estatísticas
    about_screen.dart               # integrantes da equipe
  widgets/
    option_selector.dart            # seletor de opções
    hangman_drawing.dart            # desenho da forca
    masked_answer.dart              # resposta parcialmente revelada
    letter_keyboard.dart            # teclado de letras
    round_result_panel.dart         # painel de resultado da rodada
    exhausted_answers_message.dart  # aviso de respostas esgotadas
```

As regras do jogo ficam em `logic/`, independentes da interface. As telas leem o estado do `GameController` e os widgets recebem dados prontos para exibir.
