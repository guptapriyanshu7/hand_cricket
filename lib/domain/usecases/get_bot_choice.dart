// use cases examples, userlogin, placeorder, similarly getbotchoice
import 'package:hand_cricket/domain/repositories/bot_repository.dart';

// upto the repository how to get the bots choice
class GetBotChoice {
  final BotRepository repository;

  GetBotChoice(this.repository);

  int call() {
    return repository.getBotChoice();
  }
}
