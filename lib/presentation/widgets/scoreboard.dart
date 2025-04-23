import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hand_cricket/domain/entities/game_state.dart';
import 'package:hand_cricket/presentation/providers/game_provider.dart';
import 'package:hand_cricket/presentation/widgets/custom_clippers.dart';
import 'package:hand_cricket/presentation/widgets/player_bowl_circle.dart';
import 'package:hand_cricket/presentation/widgets/player_score_circle.dart';
import 'package:provider/provider.dart';

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
      height: 100.h,
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            child: Stack(
              children: [
                ClipPath(
                  clipper: LeftSlantClipper(),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFFD4B052),
                          Color.fromARGB(255, 235, 204, 124),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ),
                ClipPath(
                  clipper: LeftTrapeziumClipper(),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.blueGrey, Colors.blueGrey[900]!],
                        begin: Alignment.bottomRight,
                        end: Alignment.topLeft,
                      ),
                    ),
                    padding:
                        const EdgeInsets.only(
                          top: 5,
                          left: 45,
                          bottom: 5,
                          right: 35,
                        ).r,
                    child: GridView.count(
                      crossAxisCount: 3,
                      children: List.generate(6, (index) {
                        return Center(
                          child:
                              gamePhase == GamePhase.playerBatting
                                  ? PlayerScoreCircle(
                                    runTaken: getRunForIndex(
                                      playerRunHistory,
                                      index,
                                    ),
                                  )
                                  : PlayerBowlCircle(
                                    isBallBowled: ballsBowled >= index + 1,
                                  ),
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
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFFC42C31),
                          Color.fromARGB(255, 235, 62, 67),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ),
                ClipPath(
                  clipper: RightTrapeziumClipper(),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.blueGrey, Colors.blueGrey[900]!],
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                      ),
                    ),
                    padding:
                        const EdgeInsets.only(
                          top: 5,
                          left: 35,
                          bottom: 5,
                          right: 45,
                        ).r,
                    child: GridView.count(
                      crossAxisCount: 3,
                      children: List.generate(6, (index) {
                        return Center(
                          child:
                              gamePhase == GamePhase.botBatting ||
                                      gamePhase == GamePhase.gameOver
                                  ? PlayerScoreCircle(
                                    runTaken: getRunForIndex(
                                      botRunHistory,
                                      index,
                                    ),
                                  )
                                  : PlayerBowlCircle(
                                    isBallBowled: ballsBowled >= index + 1,
                                  ),
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
