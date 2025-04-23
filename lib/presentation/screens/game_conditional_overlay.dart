import 'package:flutter/material.dart';
import 'package:hand_cricket/domain/entities/game_state.dart';
import 'package:hand_cricket/presentation/providers/game_provider.dart';
import 'package:hand_cricket/presentation/widgets/animated_visibility_widget.dart';
import 'package:provider/provider.dart';

class GameConditionalOverlay extends StatelessWidget {
  const GameConditionalOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    final gameState = context.select((GameProvider provider) => provider.state);
    if (gameState.phase == GamePhase.playerBatting &&
        gameState.player.currentChoice == 6) {
      return AnimatedVisibilityWidget(assetImage: 'assets/sixer.png');
    }

    if (gameState.phase != GamePhase.gameOver &&
        gameState.ballsRemaining != 6 &&
        gameState.player.currentChoice == gameState.bot.currentChoice) {
      return AnimatedVisibilityWidget(assetImage: 'assets/out.png');
    }

    if (gameState.phase == GamePhase.botBatting &&
        gameState.ballsRemaining == 6) {
      return AnimatedVisibilityWidget(
        assetImage: 'assets/game_defend.webp',
        supportingText: gameState.player.score.toString(),
      );
    }

    if (gameState.phase == GamePhase.gameOver) {
      return Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.7),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.7)),
          child: Center(
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
        ),
      );
    }

    return SizedBox.shrink();
  }
}
