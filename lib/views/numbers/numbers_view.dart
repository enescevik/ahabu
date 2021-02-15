import 'package:ahabu/views/numbers/numbers_viewmodel.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class NumbersView extends StatelessWidget {
  const NumbersView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NumbersViewModel>.reactive(
      viewModelBuilder: () => NumbersViewModel(),
      onModelReady: (model) => model.initSpeach(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.amber,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.deepOrangeAccent,
          title: Text('numbers.title'.tr()),
          actions: [
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: model.wait ? null : model.refresh,
            ),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Stack(
                children: [
                  Positioned(
                    right: 30,
                    top: 20,
                    child: Align(
                      alignment: Alignment.topRight,
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
                    child: Text(
                      model.letters[model.letterIndex],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 200.0,
                        shadows: [
                          Shadow(color: Colors.black45, offset: Offset(1, 1))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.white54,
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _Word(word: model.letters[0], color: model.colors[0]),
                  _Word(word: model.letters[1], color: model.colors[1]),
                  _Word(word: model.letters[2], color: model.colors[2]),
                  _Word(word: model.letters[3], color: model.colors[3]),
                ],
              ),
            ),
            model.showScore ? _Score() : Container(),
            Flexible(
              child: Container(
                alignment: Alignment.center,
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: Text(
                    model.status,
                    style: TextStyle(
                      fontSize: 200.0,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Word extends ViewModelWidget<NumbersViewModel> {
  const _Word({@required this.word, @required this.color});

  final String word;
  final Color color;

  @override
  Widget build(BuildContext context, NumbersViewModel model) {
    return Flexible(
      child: Container(
        child: FractionallySizedBox(
          widthFactor: 0.9,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton(
              onPressed: model.disabledLetters.contains(word)
                  ? null
                  : () => model.verify(word),
              color: color,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: BorderSide(color: Colors.white70),
              ),
              child: Text(
                word,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 75.0,
                  shadows: [
                    Shadow(color: Colors.white30, offset: Offset(1, 1))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Score extends ViewModelWidget<NumbersViewModel> {
  const _Score({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, NumbersViewModel model) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
