import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hand_cricket/core/app_theme.dart';

// to show six, out, to defend statuses
void playerHighlightsDialog(
  BuildContext context,
  String assetImage, {
  String? supportingText,
}) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        Future.delayed(Duration(seconds: 1), () {
          if (context.mounted) Navigator.of(context).pop();
        });
        return Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Center(child: Image.asset(assetImage)),
              if (supportingText != null)
                Padding(
                  padding: EdgeInsets.only(top: 18).r,
                  child: ShaderMask(
                    shaderCallback:
                        (bounds) => AppTheme.blueGradient.createShader(bounds),
                    child: Text(
                      supportingText,
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(fontSize: 54.sp),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  });
}
