import 'package:flutter/material.dart';

class LanguageModel {
  static final List<Language> languages = [
    Language(1, 'Türkçe', const Locale('tr', 'TR')),
    Language(2, 'English', const Locale('en', 'US'))
  ];
}

@immutable
class Language {
  final int id;
  final String name;
  final Locale locale;

  Language(this.id, this.name, this.locale);

  @override
  int get hashCode => id;

  @override
  bool operator ==(Object other) => other is Language && other.id == id;
}
