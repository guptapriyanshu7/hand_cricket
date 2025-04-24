import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hand_cricket/core/app_theme.dart';
import 'package:hand_cricket/domain/entities/game_state.dart';
import 'package:hand_cricket/presentation/providers/game_provider.dart';
import 'package:hand_cricket/presentation/widgets/custom_clippers.dart';
import 'package:hand_cricket/presentation/widgets/player_bowl_circle.dart';
import 'package:hand_cricket/presentation/widgets/player_score_circle.dart';
import 'package:provider/provider.dart';

// a widget to display the scoreboard of the game (player - left and bot - right)
// will update as who is batting and who is bowling
class ScoreBoard extends StatelessWidget {
  const ScoreBoard({super.key});

  int? getRunForIndex(List<int> runHistory, int index) {
    return runHistory.length > index ? runHistory[index] : null;
  }

  @override
  Widget build(BuildContext context) {
    final gamePhase = context.select(
      (GameProvider provider) => provider.state.phase,
    );
    final playerRunHistory = context.select(
      (GameProvider provider) => provider.state.player.runHistory,
    );
    final botRunHistory = context.select(
      (GameProvider provider) => provider.state.bot.runHistory,
    );
    final ballsRemaining = context.select(
      (GameProvider provider) => provider.state.ballsRemaining,
    );
    final ballsBowled = 6 - ballsRemaining;

    return SizedBox(
      height: 120.w,
      child: Row(
        children: [
          Expanded(
            child: Stack(
              children: [
                ClipPath(
                  clipper: LeftSlantClipper(),
                  child: Container(
                    decoration: BoxDecoration(gradient: AppTheme.goldGradient),
                  ),
                ),
                ClipPath(
                  clipper: LeftTrapeziumClipper(),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: AppTheme.blueGreyGradientLtr,
                    ),
                    padding:
                        const EdgeInsets.only(
                          top: 30,
                          left: 70,
                          bottom: 10,
                          right: 55,
                        ).r,
                    child: GridView.count(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 8,
                      children: List.generate(6, (index) {
                        return gamePhase == GamePhase.playerBatting
                            ? PlayerScoreCircle(
                              runTaken: getRunForIndex(playerRunHistory, index),
                            )
                            : PlayerBowlCircle(
                              isBallBowled: ballsBowled >= index + 1,
                            );
                      }),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: Stack(
              children: [
                ClipPath(
                  clipper: RightSlantClipper(),
                  child: Container(
                    decoration: BoxDecoration(gradient: AppTheme.redGradient),
                  ),
                ),
                ClipPath(
                  clipper: RightTrapeziumClipper(),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: AppTheme.blueGreyGradientRtl,
                    ),
                    padding:
                        const EdgeInsets.only(
                          top: 30,
                          left: 55,
                          bottom: 10,
                          right: 70,
                        ).r,
                    child: GridView.count(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 8,
                      children: List.generate(6, (index) {
                        return gamePhase == GamePhase.botBatting ||
                                gamePhase == GamePhase.gameOver
                            ? PlayerScoreCircle(
                              runTaken: getRunForIndex(botRunHistory, index),
                            )
                            : PlayerBowlCircle(
                              isBallBowled: ballsBowled >= index + 1,
                            );
                      }),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
