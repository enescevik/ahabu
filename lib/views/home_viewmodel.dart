import 'package:ahabu/app/locator.dart';
import 'package:ahabu/app/router.gr.dart';
import 'package:ahabu/services/shared_preferences_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  final _prefrence = locator<SharedPreferencesService>();
  final _navigationService = locator<NavigationService>();

  String get version => _prefrence.version;

  void settingsScreen() => _navigationService
      .navigateTo(Routes.settingsView)
      .then((m) => notifyListeners());

  void wordsScreen() => _navigationService.navigateTo(Routes.wordsView);
  void numbersScreen() => _navigationService.navigateTo(Routes.numbersView);
  void toysScreen() => _navigationService.navigateTo(Routes.toysView);
}
