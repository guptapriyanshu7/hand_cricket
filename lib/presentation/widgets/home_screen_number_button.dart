import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hand_cricket/core/app_theme.dart';

class HomeScreenNumberButton extends StatelessWidget {
  final int number;
  final bool isHighlighted;

  const HomeScreenNumberButton(
    this.number, {
    this.isHighlighted = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors:
              isHighlighted
                  ? [AppTheme.secondaryGold, AppTheme.primaryGold]
                  : [Colors.white, const Color(0xFF98D0EC)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        number.toString(),
        style: Theme.of(
          context,
        ).textTheme.bodyMedium!.copyWith(fontSize: 18.sp, color: Colors.black),
      ),
    );
  }
}
