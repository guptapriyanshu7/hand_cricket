import 'package:flutter/material.dart';
import 'package:hand_cricket/core/rive_utils.dart';
import 'package:hand_cricket/presentation/providers/game_provider.dart';
import 'package:provider/provider.dart';
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
  SMINumber? playerHandSmiNumber;
  SMINumber? botHandSmiNumber;
  static const handStateMachineName = 'State Machine 1';
  static const handInputName = 'Input';

  @override
  void dispose() {
    _playerHandController?.dispose();
    _botHandController?.dispose();
    super.dispose();
  }

  void _triggerPlayerHandAnimation(int playerChoice, int botChoice) {
    playerHandSmiNumber?.value = playerChoice * 1.0;
    botHandSmiNumber?.value = botChoice * 1.0;
  }

  void _resetPlayerHandAnimation() {
    playerHandSmiNumber?.value = 0.0;
    botHandSmiNumber?.value = 0.0;
  }

  @override
  Widget build(BuildContext context) {
    final triggerAnimation = context.select(
      (GameProvider provider) => provider.triggerAnimation,
    );
    final playerChoice = context.select(
      (GameProvider provider) => provider.state.player.currentChoice,
    );
    final botChoice = context.select(
      (GameProvider provider) => provider.state.bot.currentChoice,
    );
    if (triggerAnimation) {
      _triggerPlayerHandAnimation(playerChoice, botChoice);
    } else {
      _resetPlayerHandAnimation();
    }
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
              child: _HandRiveAnimationWidget(
                onInit: (artboard) {
                  _playerHandController = RiveUtils.getControllerForAnimation(
                    artboard,
                    stateMachineName: handStateMachineName,
                  );
                  if (_playerHandController == null) return;
                  playerHandSmiNumber = RiveUtils.getNumberInput(
                    _playerHandController!,
                    handInputName,
                  );
                },
              ),
            ),
          ),
          Expanded(
            child: _HandRiveAnimationWidget(
              onInit: (artboard) {
                _botHandController = RiveUtils.getControllerForAnimation(
                  artboard,
                  stateMachineName: handStateMachineName,
                );
                if (_botHandController == null) return;
                botHandSmiNumber = RiveUtils.getNumberInput(
                  _botHandController!,
                  handInputName,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _HandRiveAnimationWidget extends StatelessWidget {
  final void Function(Artboard) onInit;

  const _HandRiveAnimationWidget({required this.onInit});

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 1.2,
      alignment: Alignment.centerRight,
      child: RiveAnimation.asset(
        'assets/hand_cricket.riv',
        alignment: Alignment.centerRight,
        fit: BoxFit.cover,
        onInit: (artboard) {
          onInit(artboard);
        },
      ),
    );
  }
}
