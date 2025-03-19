class HangmanGame {
  final List<String> words = ['SAD', 'FLUTTER', 'VSCODE', 'PYTHON', 'PEOPLE'];
  late String wordToGuess;
  int wrongGuesses = 0;
  final List<String> guessedLetters = [];
  static const int maxWrongGuesses = 6;

  HangmanGame() {
    startNewGame();
  }

  void startNewGame() {
    wordToGuess = words[(words.length * (DateTime.now().millisecondsSinceEpoch % 1000)) % words.length];
    wrongGuesses = 0;
    guessedLetters.clear();
  }

  String getWordDisplay() {
    return wordToGuess
        .split('')
        .map((letter) => guessedLetters.contains(letter) ? letter : '_')
        .join(' ');
  }

  void makeGuess(String letter) {
    if (guessedLetters.contains(letter) || wrongGuesses >= maxWrongGuesses) return;

    guessedLetters.add(letter);

    if (!wordToGuess.contains(letter)) {
      wrongGuesses++;
    }
  }

  bool isGameOver() {
    return wrongGuesses >= maxWrongGuesses || isGameWon();
  }

  bool isGameWon() {
    return wordToGuess.split('').every((letter) => guessedLetters.contains(letter));
  }
}
