import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
                (bounds) => LinearGradient(
                  colors: [
                    const Color.fromARGB(255, 245, 101, 101),
                    Colors.white,
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ).createShader(bounds),
            child: Text(
              result,
              style: TextStyle(
                color: Colors.white,
                fontSize: 54.sp,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
