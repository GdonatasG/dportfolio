import 'package:dportfolio/appData/app_data_export.dart';
import 'package:dportfolio/data/model/Message.dart';
import 'package:dportfolio/data/repository/greeting_data_repository_impl.dart';
import 'package:dportfolio/pages/main_page.dart';
import 'package:dportfolio/utils/constants.dart';
import 'package:dportfolio/utils/extensions.dart';
import 'package:dportfolio/utils/themes/app_colors.dart';
import 'package:dportfolio/utils/themes/app_theme_dark.dart';
import 'package:dportfolio/utils/themes/greeting_page_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:preferences/preferences.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/greeting_data/greeting_data_bloc_export.dart';
import 'utils/locale_keys.g.dart';
import 'utils/themes/app_custom_widgets.dart';
import 'utils/themes/app_theme_light.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PrefService.init(prefix: 'pref_');

  //PrefService.setDefaultValues({'user_description': 'This is my description!'});
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: AppColors.greetingBackground));
  runApp(Application());
}

class Application extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _ApplicationState createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  GreetingDataBloc _greetingDataBloc;
  final GreetingDataRepositoryImpl greetingDataRepositoryImpl =
      GreetingDataRepositoryImpl();

  @override
  void initState() {
    _greetingDataBloc = GreetingDataBloc(
        greetingDataRepositoryImpl: greetingDataRepositoryImpl);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (ctx, orientation) {
        return AppDataBuilder(
            delegate: AppLocalizationsDelegate(supportedLocales: [
              Locale(Constants.LANG_EN),
              Locale(Constants.LANG_LT)
            ], locale: getCurrentLocale(context)),
            appTheme: _setStartingTheme(),
            builder: (context, localizationDelegate, theme) {
              return MaterialApp(
                localizationsDelegates:
                    localizationDelegate.localizationDelegates,
                supportedLocales: localizationDelegate.supportedLocales,
                localeResolutionCallback:
                    localizationDelegate.localeResolutionCallback,
                debugShowCheckedModeBanner: false,
                title: Constants.APP_NAME,
                theme: theme,
                home: SafeArea(
                  child: Scaffold(body: _setStartingPage(context)),
                ),
              );
            });
      },
    );
  }

  _setStartingPage(BuildContext context) {
    bool showGreeting =
        PrefService.getBool(Constants.PREFERENCE_SHOW_GREETING) ?? true;
    return showGreeting ? _buildGreetingLayout(context) : MainPage();
  }

  _setStartingTheme() {
    String currentTheme = PrefService.getString(Constants.PREFERENCE_UI_THEME);
    if (currentTheme == null ||
        currentTheme == Constants.PREFERENCES_UI_THEME_LIGHT)
      return appThemeLight;
    else
      return appThemeDark;
  }

  _showErrorLayout(BuildContext context) {
    return Container(
      color: AppColors.greetingBackground,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              context.getString(LocaleKeys.DATA_LOADING_ERROR),
              style: Theme.of(context).textTheme.headline4,
            ),
            SizedBox(
              height: 10,
            ),
            // data reload button
            FlatButton(
              shape: AppCustomWidgets.customLightShapeForFlatButton(),
              textColor: AppColors.lightestGrey,
              onPressed: () {
                _greetingDataBloc.add(GetGreetingMessage());
              },
              child: Text(
                context.getString(LocaleKeys.TRY_AGAIN_TEXT),
                style: greetingTheme.textTheme.headline3,
              ),
            )
          ],
        ),
      ),
    );
  }

  _buildGreetingLayout(BuildContext context) {
    _greetingDataBloc.add(GetGreetingMessage());
    return BlocListener<GreetingDataBloc, GreetingDataState>(
      bloc: _greetingDataBloc,
      listener: (context, state) {
        // listener
      },
      child: BlocBuilder<GreetingDataBloc, GreetingDataState>(
        bloc: _greetingDataBloc,
        builder: (context, state) {
          if (state is GreetingDataLoading)
            return _showLoadingLayout();
          else if (state is GreetingMessageLoaded)
            return _showGreetingLayout(context, state.message);
          else if (state is GreetingDataError)
            return _showErrorLayout(context);
          else
            return Container(
              color: AppColors.greetingBackground,
            );
        },
      ),
    );
  }

  _showGreetingLayout(BuildContext context, Message greetingMessage) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints:
                BoxConstraints(minHeight: viewportConstraints.maxHeight),
            child: Container(
              padding: EdgeInsets.all(15),
              color: AppColors.greetingBackground,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  AppCustomWidgets.logoWidget,
                  Column(children: [
                    _messageLayout(context, greetingMessage),
                    SizedBox(
                      height: 20,
                    ),
                    _actionsLayout(context)
                  ]),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  _showLoadingLayout() {
    return Container(
      color: AppColors.greetingBackground,
      child: Center(
        child: AppCustomWidgets.circularProgressIndicator(
            greetingTheme.indicatorColor),
      ),
    );
  }

  _messageLayout(BuildContext context, Message greetingMessage) {
    return Container(
      margin: EdgeInsets.only(top: 30),
      padding: EdgeInsets.only(top: 5, bottom: 5),
      decoration: BoxDecoration(
          color: Colors.grey[100], borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: Image.asset(
          Constants.SRC_FACE_BLACK,
          width: 50,
          height: 50,
          fit: BoxFit.fill,
        ),
        title: Text(
          greetingMessage.author,
          maxLines: 1,
          style: greetingTheme.textTheme.headline2,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          context.getString(greetingMessage.message),
          style: greetingTheme.textTheme.headline4,
        ),
        trailing: Text(
          context.getString(greetingMessage.time),
          style: greetingTheme.textTheme.headline4.copyWith(fontSize: 12.5),
        ),
      ),
    );
  }

  _actionsLayout(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Column(
        children: [
          // MainPage loading button
          FlatButton(
            shape: AppCustomWidgets.customLightShapeForFlatButton(),
            textColor: AppColors.lightestGrey,
            child: Text(
              context.getString(LocaleKeys.GREETING_DATA_START_READING),
              style: greetingTheme.textTheme.headline3,
            ),
            onPressed: () async {
              _greetingDataBloc.updateGreetingPreference();
              await Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => MainPage()));
            },
          ),
          // layout switcher checkbox
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                context.getString(LocaleKeys.GREETING_DATA_SWITCHER_CHECKBOX),
                style: greetingTheme.textTheme.headline4.copyWith(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                width: 5,
              ),
              _layoutSwitcherCheckbox()
            ],
          )
        ],
      ),
    );
  }

  _layoutSwitcherCheckbox() {
    return StreamBuilder(
      stream: _greetingDataBloc.checkboxStream,
      builder: (BuildContext context, snapshot) {
        return Theme(
          data: ThemeData(unselectedWidgetColor: AppColors.textColorDark),
          child: Checkbox(
            value: snapshot.hasData ? snapshot.data : false,
            activeColor: AppColors.greetingBackground,
            checkColor: AppColors.textColorDark,
            focusColor: AppColors.textColorDark,
            onChanged: (value) {
              _greetingDataBloc.updateCheckboxValue(value);
            },
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _greetingDataBloc.close();
    super.dispose();
  }
}
