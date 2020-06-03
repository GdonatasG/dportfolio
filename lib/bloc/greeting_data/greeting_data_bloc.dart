import 'dart:async';

import 'package:dportfolio/bloc/greeting_data/greeting_data_bloc_export.dart';
import 'package:dportfolio/data/repository/greeting_data_repository_impl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GreetingDataBloc extends Bloc<GreetingDataEvent, GreetingDataState> {
  final GreetingDataRepositoryImpl greetingDataRepositoryImpl;

  GreetingDataBloc({@required this.greetingDataRepositoryImpl});

  @override
  GreetingDataState get initialState => GreetingDataLoading();

  @override
  Stream<GreetingDataState> mapEventToState(GreetingDataEvent event) async* {
    if (event is GetGreetingMessage) {
      yield GreetingDataLoading();
      try {
        final greetingMessage =
            await greetingDataRepositoryImpl.getGreetingMessage();
        await Future.delayed(Duration(seconds: 1));
        yield GreetingMessageLoaded(greetingMessage);
      } catch (_) {
        yield GreetingDataError("Can't get greeting message!");
      }
    }
  }
}
