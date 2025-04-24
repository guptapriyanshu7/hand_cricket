import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hand_cricket/presentation/providers/game_provider.dart';
import 'package:provider/provider.dart';

// show final result of the game
void gameOverviewDialog(
  BuildContext context, {
  required Widget resultWidget,
  String? supportingText,
}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.transparent.withValues(alpha: 0.8),
        insetPadding: EdgeInsets.all(0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        elevation: 0,
        child: SizedBox.expand(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 0.2.sh),
                resultWidget,
                if (supportingText != null)
                  Text(
                    supportingText,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(fontSize: 24.sp),
                  ),
                SizedBox(height: 30.h),
                TextButton(
                  onPressed: () {
                    context.read<GameProvider>().reset();
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Play Again',
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(fontSize: 24.sp),
                  ),
                ),
                SizedBox(height: 30.h),
              ],
            ),
          ),
        ),
      );
    },
  );
}
