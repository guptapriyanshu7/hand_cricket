import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hand_cricket/core/app_theme.dart';
import 'package:hand_cricket/presentation/screens/game_screen.dart';

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
              padding: EdgeInsets.all(20.r),
              child: Column(
                children: [
                  SizedBox(height: 80.h),
                  ShaderMask(
                    shaderCallback:
                        (bounds) =>
                            AppTheme.goldRadialGradient.createShader(bounds),
                    child: Text(
                      'How to play',
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium!.copyWith(fontSize: 54.sp),
                    ),
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
                            ).textTheme.bodyMedium!.copyWith(fontSize: 20.sp),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        _buildNumberButton(context, '3', highlighted: true),
                        SizedBox(width: 5.w),
                        _buildNumberButton(context, '2'),
                        SizedBox(width: 5.w),
                        _buildNumberButton(context, '1'),
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
                                        fontSize: 20.sp,
                                      ),
                                    ),
                                  ],
                                ),
                                style: Theme.of(context).textTheme.bodyMedium!
                                    .copyWith(fontSize: 20.sp),
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
                        SizedBox(width: 15.w),
                        Container(
                          width: 2.w,
                          height: 100.h,
                          color: Colors.white.withValues(alpha: 0.5),
                        ),
                        SizedBox(width: 15.w), // Spacer between columns
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
                                        fontSize: 20.sp,
                                      ),
                                    ),
                                  ],
                                ),
                                style: Theme.of(context).textTheme.bodyMedium!
                                    .copyWith(fontSize: 20.sp),
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
                            ).textTheme.bodyMedium!.copyWith(fontSize: 20.sp),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        SizedBox(
                          width: 120.w,
                          height: 100.h,
                          child: Image.asset('assets/you_won.png'),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 60.h),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const GameScreen(),
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

  Widget _buildNumberButton(
    BuildContext context,
    String text, {
    bool highlighted = false,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors:
              highlighted
                  ? [AppTheme.secondaryGold, AppTheme.primaryGold]
                  : [Colors.white, const Color(0xFF98D0EC)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: Theme.of(
          context,
        ).textTheme.bodyMedium!.copyWith(fontSize: 18.sp, color: Colors.black),
      ),
    );
  }
}

class InstructionCard extends StatelessWidget {
  const InstructionCard({
    super.key,
    required this.number,
    required this.content,
    this.giveBottomPadding = true,
  });

  final String number;
  final Widget content;
  final bool giveBottomPadding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(18, 18, 18, giveBottomPadding ? 18 : 0).r,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 15.r,
            backgroundColor: Colors.red,
            child: ShaderMask(
              shaderCallback:
                  (bounds) => AppTheme.goldRadialGradient.createShader(bounds),
              child: Text(
                number,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium!.copyWith(fontSize: 20.sp),
              ),
            ),
          ),
          SizedBox(width: 15.w),
          Expanded(child: content),
        ],
      ),
    );
  }
}
