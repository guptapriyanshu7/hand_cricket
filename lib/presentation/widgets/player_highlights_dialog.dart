import 'package:flutter/material.dart';

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
        Future.delayed(Duration(seconds: 2), () {
          if (context.mounted) Navigator.of(context).pop();
        });
        return Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(assetImage),
              if (supportingText != null)
                Padding(
                  padding: EdgeInsets.only(top: 18),
                  child: ShaderMask(
                    shaderCallback:
                        (bounds) => LinearGradient(
                          colors: [
                            const Color.fromARGB(255, 70, 192, 252),
                            Colors.white,
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ).createShader(bounds),
                    child: Text(
                      supportingText,
                      style: TextStyle(
                        fontSize: 54,
                        fontWeight: FontWeight.bold,
                      ),
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
