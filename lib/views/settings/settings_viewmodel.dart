import 'package:ahabu/app/locator.dart';
import 'package:ahabu/services/shared_preferences_service.dart';
import 'package:ahabu/views/settings/models/language.dart';
import 'package:stacked/stacked.dart';

class SettingsViewModel extends BaseViewModel {
  final _prefrence = locator<SharedPreferencesService>();

  bool get darkModeEnabled => _prefrence.darkModeEnabled;
  set darkModeEnabled(value) {
    _prefrence.darkModeEnabled = value;
    notifyListeners();
  }

  String get themeMode => _prefrence.themeMode == null
      ? 'system'
      : _prefrence.themeMode.split('.').last;
  set themeMode(value) {
    _prefrence.themeMode = value;
    notifyListeners();
  }

  Language get language => _prefrence.language;
  set language(value) {
    _prefrence.language = value;
    notifyListeners();
  }

  bool get showScore => _prefrence.showScore ?? false;
  set showScore(value) {
    _prefrence.showScore = value;
    notifyListeners();
  }

  String get version => _prefrence.version;
}
