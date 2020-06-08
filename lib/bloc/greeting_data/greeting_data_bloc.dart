import 'dart:async';

import 'package:dportfolio/bloc/greeting_data/greeting_data_bloc_export.dart';
import 'package:dportfolio/data/repository/greeting_data_repository_impl.dart';
import 'package:dportfolio/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:preferences/preference_service.dart';
import 'package:rxdart/rxdart.dart';

class GreetingDataBloc extends Bloc<GreetingDataEvent, GreetingDataState> {
  final GreetingDataRepositoryImpl greetingDataRepositoryImpl;

  GreetingDataBloc({@required this.greetingDataRepositoryImpl});

  // Layout switcher checkbox controller, default value false (not checked)
  final _checkboxController = BehaviorSubject<bool>.seeded(false);

  Stream<bool> get checkboxStream => _checkboxController.stream;

  updateCheckboxValue(bool newValue) {
    _checkboxController.value = newValue;
  }

  updateGreetingPreference() {
    // negative value meaning because of checkbox meanings
    // checked - skip greeting layout
    // unchecked - show greeting layout
    PrefService.setBool(
        Constants.PREFERENCE_SHOW_GREETING, !_checkboxController.value);
  }

  @override
  GreetingDataState get initialState => GreetingDataLoading();

  @override
  Stream<GreetingDataState> mapEventToState(GreetingDataEvent event) async* {
    if (event is GetGreetingMessage) {
      yield GreetingDataLoading();
      try {
        final greetingMessage =
            await greetingDataRepositoryImpl.getGreetingMessage();
        yield GreetingMessageLoaded(greetingMessage);
      } catch (_) {
        yield GreetingDataError("Can't get greeting message!");
      }
    }
  }
}
