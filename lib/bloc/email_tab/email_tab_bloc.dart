import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'email_tab_bloc_export.dart';

class EmailTabBloc extends Bloc<EmailTabEvent, EmailTabState> {
  @override
  EmailTabState get initialState => EmailInitial();

  // Controlling progress indicator
  // false - indicator is hidden
  // true - email sending is in process, indicator is visible
  final _progressIndicatorController = BehaviorSubject<bool>.seeded(false);

  Stream<bool> get progressIndicatorStream =>
      _progressIndicatorController.stream;

  _updateIndicator({bool shouldShow}) {
    _progressIndicatorController.value = shouldShow;
  }

  @override
  Stream<EmailTabState> mapEventToState(EmailTabEvent event) async* {
    if (event is SendEmail) {
      _updateIndicator(shouldShow: true);
      try {
        await FlutterEmailSender.send(event.email);
        yield EmailSent();
      } catch (error) {
        yield EmailSendingError(error.toString());
      }
      _updateIndicator(shouldShow: false);
    }
  }
}
