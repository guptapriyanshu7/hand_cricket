import 'package:flutter/material.dart';

class ScoreBoard extends StatelessWidget {

  const ScoreBoard({super.key});

  @override
  Widget build(BuildContext context) {
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
                  child: Container(color: Color(0xFFD4B052)),
                ),
                ClipPath(
                  clipper: MiddleLeftSlantClipper(),
                  child: Container(
                    color: Colors.blueGrey,
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
                              color: Colors.white.withValues(alpha: 0.8),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.3),
                                  blurRadius: 2,
                                  offset: Offset(0, 1),
                                ),
                              ],
                            ),
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
                  child: Container(color: Color(0xFFC42C31)),
                ),
                ClipPath(
                  clipper: MiddleRightSlantClipper(),
                  child: Container(
                    color: Colors.blueGrey,
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
                              color: Color(0xFF25A244),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  blurRadius: 2,
                                  offset: Offset(0, 1),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                '${index + 1}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
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
    path.lineTo(size.width * 0.83, 0);
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
    path.lineTo(size.width * 0.17, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(size.width * 0.17, 0);
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
