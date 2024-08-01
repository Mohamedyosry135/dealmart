import 'package:dealmart/resources/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:path/path.dart';

class SneakbarHelper {
  /* Example

    SneakbarHelper(context)
            ..buildBodyWithMsgAndButton("hi", "d;ldfjdljfdo", () {})
            ..show();

   */

  BuildContext context;
  GlobalKey<ScaffoldState> _key;
  BuildContext _context;
  int _secondsDuration = 20;

  Widget _body = Container();
  Color _backgroundColor = Colors.black26;

  SneakbarHelper.init(var key) {
    _key = key;
  }

  SneakbarHelper(this._context);

  void setBackgroundColor(Color color) {
    _backgroundColor = color;
  }

  void setDuration(int seconds) {
    _secondsDuration = seconds;
  }

  buildBodyWithMsgAndButton(
      String buttonTitle, String msg, Function onBtnPressed) { //fixme code review large method
    _body = Container(
      height: 90,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              msg,
              style: TextStyle(fontSize: 15),
            ),
          ),
          RaisedButton(
            color: PRIMARY_COLOR,
            onPressed: () {
              onBtnPressed();
            },
            child: Text(
              buttonTitle,
              style: TextStyle(fontSize: 15),
            ),
          )
        ],
      ),
    );
  }

  buildBodyWithYesNo(String msg, Function onYesPressed, Function onNoPressed) {
    _body = Container(
      height: 90,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              msg,
              style: TextStyle(fontSize: 18),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              RaisedButton(
                color: PRIMARY_COLOR,
                onPressed: () {
                  onYesPressed();
                },
                child: Text(
    translator.translate('YES'),
                  style: TextStyle(fontSize: 15),
                ),
              ),
              RaisedButton(
                color: PRIMARY_COLOR,
                onPressed: () {
                  onNoPressed();
                },
                child: Text(
    translator.translate('NO'),
                  style: TextStyle(fontSize: 15),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  buildCustomBody(Widget w) {
    this._body = w;
  }

  show() {
    if (_context != null) {
      Scaffold.of(_context).showSnackBar(_getSneakBar());
    } else {
      _key.currentState.showSnackBar(_getSneakBar());
    }
  }

  hide() {
    _key.currentState.hideCurrentSnackBar(reason: SnackBarClosedReason.dismiss);
  }

  SnackBar _getSneakBar() {
    return new SnackBar(
      content: _body,
      backgroundColor: _backgroundColor,
      duration: Duration(seconds: _secondsDuration),
    );
  }
}
