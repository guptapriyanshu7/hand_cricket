import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hand_cricket/presentation/providers/game_provider.dart';
import 'package:hand_cricket/presentation/screens/game_screen.dart';
import 'package:hand_cricket/core/get_it.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(480, 940),
      minTextAdapt: true,
      splitScreenMode: true,
      child: ChangeNotifierProvider(
        create: (_) => getIt<GameProvider>(),
        child: MaterialApp(
          title: 'Hand Cricket',
          debugShowCheckedModeBanner: false,
          theme: ThemeData.dark(),
          home: const GameScreen(),
        ),
      ),
    );
  }
}
