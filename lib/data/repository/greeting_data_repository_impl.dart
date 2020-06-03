import 'package:dportfolio/utils/locale_keys.g.dart';

import '../model/Message.dart';
import 'greeting_data_repository.dart';

class GreetingDataRepositoryImpl implements GreetingDataRepository {
  Message _greetingMessage = new Message(
      author: "Donatas",
      message: LocaleKeys.GREETING_DATA_MESSAGE,
      time: LocaleKeys.GREETING_DATA_MESSAGE_TIME);

  @override
  Future<Message> getGreetingMessage() {
    return Future.value(_greetingMessage);
  }
}
