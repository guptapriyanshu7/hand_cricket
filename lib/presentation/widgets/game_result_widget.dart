import 'package:flutter/material.dart';

class GameResultWidget extends StatelessWidget {
  final String result;
  const GameResultWidget({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18),
      child: Column(
        children: [
          Image.asset('assets/bails.png'),
          const SizedBox(height: 20),
          ShaderMask(
            shaderCallback:
                (bounds) => LinearGradient(
                  colors: [
                    const Color.fromARGB(255, 245, 101, 101),
                    Colors.white,
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ).createShader(bounds),
            child: Text(
              result,
              style: TextStyle(
                color: Colors.white,
                fontSize: 54,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
