import 'package:flutter/material.dart';

class PlayerScoreCircle extends StatelessWidget {
  const PlayerScoreCircle({super.key, required this.runTaken});

  final int? runTaken;

  @override
  Widget build(BuildContext context) {
    final Color circleColor = runTaken != null ? Colors.green : Colors.black;

    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: circleColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(30),
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Center(
        child: Text(
          runTaken?.toString() ?? '',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
