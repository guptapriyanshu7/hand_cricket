
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hand_cricket/core/app_theme.dart';

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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20).r,
      child: Container(
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
                    (bounds) =>
                        AppTheme.goldRadialGradient.createShader(bounds),
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
      ),
    );
  }
}
