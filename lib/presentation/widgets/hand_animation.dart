import 'package:flutter/material.dart';
import 'package:hand_cricket/core/rive_utils.dart';
import 'package:rive/rive.dart';

class HandAnimation extends StatefulWidget {
  const HandAnimation({super.key});

  @override
  State<HandAnimation> createState() => _HandAnimationState();
}

class _HandAnimationState extends State<HandAnimation> {
  late RiveAnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = SimpleAnimation('idle');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _triggerAnimation() {
    if (_controller is StateMachineController) {
      final smc = _controller as StateMachineController;
      final smiNumberInput = RiveUtils.getNumberInput(smc, 'Input');
      smiNumberInput?.value = 3;
    }
  }

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
      child: SizedBox(
        width: 150,
        height: 150,
        child: RiveAnimation.asset(
          'assets/hand_cricket.riv',
          controllers: [_controller],
          onInit: (artboard) {
            _controller = RiveUtils.getControllerForAnimation(
              artboard,
              stateMachineName: 'State Machine 1',
            );
            // if (widget.number > 0) {
            // _triggerAnimation();
            // }
          },
        ),
      ),
    );
  }
}
