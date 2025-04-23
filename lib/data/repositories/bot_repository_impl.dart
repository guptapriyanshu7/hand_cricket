import 'package:hand_cricket/data/datasources/local/game_local_data_source.dart';
import 'package:hand_cricket/domain/repositories/bot_repository.dart';

// implementing the BotRepository interface
class BotRepositoryImpl implements BotRepository {
  final GameLocalDataSource localDataSource;

  BotRepositoryImpl({required this.localDataSource});

  @override
  int getBotChoice()  {
    return localDataSource.getRandomNumber();
  }
}
