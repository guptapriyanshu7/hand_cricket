import 'package:flutter/material.dart';
import 'package:hand_cricket/presentation/providers/game_provider.dart';
import 'package:provider/provider.dart';

class PlayerScoreCircle extends StatelessWidget {
  const PlayerScoreCircle({
    super.key,
    required this.isBatting,
    required this.isBowling,
    required this.index,
    required this.runTaken,
  });

  final bool isBatting;
  final bool isBowling;
  final int index;
  final int runTaken;

  @override
  Widget build(BuildContext context) {
    final ballsRemaining = context.select(
      (GameProvider provider) => provider.state.ballsRemaining,
    );
    final ballsBowled = 6 - ballsRemaining;
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color:
            isBatting
                ? ballsBowled < index + 1
                    ? Colors.black
                    : Colors.green
                : Colors.black,
        image:
            isBowling
                ? DecorationImage(
                  image: AssetImage('assets/ball.png'),
                  fit: BoxFit.cover,
                  opacity: ballsBowled < index + 1 ? 0.5 : 1.0,
                )
                : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(30),
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child:
          isBatting && ballsBowled >= index + 1
              ? Center(
                child: Text(
                  runTaken.toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
              : null,
    );
  }
}
