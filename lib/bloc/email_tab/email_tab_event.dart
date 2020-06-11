import 'package:flutter_email_sender/flutter_email_sender.dart';

abstract class EmailTabEvent {
  const EmailTabEvent();
}

class SendEmail extends EmailTabEvent {
  final Email email;

  const SendEmail(this.email);

  List<Object> get props => [email];
}
