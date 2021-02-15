import 'package:ahabu/views/home_view.dart';
import 'package:ahabu/views/numbers/numbers_view.dart';
import 'package:ahabu/views/settings/settings_view.dart';
import 'package:ahabu/views/toys/toys_view.dart';
import 'package:ahabu/views/words/words_view.dart';
import 'package:auto_route/auto_route.dart';
import 'package:auto_route/auto_route_annotations.dart';

@MaterialAutoRouter(routes: [
  MaterialRoute(page: HomeView, initial: true),
  MaterialRoute(page: WordsView),
  MaterialRoute(page: NumbersView),
  MaterialRoute(page: ToysView),
  CustomRoute(
    page: SettingsView,
    transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
  ),
])
class $Router {}
