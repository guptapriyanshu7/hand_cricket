import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PlayerBowlCircle extends StatelessWidget {
  const PlayerBowlCircle({super.key, required this.isBallBowled});

  final bool isBallBowled;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 24.w,
        height: 24.h,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: AssetImage('assets/ball.png'),
            fit: BoxFit.cover,
            opacity: isBallBowled ? 1.0 : 0.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(30),
              blurRadius: 2.r,
              offset: Offset(0, 1),
            ),
          ],
        ),
      ),
    );
  }
}
