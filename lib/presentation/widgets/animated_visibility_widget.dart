import 'package:flutter/material.dart';

class AnimatedVisibilityWidget extends StatefulWidget {
  final String assetImage;
  final String? supportingText;
  const AnimatedVisibilityWidget({
    super.key,
    required this.assetImage,
    this.supportingText,
  });

  @override
  State<AnimatedVisibilityWidget> createState() =>
      _AnimatedVisibilityWidgetState();
}

class _AnimatedVisibilityWidgetState extends State<AnimatedVisibilityWidget> {
  bool _isVisible = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      setState(() => _isVisible = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isVisible
        ? Stack(
          children: [
            AnimatedOpacity(
              opacity: _isVisible ? 1.0 : 0.0,
              duration: Duration(seconds: 2),
              child: Container(
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(color: Colors.black.withValues(alpha: 0.7)),
                  ],
                ),
                child: Image.asset(widget.assetImage),
              ),
            ),
            if (widget.supportingText != null)
              Container(
                padding: EdgeInsets.only(top: 12),
                height: MediaQuery.of(context).size.height,
                child: Center(
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
                      widget.supportingText!,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 54,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
          ],
        )
        : SizedBox.shrink();
  }
}
