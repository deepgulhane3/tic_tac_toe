import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'tic_tac_toe_provider.dart';
import 'tic_tac_toe_screen.dart';

class PlayerSetupScreen extends StatefulWidget {
  const PlayerSetupScreen({super.key});

  @override
  State<PlayerSetupScreen> createState() => _PlayerSetupScreenState();
}

class _PlayerSetupScreenState extends State<PlayerSetupScreen> {
  final TextEditingController _playerXController = TextEditingController();
  final TextEditingController _playerOController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.sports_esports,
                  size: 80,
                  color: Colors.black87,
                ),
                const SizedBox(height: 16),
                const Text(
                  "Tic Tac Toe",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                const Text(
                  "Challenge your mind. Play Tic Tac Toe!",
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),

                // Player inputs
                TextField(
                  controller: _playerXController,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    labelText: "Player One (X)",
                    hintText: "Enter Player 1 name",
                    prefixIcon: const Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _playerOController,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    labelText: "Player Two (O)",
                    hintText: "Enter Player 2 name",
                    prefixIcon: const Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      final provider =
                      Provider.of<TicTacToeProvider>(context, listen: false);

                      provider.setPlayers(
                        _playerXController.text,
                        _playerOController.text,
                      );

                      Navigator.pushNamed(context, '/tic_tac_toe');
                    },
                    icon: const Icon(Icons.play_arrow),
                    label: const Text(
                      "Start Game",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  "Empty names will default to Player 1 & Player 2",
                  style: TextStyle(fontSize: 12, color: Colors.black54),
                ),
                const SizedBox(height: 32),

                // How to Play
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: const [
                        Text(
                          "How to Play",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 12),
                        Row(
                          children: [
                            Icon(Icons.check_circle_outline, size: 20),
                            SizedBox(width: 8),
                            Expanded(
                                child: Text(
                                    "Players take turns placing X and O on the grid")),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.check_circle_outline, size: 20),
                            SizedBox(width: 8),
                            Expanded(child: Text("First to get 3 in a row wins")),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.check_circle_outline, size: 20),
                            SizedBox(width: 8),
                            Expanded(
                                child: Text(
                                    "Horizontal, vertical, or diagonal counts")),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 32),

                // Bottom controls
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Consumer<TicTacToeProvider>(
                      builder: (context, value, child) {
                        return IconButton(
                          icon: Icon(
                            value.isSoundOn ? Icons.volume_up : Icons.volume_off,
                            size: 28,
                            color: value.isSoundOn ? Colors.black87 : Colors.redAccent,
                          ),
                          onPressed: () {
                            value.toggleSound();
                          },
                        );
                      }
                    ),

                  ],
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
