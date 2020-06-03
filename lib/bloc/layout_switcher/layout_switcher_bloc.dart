import 'dart:async';

import 'package:rxdart/rxdart.dart';

import 'layout_switcher_bloc_export.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LayoutSwitcherBloc
    extends Bloc<LayoutSwitcherEvent, LayoutSwitcherState> {
  final String SHOW_GREETING = "SHOW_GREETING";

  @override
  LayoutSwitcherState get initialState => GreetingValueLoading();

  // Layout switcher checkbox controller, default value false (not checked)
  final _checkboxController = BehaviorSubject<bool>.seeded(false);

  Stream<bool> get checkboxStream => _checkboxController.stream;

  updateCheckboxValue(bool newValue) {
    _checkboxController.value = newValue;
  }

  @override
  Stream<LayoutSwitcherState> mapEventToState(
      LayoutSwitcherEvent event) async* {
    if (event is GetGreetingValue) {
      yield GreetingValueLoading();
      try {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        final showGreeting = prefs.getBool(SHOW_GREETING) ?? true;
        await Future.delayed(Duration(seconds: 1));
        yield GreetingValueLoaded(showGreeting);
      } catch (_) {
        yield GreetingValueError("Something went wrong. Try again.");
      }
    } else if (event is UpdateGreetingValue) {
      yield GreetingValueLoading();
      try {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        // getting the last checkbox value, negative meaning because of checkbox meanings
        // checked - skip greeting layout
        // unchecked - show greeting layout
        prefs.setBool(SHOW_GREETING, !_checkboxController.value);
        yield GreetingValueUpdated();
      } catch (_) {
        yield GreetingValueError("Something went wrong. Try again.");
      }
    }
  }
}
