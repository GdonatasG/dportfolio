import '../model/Message.dart';

abstract class GreetingDataRepository {
  Future<Message> getGreetingMessage();
}
