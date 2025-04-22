import 'package:flutter/material.dart';
import 'package:hand_cricket/data/datasources/local/game_local_data_source.dart';
import 'package:hand_cricket/data/repositories/game_repository_impl.dart';
import 'package:hand_cricket/domain/repositories/game_repository.dart';
import 'package:hand_cricket/domain/usecases/evaluate_outcome.dart';
import 'package:hand_cricket/domain/usecases/get_bot_choice.dart';
import 'package:hand_cricket/domain/usecases/reset_game.dart';
import 'package:hand_cricket/presentation/providers/game_provider.dart';
import 'package:hand_cricket/presentation/screens/game_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<GameLocalDataSource>(create: (_) => GameLocalDataSourceImpl()),
        Provider<GameRepository>(
          create:
              (context) => GameRepositoryImpl(
                localDataSource: context.read<GameLocalDataSource>(),
              ),
        ),
        ChangeNotifierProvider<GameProvider>(
          create:
              (context) => GameProvider(
                getBotChoice: GetBotChoice(context.read<GameRepository>()),
                evaluateOutcome: EvaluateOutcome(
                  context.read<GameRepository>(),
                ),
                resetGame: ResetGame(context.read<GameRepository>()),
              ),
        ),
      ],
      child: MaterialApp(
        title: 'Hand Cricket',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const GameScreen(),
      ),
    );
  }
}
