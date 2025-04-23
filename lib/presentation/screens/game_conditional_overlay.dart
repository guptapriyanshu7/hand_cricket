import 'package:flutter/material.dart';
import 'package:hand_cricket/domain/entities/game_state.dart';
import 'package:hand_cricket/presentation/providers/game_provider.dart';
import 'package:hand_cricket/presentation/widgets/game_result_widget.dart';
import 'package:hand_cricket/presentation/widgets/player_highlights_dialog.dart';
import 'package:provider/provider.dart';

class GameConditionalOverlay extends StatelessWidget {
  const GameConditionalOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    final gameState = context.select((GameProvider provider) => provider.state);

    if (gameState.phase == GamePhase.playerBatting &&
        gameState.player.currentChoice == 6) {
      playerHighlightsDialog(context, 'assets/sixer.png');
    }

    if (gameState.phase == GamePhase.botBatting &&
        gameState.ballsRemaining == 6) {
      if (gameState.player.isOut) {
        playerHighlightsDialog(context, 'assets/out.png');
      }

      // if last ball player played was a six
      if (gameState.player.currentChoice == 6) {
        playerHighlightsDialog(context, 'assets/sixer.png');
      }

      Future.delayed(
        Duration(
          milliseconds:
              gameState.player.isOut || (gameState.player.currentChoice == 6)
                  ? 1200
                  : 0,
        ),
        () {
          if (context.mounted) {
            playerHighlightsDialog(
              context,
              'assets/game_defend.webp',
              supportingText: gameState.player.score.toString(),
            );
          }
        },
      );
    }

    if (gameState.phase == GamePhase.gameOver) {
      return Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.9)),
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
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
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
    return SizedBox.shrink();
  }
}
