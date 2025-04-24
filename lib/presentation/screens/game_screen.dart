// the main game screen as shared
// has a scoreboard
// then names and in the middle total score
// then the hand animations
// the the timer
// then the numpad for the runs

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hand_cricket/presentation/screens/game_conditional_overlay_screen.dart';
import 'package:hand_cricket/presentation/widgets/countdown_timer.dart';
import 'package:hand_cricket/presentation/widgets/game_info_bar.dart';
import 'package:hand_cricket/presentation/widgets/hand_animation.dart';
import 'package:hand_cricket/presentation/widgets/number_pad.dart';
import 'package:hand_cricket/presentation/widgets/scoreboard.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                Column(
                  children: [
                    ScoreBoard(),
                    GameInfoBar(),
                    SizedBox(height: 60.h),
                    HandAnimation(),
                    SizedBox(height: 100.h),
                    const CountdownTimer(),
                    SizedBox(height: 20.h),
                    NumberPad(),
                    SizedBox(height: 15.h),
                  ],
                ),
                GameConditionalOverlay(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
