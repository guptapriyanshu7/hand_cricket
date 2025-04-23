import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hand_cricket/core/app_theme.dart';

class GameResultWidget extends StatelessWidget {
  final String result;
  const GameResultWidget({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18).r,
      child: Column(
        children: [
          Image.asset('assets/bails.png'),
          SizedBox(height: 20.h),
          ShaderMask(
            shaderCallback:
                (bounds) => AppTheme.lightRedGradient.createShader(bounds),
            child: Text(
              result,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(fontSize: 54.sp),
            ),
          ),
        ],
      ),
    );
  }
}
