import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'tic_tac_toe_provider.dart';
import 'player_setup_screen.dart';

class TicTacToeScreen extends StatefulWidget {
  const TicTacToeScreen({super.key});

  @override
  State<TicTacToeScreen> createState() => _TicTacToeScreenState();
}

class _TicTacToeScreenState extends State<TicTacToeScreen> {

  @override
  initState() {
    super.initState();
    Provider.of<TicTacToeProvider>(context, listen: false).newGame();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: SafeArea(
        child: Consumer<TicTacToeProvider>(
          builder: (context, game, child) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 12),
                  const Text(
                    "Tic Tac Toe",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Classic Strategy Game",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        )
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.circle,
                          size: 12,
                          color: game.winner == null
                              ? Colors.black
                              : (game.winner == "X"
                              ? Colors.redAccent
                              : Colors.blueAccent),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          game.winner != null
                              ? (game.winner == "Draw"
                              ? "It's a Draw!"
                              : "Player ${game.winnerName} Wins!")
                              : "Player ${game.currentPlayer}'s Turn",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  _buildGameBoard(context, game),
                  const SizedBox(height: 24),

                  if (game.gameEnded)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          )
                        ],
                      ),
                      child: Column(
                        children: [
                          Text(
                            game.winner == "Draw"
                                ? "It's a Draw! 🤝"
                                : "Player ${game.winnerName} Wins!",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            game.winner == "Draw"
                                ? "That was close!"
                                : "Congratulations on your victory!",
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),

                  const SizedBox(height: 16),
                  _buildControlButtons(context, game),
                  const SizedBox(height: 16),
                  _buildScoreBoard(game),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildControlButtons(BuildContext context, TicTacToeProvider game) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: game.resetGame,
            icon: const Icon(Icons.refresh),
            label: const Text("Restart"),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () {
              game.newGame();
              Navigator.pushNamed(context, '/setup');
            },
            icon: const Icon(Icons.fiber_new),
            label: const Text("New Game"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              foregroundColor: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildScoreBoard(TicTacToeProvider game) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text("${game.playerXName}: ${game.scoreX}",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Text("${game.playerOName}: ${game.scoreO}",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildGameBoard(BuildContext context, TicTacToeProvider game) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: 9,
      itemBuilder: (context, index) {
        final isWinningCell = game.winningCells.contains(index);
        final isHighlighted = game.gameEnded && isWinningCell;

        return GestureDetector(
          onTap: () => game.makeMove(index),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
              boxShadow: isHighlighted
                  ? [

                BoxShadow(
                  color: Colors.amber.withOpacity(0.5),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ]
                  : [],
            ),
            child: Center(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return ScaleTransition(scale: animation, child: child);
                },
                child: Text(
                  game.board[index],
                  key: ValueKey<String>(game.board[index]),
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: game.board[index] == 'X'
                        ? Colors.redAccent
                        : Colors.blueAccent,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
