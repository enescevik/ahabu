import 'package:ahabu/app/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:stacked_services/stacked_services.dart';

enum DialogType { base, form, loading }

void setupDialogUi() {
  final _dialog = locator<DialogService>();

  final builders = {
    DialogType.base: (context, sheetRequest, completer) =>
        _BasicCustomDialog(request: sheetRequest, completer: completer),
    DialogType.form: (context, sheetRequest, completer) =>
        _FormCustomDialog(request: sheetRequest, completer: completer),
    DialogType.loading: (context, sheetRequest, completer) =>
        _LoadingCustomDialog(message: sheetRequest.description),
  };

  _dialog.registerCustomDialogBuilders(builders);
}

class _BasicCustomDialog extends StatelessWidget {
  final DialogRequest request;
  final Function(DialogResponse) completer;
  const _BasicCustomDialog({Key key, this.request, this.completer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            request.title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
          ),
          SizedBox(height: 10),
          Text(
            request.description,
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () => completer(DialogResponse(confirmed: true)),
            child: Container(
              child: request.showIconInMainButton
                  ? Icon(Icons.check_circle)
                  : Text(request.mainButtonTitle),
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 10),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _FormCustomDialog extends HookWidget {
  final DialogRequest request;
  final Function(DialogResponse) completer;
  const _FormCustomDialog({Key key, this.request, this.completer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = useTextEditingController();
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            request.title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
          ),
          SizedBox(height: 20),
          TextField(
            controller: controller,
          ),
          SizedBox(height: 20),
          GestureDetector(
            onTap: () => completer(DialogResponse(responseData: [
              controller.text,
            ])),
            child: Container(
              child: request.showIconInMainButton
                  ? Icon(Icons.check_circle)
                  : Text(request.mainButtonTitle),
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 10),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _LoadingCustomDialog extends StatelessWidget {
  final String message;
  const _LoadingCustomDialog({Key key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20.0),
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Theme.of(context).canvasColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(children: [
            Container(child: CircularProgressIndicator()),
            SizedBox(height: 20.0),
            Container(
              child: Text(
                message ?? '',
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
          ]),
        ),
      ],
    );
  }
}
