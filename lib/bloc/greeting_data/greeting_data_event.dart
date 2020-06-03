abstract class GreetingDataEvent {
  const GreetingDataEvent();
}

class GetGreetingMessage extends GreetingDataEvent {
  const GetGreetingMessage();

  List<Object> get props => [];
}
