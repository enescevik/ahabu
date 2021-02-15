import 'package:ahabu/views/words/words_viewmodel.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class WordsView extends StatelessWidget {
  const WordsView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final portrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return ViewModelBuilder<WordsViewModel>.reactive(
      viewModelBuilder: () => WordsViewModel(),
      onModelReady: (model) => model.initSpeach(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.amber,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.deepOrangeAccent,
          title: Text('words.title'.tr()),
          actions: [
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: model.wait ? null : model.refresh,
            ),
          ],
        ),
        body: SafeArea(
          left: false,
          right: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                flex: 2,
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, top: 10.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: IconButton(
                          alignment: Alignment.bottomRight,
                          onPressed: model.wait ? null : model.spell,
                          icon: Icon(
                            Icons.volume_up,
                            size: 40,
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Row(
                        mainAxisAlignment: portrait
                            ? MainAxisAlignment.center
                            : MainAxisAlignment.spaceAround,
                        children: [
                          FittedBox(
                            fit: BoxFit.contain,
                            child: Text(
                              model.getLetter(model.letterIndex),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 300.0,
                                shadows: [
                                  Shadow(
                                    color: Colors.black45,
                                    offset: Offset(1, 1),
                                  )
                                ],
                              ),
                            ),
                          ),
                          portrait ? Container() : _Smiley(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              model.showScore ? _Score() : Container(),
              Flexible(
                flex: 2,
                child: Container(
                  color: Colors.white54,
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _Word(word: model.getLetter(0), color: model.colors[0]),
                      _Word(word: model.getLetter(1), color: model.colors[1]),
                      _Word(word: model.getLetter(2), color: model.colors[2]),
                      _Word(word: model.getLetter(3), color: model.colors[3]),
                    ],
                  ),
                ),
              ),
              portrait ? Flexible(flex: 1, child: _Smiley()) : Container(),
            ],
          ),
        ),
      ),
    );
  }
}

class _Smiley extends ViewModelWidget<WordsViewModel> {
  const _Smiley({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, WordsViewModel model) {
    return Container(
      alignment: Alignment.center,
      child: FittedBox(
        fit: BoxFit.contain,
        child: Text(
          model.status,
          style: TextStyle(fontSize: 300.0),
        ),
      ),
    );
  }
}

class _Word extends ViewModelWidget<WordsViewModel> {
  const _Word({@required this.word, @required this.color});

  final String word;
  final Color color;

  @override
  Widget build(BuildContext context, WordsViewModel model) {
    final portrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return Flexible(
      child: Container(
        child: FractionallySizedBox(
          widthFactor: portrait ? null : 0.9,
          heightFactor: portrait ? 0.5 : null,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 4.0,
            ),
            child: RaisedButton(
              onPressed: model.disabledLetters.contains(word)
                  ? null
                  : () => model.verify(word),
              color: color,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: BorderSide(color: Colors.white70),
              ),
              child: FittedBox(
                fit: BoxFit.contain,
                child: Text(
                  word,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 300.0,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(color: Colors.white30, offset: Offset(1, 1))
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Score extends ViewModelWidget<WordsViewModel> {
  const _Score({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, WordsViewModel model) {
    return Container(
      padding: EdgeInsets.only(bottom: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          RichText(
            text: TextSpan(
              text: 'general.score'.tr(),
              style: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                shadows: [Shadow(color: Colors.white24, offset: Offset(1, 1))],
              ),
              children: [
                TextSpan(
                  text: model.score().toString(),
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
          RichText(
            text: TextSpan(
              text: 'general.total'.tr(),
              style: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                shadows: [Shadow(color: Colors.white24, offset: Offset(1, 1))],
              ),
              children: [
                TextSpan(
                  text: (model.correctCount + model.wrongCount).toString(),
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
