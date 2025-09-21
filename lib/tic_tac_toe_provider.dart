import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';

class TicTacToeProvider extends ChangeNotifier {
  List<String> board = List.filled(9, '');
  String currentPlayer = 'X';
  String? winner;
  String? winnerName;
  bool gameEnded = false;
  List<int> winningCells = [];
  int scoreX = 0;
  int scoreO = 0;

  final AudioPlayer _player = AudioPlayer();

  String playerXName = "Player X";
  String playerOName = "Player O";

  /// 🔊 Sound toggle
  bool isSoundOn = true;

  void setPlayers(String xName, String oName) {
    playerXName = xName.isNotEmpty ? xName : "Player X";
    playerOName = oName.isNotEmpty ? oName : "Player O";
    notifyListeners();
  }

  /// Toggle sound ON/OFF
  void toggleSound() {
    isSoundOn = !isSoundOn;
    notifyListeners();
  }

  void makeMove(int index) async {
    if (board[index] != '' || gameEnded) return;

    board[index] = currentPlayer;

    // 🔊 Play sound only if ON
    if (isSoundOn) {
      try {
        String soundFile =
        currentPlayer == 'X' ? 'sounds/select_1.mp3' : 'sounds/select_2.mp3';
        await _player.play(AssetSource(soundFile));
      } catch (e) {
        print("Sound error: $e");
      }
    }

    // 📳 Vibrate
    if (await Vibration.hasVibrator() ?? false) {
      Vibration.vibrate(duration: 100);
    }

    _checkWinner();

    if (!gameEnded) {
      currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
    }

    notifyListeners();
  }

  void _checkWinner() {
    const winningCombinations = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (var combo in winningCombinations) {
      if (board[combo[0]] != '' &&
          board[combo[0]] == board[combo[1]] &&
          board[combo[1]] == board[combo[2]]) {
        winner = board[combo[0]];
        winningCells = combo;
        gameEnded = true;

        if (winner == 'X') {
          winnerName = playerXName;
          scoreX++;
        } else if (winner == 'O') {
          winnerName = playerOName;
          scoreO++;
        }
        return;
      }
    }

    if (!board.contains('')) {
      winner = 'Draw';
      winnerName = "Draw";
      gameEnded = true;
    }
  }

  void resetGame() {
    board = List.filled(9, '');
    currentPlayer = 'X';
    winner = null;
    winnerName = "";
    gameEnded = false;
    winningCells = [];
    notifyListeners();
  }

  void newGame() {
    resetGame();
    scoreX = 0;
    scoreO = 0;
    notifyListeners();
  }
}
