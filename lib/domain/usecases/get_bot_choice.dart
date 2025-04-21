// use cases examples, userlogin, placeorder, similarly getbotchoice

import 'package:hand_cricket/domain/repositories/game_repository.dart';

// upto the repository how to get the bots choice
class GetBotChoice {
  final GameRepository repository;

  GetBotChoice(this.repository);

  Future<int> call() async {
    return await repository.getBotChoice();
  }
}
