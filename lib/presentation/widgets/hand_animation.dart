import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hand_cricket/core/app_theme.dart';
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

    Future.delayed(const Duration(milliseconds: 800), () {
      _resetPlayerHandAnimation();
    });
  }

  void _resetPlayerHandAnimation() {
    playerHandSmiNumber?.value = 0.0;
    botHandSmiNumber?.value = 0.0;
  }

  @override
  Widget build(BuildContext context) {
    final player = context.select(
      (GameProvider provider) => provider.state.player,
    );
    final bot = context.select((GameProvider provider) => provider.state.bot);
    _triggerPlayerHandAnimation(player.currentChoice, bot.currentChoice);

    return Container(
      width: 380.w,
      height: 200.h,
      decoration: BoxDecoration(
        color: Colors.black.withAlpha(100),
        border: Border.all(color: AppTheme.primaryGold, width: 2.w),
        borderRadius: BorderRadius.circular(10).r,
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
    return RiveAnimation.asset(
      'assets/hand_cricket.riv',
      alignment: Alignment.centerRight,
      fit: BoxFit.cover,
      onInit: (artboard) {
        onInit(artboard);
      },
    );
  }
}
