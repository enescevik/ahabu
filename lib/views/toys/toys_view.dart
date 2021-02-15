import 'package:ahabu/views/toys/toys_viewmodel.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';

class ToysView extends StatelessWidget {
  const ToysView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ToysViewModel>.reactive(
      viewModelBuilder: () => ToysViewModel(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.amber,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.deepOrangeAccent,
          title: Text('toys.title'.tr()),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SvgPicture.asset('assets/images/404.svg'),
          ),
        ),
      ),
    );
  }
}
