import 'package:dportfolio/data/model/Message.dart';

abstract class GreetingDataState {
  const GreetingDataState();
}

class GreetingDataLoading extends GreetingDataState {
  const GreetingDataLoading();

  List<Object> get props => [];
}

class GreetingMessageLoaded extends GreetingDataState {
  final Message message;
  const GreetingMessageLoaded(this.message);

  List<Object> get props => [message];
}

class GreetingDataError extends GreetingDataState {
  final String error;
  const GreetingDataError(this.error);

  List<Object> get props => [error];
}
