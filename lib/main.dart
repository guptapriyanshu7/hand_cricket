import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hand_cricket/core/app_theme.dart';
import 'package:hand_cricket/core/get_it.dart';
import 'package:hand_cricket/presentation/screens/home_screen.dart';

Future<void> main() async {
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    // using screenutil to adapt the screen size and text size
    return ScreenUtilInit(
      designSize: Size(480, 940),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        title: 'Hand Cricket',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.theme,
        home: const HomeScreen(),
      ),
    );
  }
}
