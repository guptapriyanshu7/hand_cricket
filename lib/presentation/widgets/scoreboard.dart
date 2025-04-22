import 'package:flutter/material.dart';
import 'package:hand_cricket/domain/entities/game_state.dart';
import 'package:hand_cricket/presentation/providers/game_provider.dart';
import 'package:provider/provider.dart';

class ScoreBoard extends StatelessWidget {
  const ScoreBoard({super.key});

  @override
  Widget build(BuildContext context) {
    final gamePhase = context.select(
      (GameProvider provider) => provider.state.phase,
    );
    final ballsRemaining = context.select(
      (GameProvider provider) => provider.state.ballsRemaining,
    );
    final playerCurrentChoice = context.select(
      (GameProvider provider) => provider.state.player.currentChoice,
    );
    final botCurrentChoice = context.select(
      (GameProvider provider) => provider.state.bot.currentChoice,
    );
    return SizedBox(
      height: 100,
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            child: Stack(
              children: [
                ClipPath(
                  clipper: RightSlantClipper(),
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
                  clipper: MiddleLeftSlantClipper(),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.blueGrey, Colors.blueGrey[900]!],
                        begin: Alignment.bottomRight,
                        end: Alignment.topLeft,
                      ),
                    ),
                    padding: const EdgeInsets.only(
                      top: 5,
                      left: 45,
                      bottom: 5,
                      right: 35,
                    ),
                    child: GridView.count(
                      crossAxisCount: 3,
                      children: List.generate(6, (index) {
                        return Center(
                          child: Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color:
                                  gamePhase == GamePhase.playerBatting
                                      ? 6 - ballsRemaining < index + 1
                                          ? Colors.black
                                          : Colors.green
                                      : Colors.black,

                              image:
                                  gamePhase == GamePhase.botBatting
                                      ? DecorationImage(
                                        image: AssetImage('assets/ball.png'),
                                        fit: BoxFit.cover,
                                        opacity:
                                            6 - ballsRemaining < index + 1
                                                ? 0.5
                                                : 1.0,
                                      )
                                      : null,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.3),
                                  blurRadius: 2,
                                  offset: Offset(0, 1),
                                ),
                              ],
                            ),
                            child:
                                gamePhase == GamePhase.playerBatting
                                    ? 6 - ballsRemaining < index + 1
                                        ? null
                                        : Center(
                                          child: Text(
                                            playerCurrentChoice.toString(),
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        )
                                    : null,
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
                  clipper: LeftSlantClipper(),
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
                  clipper: MiddleRightSlantClipper(),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.blueGrey, Colors.blueGrey[900]!],
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                      ),
                    ),
                    padding: const EdgeInsets.only(
                      top: 5,
                      left: 35,
                      bottom: 5,
                      right: 45,
                    ),
                    child: GridView.count(
                      crossAxisCount: 3,
                      children: List.generate(6, (index) {
                        return Center(
                          child: Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color:
                                  gamePhase == GamePhase.botBatting
                                      ? 6 - ballsRemaining < index + 1
                                          ? Colors.black
                                          : Colors.green
                                      : Colors.black,
                              image:
                                  gamePhase == GamePhase.playerBatting
                                      ? DecorationImage(
                                        image: AssetImage('assets/ball.png'),
                                        fit: BoxFit.cover,
                                        opacity:
                                            6 - ballsRemaining < index + 1
                                                ? 0.5
                                                : 1.0,
                                      )
                                      : null,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.3),
                                  blurRadius: 2,
                                  offset: Offset(0, 1),
                                ),
                              ],
                            ),
                            child:
                                gamePhase == GamePhase.botBatting
                                    ? 6 - ballsRemaining < index + 1
                                        ? null
                                        : Center(
                                          child: Text(
                                            botCurrentChoice.toString(),
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        )
                                    : null,
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

class RightSlantClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, 0);
    path.lineTo(size.width * 0.82, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class LeftSlantClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(size.width * 0.18, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(size.width * 0.18, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class MiddleLeftSlantClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(size.width * 0.25, 0);
    path.lineTo(size.width * 0.8, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width * 0.05, size.height);
    path.lineTo(size.width * 0.25, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class MiddleRightSlantClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(size.width * 0.2, 0);
    path.lineTo(size.width * 0.75, 0);
    path.lineTo(size.width * 0.95, size.height);
    path.lineTo(0, size.height);
    path.lineTo(size.width * 0.2, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
