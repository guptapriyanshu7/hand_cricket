import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hand_cricket/presentation/providers/game_provider.dart';
import 'package:provider/provider.dart';

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
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
          ),
          Container(
            padding: const EdgeInsets.all(8.0).r,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                radius: 1.5.r,
                colors: [Color.fromARGB(255, 235, 204, 124), Color(0xFFD4B052)],
              ),
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
                style: TextStyle(color: Colors.black, fontSize: 16.sp),
              ),
            ),
          ),
          Text(
            'Bot: $botScore',
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
