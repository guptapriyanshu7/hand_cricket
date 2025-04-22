import 'package:flutter/material.dart';

class CountdownTimer extends StatelessWidget {
  const CountdownTimer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 80,
          height: 80,
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Use CircularProgressIndicator here
              CircularProgressIndicator(
                value: 6 / 10, // Progress value
                backgroundColor: Colors.black, // Background circle color
                valueColor: const AlwaysStoppedAnimation<Color>(
                  Colors.red,
                ), // Progress color
                strokeWidth: 5, // Stroke width
              ),
              // Center widget to display the countdown text
              Center(
                child: Text(
                  6.toString(),
                  style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'Pick a number before timer runs out',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ],
    );
  }
}
