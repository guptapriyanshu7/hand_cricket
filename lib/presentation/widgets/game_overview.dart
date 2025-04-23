import 'package:flutter/material.dart';
import 'package:hand_cricket/presentation/providers/game_provider.dart';
import 'package:hand_cricket/presentation/widgets/game_result_widget.dart';
import 'package:provider/provider.dart';

class GameOverview extends StatelessWidget {
  const GameOverview({super.key});

  @override
  Widget build(BuildContext context) {
    final gameState = context.select((GameProvider provider) => provider.state);
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.8)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (gameState.player.score < gameState.bot.score ||
              gameState.playerTimedOut) ...[
            GameResultWidget(result: 'You lose!'),
            if (gameState.playerTimedOut)
              Text(
                'Clock ran out!',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            const SizedBox(height: 20),
          ] else if (gameState.player.score > gameState.bot.score)
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Image.asset('assets/you_won.png'),
                  Text(
                    'Your score: ${gameState.player.score}',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            )
          else
            GameResultWidget(result: 'Scores tied!'),
          const SizedBox(height: 20),
          Center(
            child: TextButton(
              onPressed: () {
                context.read<GameProvider>().reset();
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.orange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.symmetric(vertical: 18, horizontal: 30),
              ),
              child: Text(
                'Play Again',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
