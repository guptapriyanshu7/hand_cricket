// the main game screen as shared
// has a scoreboard
// then names and in the middle total score
// then the hand animations
// the the timer
// then the numpad for the runs

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hand_cricket/presentation/providers/game_provider.dart';
import 'package:hand_cricket/presentation/widgets/countdown_timer.dart';
import 'package:hand_cricket/presentation/widgets/game_info_bar.dart';
import 'package:hand_cricket/presentation/widgets/game_overview_dialog.dart';
import 'package:hand_cricket/presentation/widgets/hand_animation.dart';
import 'package:hand_cricket/presentation/widgets/number_pad.dart';
import 'package:hand_cricket/presentation/widgets/player_highlights_dialog.dart';
import 'package:hand_cricket/presentation/widgets/scoreboard.dart';
import 'package:provider/provider.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late GameProvider _gameProvider;
  late VoidCallback _listener;
    @override
  void initState() {
    super.initState();
    _gameProvider = context.read<GameProvider>();

    _listener = () {
      final event = _gameProvider.overlayEvent;
      final data = _gameProvider.overlayData;
      switch (event) {
        case OverlayEvent.playerSix:
          playerHighlightsDialog(context, 'assets/sixer.png');
          break;
        case OverlayEvent.playerBattingStart:
          playerHighlightsDialog(context, 'assets/batting.png');
          break;
        case OverlayEvent.playerOut:
          playerHighlightsDialog(context, 'assets/out.png');
          break;
        case OverlayEvent.playerDefend:
          playerHighlightsDialog(
            context,
            'assets/game_defend.webp',
            supportingText: data,
          );
          break;
        case OverlayEvent.gameWon:
        case OverlayEvent.gameLost:
        case OverlayEvent.gameDraw:
        case OverlayEvent.timeOut:
          gameOverviewDialog(context, event, data);
          break;
        case OverlayEvent.none:
          break;
      }
    };

    _gameProvider.addListener(_listener);
  }

  @override
  void dispose() {
    _gameProvider.removeListener(_listener);
    super.dispose();
  }

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
            child: Column(
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
          ),
        ),
      ),
    );
  }
}
