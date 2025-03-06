import 'package:flutter/material.dart';
import 'game_logic.dart';

void main() {
  runApp(HangmanApp());
}

class HangmanApp extends StatefulWidget {
  @override
  _HangmanAppState createState() => _HangmanAppState();
}

class _HangmanAppState extends State<HangmanApp> {
  late HangmanGame game;

  @override
  void initState() {
    super.initState();
    game = HangmanGame();
  }

  void onLetterGuessed(String letter) {
    if (!game.isGameOver()) {
      setState(() {
        game.makeGuess(letter);
      });
    }
  }

  void restartGame() {
    setState(() {
      game.startNewGame();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Hangman Game')),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Wrong guesses left: ${game.maxWrongGuesses - game.wrongGuesses}",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Text(
              game.getWordDisplay(),
              style: TextStyle(fontSize: 30, letterSpacing: 2),
            ),
            SizedBox(height: 20),
            Text(
              "Guessed Letters: ${game.guessedLetters.join(', ')}",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            if (!game.isGameOver()) buildKeyboard(),
            if (game.isGameOver())
              Column(
                children: [
                  Text(
                    game.isGameWon() ? "You WON! 🎉" : "You LOST! 😢",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(onPressed: restartGame, child: Text("Play Again"))
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget buildKeyboard() {
    return Wrap(
      spacing: 5,
      runSpacing: 5,
      children: 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'.split('').map((letter) {
        return ElevatedButton(
          onPressed: game.guessedLetters.contains(letter) ? null : () => onLetterGuessed(letter),
          child: Text(letter),
        );
      }).toList(),
    );
  }
}
