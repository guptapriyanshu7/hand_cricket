import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hand_cricket/core/app_theme.dart';
import 'package:hand_cricket/core/get_it.dart';
import 'package:hand_cricket/presentation/providers/game_provider.dart';
import 'package:hand_cricket/presentation/screens/game_screen.dart';
import 'package:hand_cricket/presentation/widgets/home_screen_number_button.dart';
import 'package:hand_cricket/presentation/widgets/instruction_card.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1F1053), const Color(0xFFEE5E53)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: SizedBox.expand(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 80.h),
                  Stack(
                    children: [
                      Row(
                        children: [
                          Opacity(
                            opacity: 0.3,
                            child: Transform(
                              transform: Matrix4.rotationY(pi),
                              alignment: Alignment.center,
                              child: Image.asset(
                                'assets/three_run_finger.png',
                                scale: 4.5,
                              ),
                            ),
                          ),
                          Spacer(),
                          Opacity(
                            opacity: 0.3,
                            child: Image.asset(
                              'assets/one_run_finger.png',
                              scale: 4.4,
                            ),
                          ),
                        ],
                      ),
                      Center(
                        child: ShaderMask(
                          shaderCallback:
                              (bounds) => AppTheme.goldRadialGradient
                                  .createShader(bounds),
                          child: Text(
                            'How to play',
                            style: Theme.of(
                              context,
                            ).textTheme.bodyMedium!.copyWith(fontSize: 54.sp),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 40.h),

                  InstructionCard(
                    number: '1',
                    content: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Tap the buttons\nto score Runs',
                            style: Theme.of(
                              context,
                            ).textTheme.bodyMedium!.copyWith(fontSize: 18.sp),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        HomeScreenNumberButton(3, isHighlighted: true),
                        SizedBox(width: 5.w),
                        HomeScreenNumberButton(2),
                        SizedBox(width: 5.w),
                        HomeScreenNumberButton(1),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),

                  InstructionCard(
                    number: '2',
                    giveBottomPadding: false,
                    content: Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Text.rich(
                                TextSpan(
                                  text: 'Same number:\n',
                                  children: [
                                    TextSpan(
                                      text: 'You\'re out!',
                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodyMedium!.copyWith(
                                        color: const Color(0xFFED7A72),
                                        fontSize: 18.sp,
                                      ),
                                    ),
                                  ],
                                ),
                                style: Theme.of(context).textTheme.bodyMedium!
                                    .copyWith(fontSize: 18.sp),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 10.h),
                              SizedBox(
                                height: 60.h,
                                child: Image.asset('assets/same_fingers.png'),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 4.w),
                        Container(
                          width: 2.w,
                          height: 100.h,
                          color: Colors.white.withValues(alpha: 0.5),
                        ),
                        SizedBox(width: 16.w),
                        Expanded(
                          child: Column(
                            children: [
                              Text.rich(
                                TextSpan(
                                  text: 'Different number:\n',
                                  children: [
                                    TextSpan(
                                      text: 'You score runs',
                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodyMedium!.copyWith(
                                        color: Colors.green,
                                        fontSize: 18.sp,
                                      ),
                                    ),
                                  ],
                                ),
                                style: Theme.of(context).textTheme.bodyMedium!
                                    .copyWith(fontSize: 18.sp),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 10.h),
                              SizedBox(
                                height: 60.h,
                                child: Image.asset(
                                  'assets/different_fingers.png',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  InstructionCard(
                    number: '3',
                    content: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Be the highest scorer\nand win the game',
                            style: Theme.of(
                              context,
                            ).textTheme.bodyMedium!.copyWith(fontSize: 18.sp),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        SizedBox(
                          width: 90.w,
                          height: 95.h,
                          child: Image.asset('assets/you_won.png'),
                        ),
                        SizedBox(width: 10.w),
                      ],
                    ),
                  ),
                  SizedBox(height: 60.h),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => ChangeNotifierProvider(
                                create: (context) => getIt<GameProvider>(),
                                child: const GameScreen(),
                              ),
                        ),
                      );
                    },
                    child: Container(
                      padding:
                          const EdgeInsets.symmetric(
                            horizontal: 80,
                            vertical: 10,
                          ).r,
                      decoration: BoxDecoration(
                        gradient: AppTheme.goldGradient,
                        borderRadius: BorderRadius.circular(12).r,
                      ),
                      child: Text(
                        'Start playing',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 24.sp,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
