import 'dart:math';

class HangmanGame {
  final List<String> words = ["flutter", "programming", "dart", "hangman", "widget"];
  late String wordToGuess;
  late List<String> guessedLetters;
  int wrongGuesses = 0;
  final int maxWrongGuesses = 6;

  HangmanGame() {
    startNewGame();
  }

  void startNewGame() {
    wordToGuess = words[Random().nextInt(words.length)].toUpperCase();
    guessedLetters = [];
    wrongGuesses = 0;
  }

  bool makeGuess(String letter) {
    letter = letter.toUpperCase();
    if (!guessedLetters.contains(letter)) {
      guessedLetters.add(letter);
      if (!wordToGuess.contains(letter)) {
        wrongGuesses++;
      }
      return true;
    }
    return false;
  }

  String getWordDisplay() {
    return wordToGuess.split('').map((char) => guessedLetters.contains(char) ? char : '_').join(' ');
  }

  bool isGameOver() => wrongGuesses >= maxWrongGuesses || isGameWon();

  bool isGameWon() => wordToGuess.split('').every((char) => guessedLetters.contains(char));
}
