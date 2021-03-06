import 'package:dportfolio/bloc/email_tab/email_tab_bloc_export.dart';
import 'package:dportfolio/utils/constants.dart';
import 'package:dportfolio/utils/extensions.dart';
import 'package:dportfolio/utils/locale_keys.g.dart';
import 'package:dportfolio/utils/themes/app_custom_dimensions.dart';
import 'package:dportfolio/utils/themes/app_custom_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:dportfolio/appData/app_data_export.dart';

class EmailPage extends StatefulWidget {
  @override
  _EmailPageState createState() => _EmailPageState();
}

class _EmailPageState extends State<EmailPage>
    with AutomaticKeepAliveClientMixin {
  // bloc
  EmailTabBloc _emailTabBloc;

  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  // input controllers
  final _recipientController = TextEditingController(
    text: Constants.MY_EMAIL,
  );
  final _subjectController = TextEditingController();
  final _bodyController = TextEditingController();

  final _subjectFocus = FocusNode();
  final _bodyFocus = FocusNode();

  @override
  void initState() {
    _emailTabBloc = EmailTabBloc();
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildData(context);
  }

  _buildData(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).backgroundColor,
      body: BlocListener<EmailTabBloc, EmailTabState>(
          bloc: _emailTabBloc,
          listener: (_, state) {
            if (state is EmailSendingError) showErrorSnackbar(_scaffoldKey);
          },
          child: BlocBuilder<EmailTabBloc, EmailTabState>(
            bloc: _emailTabBloc,
            builder: (_, state) {
              if (state is EmailSent) _clearInputs();
              return _buildPage(context);
            },
          )),
    );
  }

  _clearInputs() {
    _subjectController.clear();
    _bodyController.clear();
  }

  _buildPage(BuildContext context) {
    final labelStyle = Theme.of(context)
        .textTheme
        .headline4
        .copyWith(fontSize: 15, fontStyle: FontStyle.italic);
    final inputStyle =
        Theme.of(context).textTheme.headline4.copyWith(fontSize: 14.5);
    return Center(
        child: SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: StreamBuilder(
            stream: _emailTabBloc.progressIndicatorStream,
            builder: (_, snapshot) {
              bool isFormActionsEnabled =
                  snapshot.hasData ? !snapshot.data : true;
              return Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  // RECIPIENT INPUT
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextFormField(
                      enabled: false,
                      style: inputStyle,
                      controller: _recipientController,
                      decoration: InputDecoration(
                          filled: true,
                          labelStyle: labelStyle,
                          labelText:
                              context.getString(LocaleKeys.EMAIL_RECIPIENT)),
                    ),
                  ),
                  // EMAIL SUBJECT INPUT
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextFormField(
                      enabled: isFormActionsEnabled,
                      style: inputStyle,
                      textInputAction: TextInputAction.next,
                      focusNode: _subjectFocus,
                      controller: _subjectController,
                      onFieldSubmitted: (t) =>
                          _fieldFocusChange(context, _subjectFocus, _bodyFocus),
                      validator: (value) {
                        if (value.length < 6)
                          return context
                              .getString(LocaleKeys.ERROR_VALIDATION_SUBJECT);
                        else
                          return null;
                      },
                      decoration: InputDecoration(
                          labelStyle: labelStyle,
                          labelText:
                              context.getString(LocaleKeys.EMAIL_SUBJECT)),
                    ),
                  ),
                  // EMAIL BODY INPUT
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextFormField(
                      enabled: isFormActionsEnabled,
                      style: inputStyle,
                      controller: _bodyController,
                      focusNode: _bodyFocus,
                      validator: (value) {
                        if (value.length < 20)
                          return context
                              .getString(LocaleKeys.ERROR_VALIDATION_MESSAGE);
                        else
                          return null;
                      },
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                          labelStyle: labelStyle,
                          labelText:
                              context.getString(LocaleKeys.EMAIL_MESSAGE)),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  // Circular progress indicator to control
                  Visibility(
                    visible: snapshot.hasData ? snapshot.data : false,
                    child: SizedBox(
                      width: AppCustomDimensions.CIRCULAR_INDICATOR_WIDTH,
                      height: AppCustomDimensions.CIRCULAR_INDICATOR_HEIGHT,
                      child: AppCustomWidgets.circularProgressIndicator(
                          Theme.of(context).indicatorColor),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  FlatButton(
                    onPressed: () {
                      if (_formKey.currentState.validate() &&
                          isFormActionsEnabled) _sendEmail();
                    },
                    child: Text(
                      context.getString(LocaleKeys.SEND),
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    ));
  }

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  _sendEmail() {
    final Email email = Email(
        body: _bodyController.text,
        subject: _subjectController.text,
        recipients: [_recipientController.text]);

    _emailTabBloc.add(SendEmail(email));
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    _emailTabBloc.close();
    _subjectController.dispose();
    _bodyController.dispose();
    super.dispose();
  }
}
