import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hand_cricket/core/app_theme.dart';
import 'package:hand_cricket/presentation/providers/game_provider.dart';
import 'package:provider/provider.dart';

// this widget displays a countdown timer with a circular progress indicator and a message below it.
class CountdownTimer extends StatelessWidget {
  const CountdownTimer({super.key});

  @override
  Widget build(BuildContext context) {
    final remainingTime = context.select(
      (GameProvider provider) => provider.remainingTime,
    );
    return Column(
      children: [
        SizedBox(
          width: 80.w,
          height: 80.w,
          child: Stack(
            fit: StackFit.expand,
            children: [
              CircularProgressIndicator(
                value: remainingTime / GameProvider.timeLimit,
                backgroundColor: Colors.black,
                valueColor: const AlwaysStoppedAnimation<Color>(
                  AppTheme.lightCrimson,
                ),
                strokeWidth: 5.w,
              ),
              Center(
                child: Text(
                  remainingTime.toString(),
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(fontSize: 40.sp),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10.h),
        Text(
          'Pick a number before timer runs out',
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(fontSize: 18.sp),
        ),
      ],
    );
  }
}
