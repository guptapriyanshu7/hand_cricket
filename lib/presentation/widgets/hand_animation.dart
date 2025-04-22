import 'package:flutter/material.dart';

class HandAnimation extends StatelessWidget {
  const HandAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 200,
      decoration: BoxDecoration(
        color: Colors.transparent.withAlpha(100),
        border: Border.all(color: const Color(0xFFD4B052), width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          'Hand Animation',
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
    );
  }
}
