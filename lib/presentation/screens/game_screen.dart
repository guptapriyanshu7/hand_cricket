// the main game screen as shared
// has a scoreboard
// then names and in the middle total score
// then the hand animations
// the the timer
// then the numpad for the runs

import 'package:flutter/material.dart';
import 'package:hand_cricket/domain/entities/game_state.dart';
import 'package:hand_cricket/presentation/providers/game_provider.dart';
import 'package:hand_cricket/presentation/widgets/scoreboard.dart';
import 'package:provider/provider.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hand Cricket')),
      body: Consumer<GameProvider>(
        builder: (context, provider, _) {
          final state = provider.state;
          return Column(
            children: [
              ScoreBoard(),
              // GameStatusBar(phase: state.phase),
              // HandAnimation(
              //   playerChoice: state.player.currentChoice,
              //   botChoice: state.bot.currentChoice,
              // ),
              // const CountdownTimer(duration: 10),
              // NumberPad(onNumberSelected: provider.playerChooses),
            ],
          );
        },
      ),
    );
  }
}
