import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hand_cricket/core/app_theme.dart';
import 'package:hand_cricket/presentation/providers/game_provider.dart';
import 'package:provider/provider.dart';

// showing the player and bot's score and the score needed to win
class GameInfoBar extends StatelessWidget {
  const GameInfoBar({super.key});

  @override
  Widget build(BuildContext context) {
    final playerScore = context.select(
      (GameProvider provider) => provider.state.player.score,
    );
    final botScore = context.select(
      (GameProvider provider) => provider.state.bot.score,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0).r,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'You: $playerScore',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontSize: 18.sp),
          ),
          Container(
            padding: const EdgeInsets.all(8.0).r,
            decoration: BoxDecoration(
              gradient: AppTheme.goldRadialGradient,
              borderRadius:
                  BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ).r,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0).r,
              child: Text(
                'To Win: ${playerScore - botScore < 0 ? 0 : playerScore - botScore}',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: Colors.black),
              ),
            ),
          ),
          Text(
            'Bot: $botScore',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontSize: 18.sp),
          ),
        ],
      ),
    );
  }
}
