abstract class LayoutSwitcherEvent {
  const LayoutSwitcherEvent();
}

class GetGreetingValue extends LayoutSwitcherEvent {
  const GetGreetingValue();

  List<Object> get props => [];
}

class UpdateGreetingValue extends LayoutSwitcherEvent {
  const UpdateGreetingValue();

  List<Object> get props => [];
}
