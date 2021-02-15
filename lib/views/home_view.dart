import 'package:ahabu/views/home_viewmodel.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      builder: (context, model, child) => Container(
        child: Scaffold(
          backgroundColor: Colors.amber,
          body: SafeArea(child: _ItemList()),
        ),
      ),
    );
  }
}

class _ItemList extends ViewModelWidget<HomeViewModel> {
  const _ItemList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, HomeViewModel model) {
    var items = <Widget>[
      _Item(
        text: 'words.title'.tr(),
        image: 'words',
        onPressed: model.wordsScreen,
      ),
      _Item(
        text: 'numbers.title'.tr(),
        image: 'numbers',
        onPressed: model.numbersScreen,
      ),
      _Item(
        text: 'toys.title'.tr(),
        image: 'toys',
        onPressed: model.toysScreen,
      ),
    ];

    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      items.insert(0, _Header());
      return Column(children: items);
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [_Header(), Row(children: items)],
    );
  }
}

class _Header extends ViewModelWidget<HomeViewModel> {
  const _Header({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, HomeViewModel model) {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.only(left: 20),
            child: Image.asset(
              'assets/images/logo.png',
              scale: 1.5,
            ),
          ),
          Column(
            children: [
              Center(
                child: Text(
                  'title'.tr().toUpperCase(),
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(color: Colors.black38, offset: Offset(1, 1))
                    ],
                  ),
                ),
              ),
              Container(
                child: Center(
                  child: Text('version'.tr(args: [model.version])),
                ),
              ),
            ],
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 20.0),
            child: TextButton.icon(
              onPressed: model.settingsScreen,
              label: Text('general.settings'.tr()),
              icon: Icon(Icons.settings),
            ),
          ),
        ],
      ),
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({
    @required this.text,
    @required this.image,
    @required this.onPressed,
  });

  final String text;
  final String image;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    final portrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return Flexible(
      child: Container(
        alignment: Alignment.center,
        child: FractionallySizedBox(
          widthFactor: 0.8,
          heightFactor: portrait ? 0.9 : null,
          child: RaisedButton(
            onPressed: this.onPressed,
            color: Colors.deepOrangeAccent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
              side: BorderSide(color: Colors.white70),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _image(portrait),
                  SizedBox(height: 10.0),
                  Center(
                    child: Text(
                      text,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _image(bool portrait) {
    final box = SvgPicture.asset('assets/images/$image.svg');
    return portrait ? Flexible(child: box) : FittedBox(child: box);
  }
}
