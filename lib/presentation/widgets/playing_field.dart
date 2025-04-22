import 'package:flutter/material.dart';
import 'package:hand_cricket/presentation/widgets/countdown_timer.dart';
import 'package:hand_cricket/presentation/widgets/hand_animation.dart';
import 'package:hand_cricket/presentation/widgets/number_pad.dart';

class PlayingField extends StatelessWidget {
  const PlayingField({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // GameStatusBar(phase: state.phase),
          const SizedBox(height: 60),
          HandAnimation(
            // playerChoice: state.player.currentChoice,
            // botChoice: state.bot.currentChoice,
          ),
          const SizedBox(height: 120),
          const CountdownTimer(),
          const SizedBox(height: 20),
          NumberPad(
            // onNumberSelected: provider.playerChooses
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}
