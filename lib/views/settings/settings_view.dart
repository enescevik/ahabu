import 'package:ahabu/app/locator.dart';
import 'package:ahabu/views/settings/models/language.dart';
import 'package:ahabu/views/settings/settings_viewmodel.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:theme_mode_handler/theme_mode_handler.dart';

class SettingsView extends StatelessWidget {
  final _navigationService = locator<NavigationService>();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SettingsViewModel>.reactive(
      viewModelBuilder: () => SettingsViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepOrangeAccent,
          title: Text('settings.title'.tr()),
        ),
        body: SafeArea(
          child: SettingsList(
            sections: [
              SettingsSection(
                title: 'settings.display.title'.tr(),
                tiles: [
                  SettingsTile(
                    title: 'settings.display.theme_mode'.tr(),
                    subtitle: 'settings.display.${model.themeMode}'.tr(),
                    leading: Icon(Icons.settings_display),
                    onTap: () => _navigationService
                        .navigateToView(_ThemeModeView())
                        .then((_) => model.notifyListeners()),
                  ),
                ],
              ),
              SettingsSection(
                title: 'settings.common.title'.tr(),
                tiles: [
                  SettingsTile(
                    title: 'settings.common.language'.tr(),
                    subtitle: model.language?.name,
                    leading: Icon(Icons.language),
                    onTap: () => _navigationService
                        .navigateToView(_LanguagesView())
                        .then((_) => model.notifyListeners()),
                  ),
                  SettingsTile.switchTile(
                    title: 'settings.common.showScore'.tr(),
                    leading: Icon(Icons.score),
                    switchValue: model.showScore,
                    onToggle: (value) => model.showScore = value,
                  ),
                ],
              ),
              CustomSection(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 22.0, bottom: 8.0),
                      child:
                          Image.asset('assets/images/logo.png', width: 110.0),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 22.0),
                      child: Text(
                        'version'.tr(args: [model.version]),
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Color(0xFF777777)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LanguagesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SettingsViewModel>.reactive(
      viewModelBuilder: () => SettingsViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepOrangeAccent,
          title: Text('settings.common.language'.tr()),
        ),
        body: SettingsSection(
          tiles: LanguageModel.languages.map((language) {
            return SettingsTile(
              title: language.name,
              trailing:
                  model.language == language ? Icon(Icons.check) : Icon(null),
              onTap: () {
                model.language = language;
                context.locale = language.locale;
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}

class _ThemeModeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SettingsViewModel>.reactive(
      viewModelBuilder: () => SettingsViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(title: Text('settings.display.theme_mode'.tr())),
        body: SettingsSection(
          tiles: ThemeMode.values.map((themeMode) {
            final mode = '$themeMode'.split('.').last;

            return SettingsTile(
              title: 'settings.display.$mode'.tr(),
              trailing:
                  model.themeMode == mode ? Icon(Icons.check) : Icon(null),
              onTap: () {
                model.themeMode = mode;
                ThemeModeHandler.of(context).saveThemeMode(themeMode);
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}
