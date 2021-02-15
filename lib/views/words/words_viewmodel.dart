import 'dart:math';

import 'package:ahabu/app/locator.dart';
import 'package:ahabu/services/shared_preferences_service.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:stacked/stacked.dart';

class WordsViewModel extends BaseViewModel {
  final _prefrence = locator<SharedPreferencesService>();
  final _random = new Random();

  bool get showScore => _prefrence.showScore ?? false;

  List colors = [
    Colors.redAccent,
    Colors.greenAccent,
    Colors.orangeAccent,
    Colors.blueAccent,
    Colors.amberAccent,
    Colors.cyanAccent,
    Colors.pinkAccent,
  ];

  List disabledLetters = [];

  String status = '🤔';

  int correctCount = 0;
  int wrongCount = 0;
  int score() => (correctCount - wrongCount) * 10;

  bool wait = false;

  List letters;
  int letterIndex;

  final flutterTts = FlutterTts();
  final player = AssetsAudioPlayer.newPlayer();

  WordsViewModel() {
    shuffle();
    refresh();
  }

  Future<void> initSpeach() async {
    flutterTts.setLanguage(
        '${_prefrence.language.locale.languageCode}-${_prefrence.language.locale.countryCode}');
    await flutterTts.setPitch(1);
    await flutterTts.setSpeechRate(0.3);
  }

  void shuffle() {
    colors = colors..shuffle();
  }

  Future<void> refresh() async {
    wait = true;
    shuffle();
    status = '🤔';
    disabledLetters = [];
    letterIndex = _random.nextInt(4);
    letters = 'words.list'.tr().split(',')..shuffle();
    await player.stop();
    notifyListeners();
    wait = false;
  }

  String getLetter(int index) => letters[index].split('|')[0];

  Future<void> playSound(String sound) async {
    await player.open(Audio("assets/sounds/$sound.mp3"));
  }

  Future<void> verify(String letter) async {
    wait = true;
    await player.stop();
    await flutterTts.stop();

    if (getLetter(letterIndex) == letter) {
      playSound('correct');
      status = '🥳';
      correctCount++;
      disabledLetters = letters.map((m) => m.split('|')[0]).toList();

      Future.delayed(const Duration(seconds: 3), () => refresh());
    } else {
      playSound('wrong');
      status = '😕';
      wrongCount++;
      disabledLetters.add(letter);
      wait = false;
    }
    notifyListeners();
  }

  Future<void> spell() async {
    final text = letters[letterIndex].split('|');
    var speach = text[0].toLowerCase();
    if (speach != 'ğ') {
      speach = 'words.speach'.tr(args: [text[2], text[1].toLowerCase()]);
    }
    await flutterTts.speak(speach);
  }
}
