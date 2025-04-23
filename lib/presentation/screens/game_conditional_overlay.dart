import 'package:flutter/material.dart';
import 'package:hand_cricket/domain/entities/game_state.dart';
import 'package:hand_cricket/presentation/providers/game_provider.dart';
import 'package:hand_cricket/presentation/widgets/game_overview.dart';
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
      if (gameState.player.currentChoice == 6 && !gameState.player.isOut) {
        playerHighlightsDialog(context, 'assets/sixer.png');
      }

      final delay =
          gameState.player.isOut || gameState.player.currentChoice == 6
              ? const Duration(milliseconds: 1200)
              : Duration.zero;

      Future.delayed(delay, () {
        if (!context.mounted) return;
        playerHighlightsDialog(
          context,
          'assets/game_defend.webp',
          supportingText: gameState.player.score.toString(),
        );
      });
    }

    if (gameState.phase == GamePhase.gameOver) {
      return GameOverview();
    }
    return SizedBox.shrink();
  }
}
