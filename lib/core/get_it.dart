import 'package:get_it/get_it.dart';
import 'package:hand_cricket/data/datasources/local/game_local_data_source.dart';
import 'package:hand_cricket/data/repositories/bot_repository_impl.dart';
import 'package:hand_cricket/data/repositories/game_repository_impl.dart';
import 'package:hand_cricket/domain/repositories/bot_repository.dart';
import 'package:hand_cricket/domain/repositories/game_repository.dart';
import 'package:hand_cricket/domain/usecases/evaluate_outcome.dart';
import 'package:hand_cricket/domain/usecases/get_bot_choice.dart';
import 'package:hand_cricket/domain/usecases/reset_game.dart';
import 'package:hand_cricket/presentation/providers/game_provider.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  // Providers
  getIt.registerFactory(
    () => GameProvider(
      getBotChoice: getIt(),
      evaluateOutcome: getIt(),
      resetGame: getIt(),
    ),
  );

  // Use cases
  getIt.registerLazySingleton(() => GetBotChoice(getIt()));
  getIt.registerLazySingleton(() => EvaluateOutcome(getIt()));
  getIt.registerLazySingleton(() => ResetGame(getIt()));

  // Game Repository
  getIt.registerLazySingleton<GameRepository>(() => GameRepositoryImpl());
  // Bot Repository
  getIt.registerLazySingleton<BotRepository>(
    () => BotRepositoryImpl(localDataSource: getIt()),
  );

  // Data sources
  getIt.registerLazySingleton<GameLocalDataSource>(
    () => GameLocalDataSourceImpl(),
  );
}
