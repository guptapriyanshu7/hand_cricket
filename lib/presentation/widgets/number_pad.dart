import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hand_cricket/presentation/providers/game_provider.dart';
import 'package:provider/provider.dart';

const mapNumberButtonAssetsToIndex = {
  1: 'assets/one.png',
  2: 'assets/two.png',
  3: 'assets/three.png',
  4: 'assets/four.png',
  5: 'assets/five.png',
  6: 'assets/six.png',
};

// 1-6 number pad with scaling animation
class NumberPad extends StatefulWidget {
  const NumberPad({super.key});

  @override
  State<NumberPad> createState() => _NumberPadState();
}

class _NumberPadState extends State<NumberPad> {
  // save which button is pressed in the list
  final List<bool> _isButtonPressedList = List.generate(6, (index) => false);

  void _handleTap(int index) {
    setState(() {
      _isButtonPressedList[index] = true;
    });

    context.read<GameProvider>().playerChooses(index + 1);

    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        _isButtonPressedList[index] = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24).r,
      child: GridView.count(
        crossAxisCount: 3,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        crossAxisSpacing: 40.w,
        children: List.generate(6, (index) {
          return Center(
            child: GestureDetector(
              onTap: () => _handleTap(index),
              child: AnimatedScale(
                scale: _isButtonPressedList[index] ? 0.8 : 1.0,
                duration: const Duration(milliseconds: 100),
                child: Image.asset(
                  mapNumberButtonAssetsToIndex[index + 1]!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
