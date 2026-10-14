**Integrantes:**

- Victor Emanoel Lima Silva
- Richard Costa De Brito
- Francisco Osmar Santos Silva

# Jogo da Forca (hangman-game)

Aplicativo do Jogo da Forca para Android, desenvolvido em Flutter como trabalho da disciplina de Programação para Dispositivos Móveis (UESPI). O jogador escolhe uma categoria e um nível de dificuldade e tenta descobrir a resposta oculta escolhendo letras, antes que o boneco da forca seja completado.

O aplicativo funciona totalmente offline: respostas, categorias, níveis e dicas vêm de um arquivo JSON incluído nos assets do projeto.

## Funcionalidades

- Escolha de categoria (Animais, Corpo humano, Esportes, Tecnologia) e dificuldade (Fácil, Médio, Difícil).
- Sorteio de respostas sem repetição durante a sessão, com aviso quando as respostas de uma combinação se esgotam.
- Respostas com uma ou mais palavras; espaços e hífens aparecem automaticamente.
- Tentativas apenas por letras, ignorando acentos na comparação e preservando a grafia original na tela.
- Desenho progressivo da forca a cada erro.
- Dica por rodada, contabilizada uma única vez.
- Resultado da rodada com resposta completa, quantidade de erros e uso de dica.
- Estatísticas da sessão: rodadas, vitórias, derrotas, percentuais, erros e dicas.
- Tela com os nomes dos integrantes da equipe.

## Status do desenvolvimento

- [x] Modelos e enums do domínio (`lib/models/`)
- [x] Carregamento e validação do JSON (`lib/data/`)
- [x] Banco de respostas declarado como asset
- [ ] Regras do jogo e estado da sessão (`lib/logic/`)
- [ ] Telas e componentes visuais (`lib/screens/` e `lib/widgets/`)

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
    hangman_entries.json    # respostas, categorias, níveis e dicas
lib/
  data/
    answer_repository.dart  # carrega e valida o JSON
  models/
    answer.dart             # resposta com categoria, dificuldade e dicas
    answer_category.dart    # enum de categorias
    answer_slot.dart        # caractere da resposta exibida
    difficulty.dart         # enum de dificuldades
    round_status.dart       # enum do estado da rodada
  main.dart                 # ponto de entrada do aplicativo
```
