import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// player score circle for the scoreboard showing the runs taken by the player at this ball
class PlayerScoreCircle extends StatelessWidget {
  const PlayerScoreCircle({super.key, required this.runTaken});

  final int? runTaken;

  @override
  Widget build(BuildContext context) {
    final Color circleColor = runTaken != null ? Colors.green : Colors.black;

    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: circleColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(30),
            blurRadius: 2.r,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Center(child: Text(runTaken?.toString() ?? '')),
    );
  }
}
