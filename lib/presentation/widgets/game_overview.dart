import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hand_cricket/presentation/providers/game_provider.dart';
import 'package:hand_cricket/presentation/widgets/game_result_widget.dart';
import 'package:provider/provider.dart';

// this widget will notify the outcome of the game and insist the user to play again
class GameOverview extends StatelessWidget {
  const GameOverview({super.key});

  @override
  Widget build(BuildContext context) {
    final gameState = context.select((GameProvider provider) => provider.state);
    return Container(
      height: 1.sh,
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
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(fontSize: 24.sp),
              ),
            SizedBox(height: 20.h),
          ] else if (gameState.player.score > gameState.bot.score)
            Padding(
              padding: const EdgeInsets.all(12.0).r,
              child: Column(
                children: [
                  Image.asset('assets/you_won.png'),
                  Text(
                    'Your score: ${gameState.player.score}',
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(fontSize: 24.sp),
                  ),
                ],
              ),
            )
          else
            GameResultWidget(result: 'Scores tied!'),
          SizedBox(height: 20.h),
          Center(
            child: TextButton(
              onPressed: () {
                context.read<GameProvider>().reset();
              },
              child: Text(
                'Play Again',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(fontSize: 24.sp),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
