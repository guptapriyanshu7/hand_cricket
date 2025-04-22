import 'package:flutter/material.dart';

class GameInfoBar extends StatelessWidget {
  const GameInfoBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'You',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          // display 'to win' in a golden gradient small container with black text and rounded bottom corners
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              gradient: const RadialGradient(
                radius: 1.5,
                colors: [Color.fromARGB(255, 235, 204, 124), Color(0xFFD4B052)],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: const Text(
                'To Win: 0',
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ),
          ),
          const Text(
            'Bot',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
