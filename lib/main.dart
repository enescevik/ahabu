import 'package:ahabu/app/app_theme.dart';
import 'package:ahabu/app/locator.dart';
import 'package:ahabu/app/setup_dialog_ui.dart';
import 'package:ahabu/services/shared_preferences_service.dart';
import 'package:ahabu/views/settings/models/language.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization_loader/easy_localization_loader.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:theme_mode_handler/theme_mode_handler.dart';
import 'package:theme_mode_handler/theme_mode_manager_interface.dart';

import 'app/router.gr.dart' as auto_router;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setupLocator();
  setupDialogUi();
  await SharedPreferencesService.init();

  runApp(EasyLocalization(
    child: MainApp(),
    // child: DevicePreview(
    //   enabled: kIsWeb ? false : !kReleaseMode,
    //   builder: (_) => MainApp()
    // ),
    path: 'assets/languages',
    assetLoader: YamlAssetLoader(),
    supportedLocales: LanguageModel.languages.map((e) => e.locale).toList(),
  ));
}

class AppThemeModeManager implements IThemeModeManager {
  final _preference = locator<SharedPreferencesService>();

  @override
  Future<String> loadThemeMode() async {
    return _preference.themeMode;
  }

  @override
  Future<bool> saveThemeMode(String value) async {
    _preference.themeMode = value;
    return true;
  }
}

class MainApp extends StatelessWidget {
  final _initialization = Firebase.initializeApp();
  final _preference = locator<SharedPreferencesService>();

  @override
  Widget build(BuildContext context) {
    context.locale =
        _preference.language?.locale ?? LanguageModel.languages[0].locale;

    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return _AppErrorView();
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return ThemeModeHandler(
            manager: AppThemeModeManager(),
            builder: (themeMode) => MaterialApp(
              title: 'title'.tr(),
              locale: context.locale,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: themeMode,
              debugShowCheckedModeBanner: false,
              supportedLocales: context.supportedLocales,
              localizationsDelegates: context.localizationDelegates,
              initialRoute: auto_router.Routes.homeView,
              navigatorKey: StackedService.navigatorKey,
              onGenerateRoute: auto_router.Router().onGenerateRoute,
              // navigatorObservers: [
              //   locator<AnalyticsService>().getAnalyticsObserver()
              // ],
            ),
          );
        }

        return _AppLoadingView();
      },
    );
  }
}

class _AppErrorView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(visualDensity: VisualDensity.adaptivePlatformDensity),
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.error, size: 100.0, color: Colors.red),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: Text(
                    'general.firebase_init_error'.tr(),
                    style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                      fontSize: 24.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AppLoadingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(20.0),
        alignment: Alignment.center,
        color: Color(0xFFF96302),
        child: Image(image: AssetImage('assets/images/splash.png')),
      ),
    );
  }
}
