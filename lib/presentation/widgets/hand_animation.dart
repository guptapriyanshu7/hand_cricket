import 'package:flutter/material.dart';
import 'package:hand_cricket/core/rive_utils.dart';
import 'package:rive/rive.dart';
import 'dart:math';

class HandAnimation extends StatefulWidget {
  const HandAnimation({super.key});

  @override
  State<HandAnimation> createState() => _HandAnimationState();
}

class _HandAnimationState extends State<HandAnimation> {
  StateMachineController? _playerHandController;
  StateMachineController? _botHandController;

  @override
  void dispose() {
    _playerHandController?.dispose();
    _botHandController?.dispose();
    super.dispose();
  }

  void _triggerPlayerHandAnimation() {
    if (_playerHandController == null) return;
    final smiNumberInput = RiveUtils.getNumberInput(
      _playerHandController!,
      'Input',
    );
    smiNumberInput?.value = 3;
  }

  void _triggerBotHandAnimation() {
    if (_botHandController == null) return;
    final smiNumberInput = RiveUtils.getNumberInput(
      _botHandController!,
      'Input',
    );
    smiNumberInput?.value = 3;
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
      child: Row(
        children: [
          Expanded(
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(pi),
              child: RiveAnimation.asset(
                'assets/hand_cricket.riv',
                alignment: Alignment.centerRight,
                onInit: (artboard) {
                  _playerHandController = RiveUtils.getControllerForAnimation(
                    artboard,
                    stateMachineName: 'State Machine 1',
                  );
                },
              ),
            ),
          ),
          Expanded(
            child: RiveAnimation.asset(
              'assets/hand_cricket.riv',
              alignment: Alignment.centerRight,
              onInit: (artboard) {
                _botHandController = RiveUtils.getControllerForAnimation(
                  artboard,
                  stateMachineName: 'State Machine 1',
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
