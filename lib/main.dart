import 'dart:developer';

import 'package:dportfolio/data/model/Message.dart';
import 'package:dportfolio/data/repository/greeting_data_repository_impl.dart';
import 'package:dportfolio/pages/main_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/greeting_data/greeting_data_bloc_export.dart';
import 'bloc/layout_switcher/layout_switcher_bloc_export.dart';
import 'utils/locale_keys.g.dart';
import 'utils/theme.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: AppColors.greetingBackground));
  runApp(EasyLocalization(
      supportedLocales: [Locale('en', 'US'), Locale('lt', 'LT')],
      path: "assets/locale",
      preloaderColor: AppColors.greetingBackground,
      //preloaderWidget: CustomPreloaderWidget(),
      child: Application()));
}

class Application extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _ApplicationState createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  LayoutSwitcherBloc _layoutSwitcherBloc;
  GreetingDataBloc _greetingDataBloc;
  final GreetingDataRepositoryImpl greetingDataRepositoryImpl =
      GreetingDataRepositoryImpl();

  @override
  void initState() {
    _layoutSwitcherBloc = LayoutSwitcherBloc();
    _layoutSwitcherBloc.add(GetGreetingValue());
    _greetingDataBloc = GreetingDataBloc(
        greetingDataRepositoryImpl: greetingDataRepositoryImpl);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: appTheme,
      home: SafeArea(
        child: Scaffold(
          body: BlocListener<LayoutSwitcherBloc, LayoutSwitcherState>(
            bloc: _layoutSwitcherBloc,
            listener: (context, state) {
              // listener
            },
            child: BlocBuilder<LayoutSwitcherBloc, LayoutSwitcherState>(
              bloc: _layoutSwitcherBloc,
              builder: (context, state) {
                if (state is GreetingValueLoading)
                  return AppCustomWidgets.loadingWidgetGreetingColor;
                else if (state is GreetingValueLoaded) {
                  return state.showGreeting
                      ? _buildGreetingLayout(context)
                      : MainPage();
                } else if (state is GreetingValueUpdated) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => MainPage()));
                  });
                  return Container();
                } else if (state is GreetingValueError) {
                  return _showErrorLayout(context);
                } else
                  return Container(
                    color: AppColors.greetingBackground,
                  );
              },
            ),
          ),
        ),
      ),
    );
  }

  _showErrorLayout(BuildContext context) {
    return Container(
      color: AppColors.greetingBackground,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppCustomWidgets.logoWidget,
            SizedBox(
              height: 15,
            ),
            Text(
              LocaleKeys.DATA_LOADING_ERROR.tr(),
              style: Theme.of(context).textTheme.headline4,
            ),
            SizedBox(
              height: 10,
            ),
            FlatButton(
              shape: AppCustomWidgets.customShapeForFlatButton(),
              textColor: AppColors.primary,
              onPressed: () {
                _layoutSwitcherBloc.add(GetGreetingValue());
              },
              child: Text(
                LocaleKeys.TRY_AGAIN_TEXT.tr(),
                style: Theme.of(context).textTheme.headline3,
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
            return AppCustomWidgets.loadingWidgetGreetingColor;
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
                    _msgLayout(context, greetingMessage),
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

  _msgLayout(BuildContext context, Message greetingMessage) {
    return Container(
      margin: EdgeInsets.only(top: 30),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.grey[100], borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 6,
            child: Row(
              children: [
                Image.asset(
                  "assets/images/face.png",
                  width: 50,
                  height: 50,
                  fit: BoxFit.fill,
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        greetingMessage.author,
                        maxLines: 1,
                        style: Theme.of(context).textTheme.headline2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 5.0),
                      Text(
                        greetingMessage.message.tr(),
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.headline4,
                        maxLines: 6,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    alignment: Alignment.topRight,
                    child: Text(
                      greetingMessage.time.tr(),
                      style: Theme.of(context)
                          .textTheme
                          .headline4
                          .copyWith(fontSize: 12.5),
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }

  _actionsLayout(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Column(
        children: [
          FlatButton(
            shape: AppCustomWidgets.customShapeForFlatButton(),
            textColor: AppColors.primary,
            child: Text(
              LocaleKeys.GREETING_DATA_START_READING.tr(),
              style: Theme.of(context).textTheme.headline3,
            ),
            onPressed: () {
              _layoutSwitcherBloc.add(UpdateGreetingValue());
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                LocaleKeys.GREETING_DATA_SWITCHER_CHECKBOX.tr(),
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    .copyWith(fontSize: 16),
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
      stream: _layoutSwitcherBloc.checkboxStream,
      builder: (BuildContext context, snapshot) {
        return Checkbox(
          value: snapshot.hasData ? snapshot.data : false,
          activeColor: AppColors.greetingBackground,
          checkColor: AppColors.textColorDark,
          onChanged: (value) {
            _layoutSwitcherBloc.updateCheckboxValue(value);
          },
        );
      },
    );
  }

  @override
  void dispose() {
    _layoutSwitcherBloc.close();
    _greetingDataBloc.close();
    super.dispose();
  }
}

class CustomPreloaderWidget extends StatelessWidget {
  const CustomPreloaderWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppCustomWidgets.loadingWidgetGreetingColor;
  }
}
