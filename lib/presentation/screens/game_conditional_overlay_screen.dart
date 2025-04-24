import 'package:flutter/material.dart';
import 'package:hand_cricket/presentation/providers/game_provider.dart';
import 'package:hand_cricket/presentation/widgets/game_overview.dart';
import 'package:hand_cricket/presentation/widgets/player_highlights_dialog.dart';
import 'package:provider/provider.dart';

class GameConditionalOverlay extends StatefulWidget {
  const GameConditionalOverlay({super.key});

  @override
  State<GameConditionalOverlay> createState() => _GameConditionalOverlayState();
}

class _GameConditionalOverlayState extends State<GameConditionalOverlay> {
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
    return SizedBox.shrink();
  }
}
