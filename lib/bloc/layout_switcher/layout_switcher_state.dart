abstract class LayoutSwitcherState {
  const LayoutSwitcherState();
}

class GreetingValueLoading extends LayoutSwitcherState {
  const GreetingValueLoading();

  List<Object> get props => [];
}

class GreetingValueLoaded extends LayoutSwitcherState {
  final bool showGreeting;
  const GreetingValueLoaded(this.showGreeting);

  List<Object> get props => [showGreeting];
}

class GreetingValueUpdated extends LayoutSwitcherState {
  const GreetingValueUpdated();

  List<Object> get props => [];
}

class GreetingValueError extends LayoutSwitcherState {
  final String error;
  const GreetingValueError(this.error);

  List<Object> get props => [error];
}
