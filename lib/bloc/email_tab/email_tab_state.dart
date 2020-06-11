abstract class EmailTabState {
  const EmailTabState();
}

class EmailInitial extends EmailTabState {
  const EmailInitial();

  List<Object> get props => [];
}

class EmailSent extends EmailTabState {
  const EmailSent();

  List<Object> get props => [];
}

class EmailSendingError extends EmailTabState {
  final String error;
  const EmailSendingError(this.error);

  List<Object> get props => [error];
}
