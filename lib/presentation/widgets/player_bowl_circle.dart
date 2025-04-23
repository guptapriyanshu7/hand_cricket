
import 'package:flutter/material.dart';

class PlayerBowlCircle extends StatelessWidget {
  const PlayerBowlCircle({super.key, required this.isBallBowled});

  final bool isBallBowled;

  @override
  Widget build(BuildContext context) {
    final double opacity = isBallBowled ? 1.0 : 0.5;

    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: AssetImage('assets/ball.png'),
          fit: BoxFit.cover,
          opacity: opacity,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(30),
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
    );
  }
}
