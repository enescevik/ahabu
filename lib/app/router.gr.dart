// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../views/home_view.dart';
import '../views/numbers/numbers_view.dart';
import '../views/settings/settings_view.dart';
import '../views/toys/toys_view.dart';
import '../views/words/words_view.dart';

class Routes {
  static const String homeView = '/';
  static const String wordsView = '/words-view';
  static const String numbersView = '/numbers-view';
  static const String toysView = '/toys-view';
  static const String settingsView = '/settings-view';
  static const all = <String>{
    homeView,
    wordsView,
    numbersView,
    toysView,
    settingsView,
  };
}

class Router extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.homeView, page: HomeView),
    RouteDef(Routes.wordsView, page: WordsView),
    RouteDef(Routes.numbersView, page: NumbersView),
    RouteDef(Routes.toysView, page: ToysView),
    RouteDef(Routes.settingsView, page: SettingsView),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    HomeView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const HomeView(),
        settings: data,
      );
    },
    WordsView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const WordsView(),
        settings: data,
      );
    },
    NumbersView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const NumbersView(),
        settings: data,
      );
    },
    ToysView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const ToysView(),
        settings: data,
      );
    },
    SettingsView: (data) {
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) => SettingsView(),
        settings: data,
        transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
      );
    },
  };
}
