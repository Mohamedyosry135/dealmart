import 'dart:ui';

import 'package:dealmart/base/BaseStatefullWidget.dart';
import 'package:dealmart/resources/AppColors.dart';
import 'package:dealmart/ui/MainScreens/MainScreen.dart';
import 'package:dealmart/ui/signUp/PhoneScreen.dart';
import 'package:dealmart/ui/signUp/RegistScreen.dart';
import 'package:dealmart/ui/sign_in/bloc/LoginBloc.dart';
import 'package:dealmart/utils/global_vars.dart';
import 'package:dealmart/utils/image_file.dart';
import 'package:dealmart/utils/navigator.dart';
import 'package:dealmart/utils/shared_utils.dart';
import 'package:dealmart/utils/size_config.dart';
import 'package:dealmart/utils/static_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:dealmart/ui/sign_in/bloc/SoicalLogin.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:toast/toast.dart';
import 'model/LoginResponse.dart';
import 'package:dealmart/utils/colors_file.dart' as colorsValues;

class SignIn extends BaseStatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new SignInState();
  }
}

class SignInState extends BaseState<SignIn> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  final _passwordFocusNode = FocusNode();
  final _usernameFocusNode = FocusNode();

  bool isChecked = false;
  bool ErrorMessageBool = false;
  bool ErrorMessageEmailBool = false;
  bool ErrorMessagePasswordBool = false;

  String ErrorMessage = "";
  @override
  void initState() {
    super.initState();
    _usernameFocusNode.addListener(_onFocusChange);
    _passwordFocusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    setState(() {});
  }

  @override
  Widget getAppbar() {
    // TODO: implement getAppbar
    return StaticUI().appBarWidget("");
  }

  @override
  Widget getBody(BuildContext context) {
    // TODO: implement getBody
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: ListView(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Text(
            translator.translate('Sign In'),
            style: TextStyle(
                color: Colors.black.withOpacity(.8),
                fontSize: 20,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 11,
          ),
          Text(
            translator.translate('Please fill below the required data to be one of the winners'),
            style: TextStyle(color: Colors.grey.withOpacity(.5), fontSize: 14),
          ),
          SizedBox(
            height: 35,
          ),
          ErrorMessageBool
              ? Container(
                  padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
                  child: Text(
                    ErrorMessage,
                    style: TextStyle(
                      color: colorsValues.tomato,
                      fontSize: 12,
                    ),
                  ))
              : Container(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            width: MediaQuery.of(context).size.width,
            height: 64,
            decoration: BoxDecoration(
                border: Border.all(
                    color: ErrorMessageEmailBool?colorsValues.coral:_usernameFocusNode.hasFocus
                        ? PRIMARY_COLOR
                        : colorsValues.borderGray,
                    width: 1),
                borderRadius: BorderRadius.all(Radius.circular(25))),
            child: TextField(
              controller: _usernameController,
              focusNode: _usernameFocusNode,
              decoration: new InputDecoration(
                  counterText: '',
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  contentPadding:
                      EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                  labelStyle: TextStyle(color: colorsValues.geyHintText),
                  labelText: translator.translate('Phone or email'),
                  hintStyle: TextStyle(color: colorsValues.hintColor)),
            ),
          ),
          SizedBox(
            height: 18,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            width: MediaQuery.of(context).size.width,
            height: 64,
            decoration: BoxDecoration(
                border: Border.all(
                    color:ErrorMessagePasswordBool?colorsValues.coral: _passwordFocusNode.hasFocus
                        ? PRIMARY_COLOR
                        : colorsValues.borderGray,
                    width: 1),
                borderRadius: BorderRadius.all(Radius.circular(25))),
            child: TextField(
              controller: _passwordController,
              focusNode: _passwordFocusNode,
              obscureText: true,
              decoration: new InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  labelStyle: TextStyle(color: colorsValues.geyHintText),
                  contentPadding:
                      EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                  labelText: translator.translate('Password')),
            ),
          ),
          SizedBox(
            height: 28,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  setState(() {
                    isChecked = !isChecked;
                  });
                },
                child: Row(
                  children: <Widget>[
                    Image.asset(
                      isChecked ? CHECKED : UNCHECKED,
                      width: 32,
                      height: 32,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      translator.translate('Remember me'),
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                          fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                  onTap: () {
                    navigateAndKeepStack(context, PhoneScreen());
                  },
                  child: Text(
                      translator.translate('Forget Password?'),
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.w300),
                  )),
            ],
          ),
          SizedBox(
            height: 21,
          ),
          InkWell(
            onTap: () {
              if (_usernameController.text.isEmpty)
                setState(() {
                  ErrorMessageBool = true;
                  ErrorMessageEmailBool=true;
                  ErrorMessage = "*Please enter email or phone *";
                });
              // showSnack('Mobile number can\'t be empty');
              else if (_passwordController.text.length < 8)
                setState(() {
                  ErrorMessageBool = true;
                  ErrorMessageEmailBool = false;
                  ErrorMessagePasswordBool=true;
                  ErrorMessage = "Password can\'t be less than 8 letters";
                });
              // showSnack('Password can\'t be less than 8 letters');
              else {
                print("Phone ${_usernameController.text}");
                setState(() {
                  ErrorMessageBool = false;
                });
                if (_usernameController.text.contains("${GlobalVars.Country}")) {
                // if (_usernameController.text.contains('+20')) {
                  showLoadingDialog();
                  LoginBloc().callLogin(onSuccess, onError,
                      _usernameController.text, _passwordController.text);
                } else {
                  print("Phone2 ${_usernameController.text}");
                  if (_usernameController.text.substring(0, 1) == "0") {
                    print("Phone3 ${_usernameController.text}");
                    print("substringsubstring  ${GlobalVars.Country}${_usernameController.text.substring(1)}");
                    showLoadingDialog();
                    LoginBloc().callLogin(
                        onSuccess,
                        onError,
                        "${GlobalVars.Country}${_usernameController.text.substring(1)}",
                        _passwordController.text);
                  } else {
                    print("Phone4 ${_usernameController.text}");
                    showLoadingDialog();
                    if (LoginBloc().isNumeric(_usernameController.text)) {
                      LoginBloc().callLogin(
                          onSuccess,
                          onError,
                          "${GlobalVars.Country}${_usernameController.text}",
                          _passwordController.text);
                    } else {
                      print("Phone4 ${_usernameController.text}");

                      showLoadingDialog();

                      LoginBloc().callLogin(
                          onSuccess,
                          onError,
                          "${_usernameController.text}",
                          _passwordController.text);
                    }
                  }
                }
              }
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 60,
              decoration: BoxDecoration(
                gradient: new LinearGradient(
                  colors: [
                    Color(0xfffa9f42),
                    Color(0xffee752a),
                  ],
                  stops: [0.0, 1.0],
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter,
                ),
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: Center(
                  child: Text(
                      translator.translate('Sign in'),
                style: TextStyle(
                    color: WHITE, fontSize: 16, fontWeight: FontWeight.bold),
              )),
            ),
          ),
          SizedBox(
            height: 29,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Container(
                  height: 1,
                  color: Color(0xfff6f6f6),
                ),
              ),
              Text(
                translator.translate('Or Sign in with'),
                style: TextStyle(
                    color: Color.fromRGBO(102, 102, 102, 1), fontSize: 15),
              ),
              Expanded(
                child: Container(
                  height: 1,
                  color: Color.fromRGBO(246, 246, 246, 1),
                ),
              ),
            ],
          ),
          signInWithSocialMedia(context),
          SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                translator.translate('If you don\'t have an account'),
                style: TextStyle(
                    color: Color(0xff161616),
                    fontSize: 12,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(
                width: 5,
              ),
              InkWell(
                  onTap: () {
                    navigateAndKeepStack(context, RegistScreen());
                  },
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                        color: PRIMARY_COLOR,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        decoration: TextDecoration.none),
                  )),
            ],
          ),
          SizedBox(
            height: 100,
          ),
        ],
      ),
    );
  }

  Widget signInWithSocialMedia(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 19,
        ),
        InkWell(
          onTap: () {
            showLoadingDialog();
            AuthService(context).facebookSignIn().then((value) {
              hideDialog();
              if (value == "200") {
                navigateAndClearStack(
                    context,
                    MainScreen(
                      position: 2,
                    ));
              } else {
                Toast.show("${value}", context, backgroundColor: Colors.red);
              }
            });
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 60,
            decoration: BoxDecoration(
              color: Color(0xff3d5a96),
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            child: Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  FontAwesome.facebook,
                  size: 25,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 19,
                ),
                Text(
                  translator.translate('Sign up with Facebook'),
                  style: TextStyle(
                      color: WHITE, fontSize: 14, fontWeight: FontWeight.w400),
                ),
              ],
            )),
          ),
        ),
        SizedBox(
          height: 19,
        ),
        InkWell(
          onTap: () {
            showLoadingDialog();
            AuthService(context).googleSignIn().then((value) {
              hideDialog();
              if (value == "200") {
                navigateAndClearStack(
                    context,
                    MainScreen(
                      position: 2,
                    ));
              } else {
                Toast.show(value, context, backgroundColor: Colors.red);
              }
            });
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 60,
            decoration: BoxDecoration(
              color: Color(0xfff7f7f7),
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            child: Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'images/icons_google.png',
                ),
                SizedBox(
                  width: 19,
                ),
                Text(
                  translator.translate('Sign up with Google'),
                  style: TextStyle(
                      color: Color(0xff828282),
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                ),
              ],
            )),
          ),
        )
      ],
    );
  }

  onError(error) {
    print("onError");
    hideDialog();
    showSnack(error.toString());
    print(error);
  }

  onSuccess(LoginResponse response) {
    print("onSuccess");
    hideDialog();
    if (response.status == '200') {
      setRememberMe(isChecked);
      print("Token ${response.success.token}");
      setUserToken(response.success.token);
      // getUserCurrency();
      navigateAndClearStack(
          context,
          MainScreen(
            position: 2,
          ));
    } else {
    //  Navigator.of(context).pop();

      setState(() {
        ErrorMessageBool = true;
        ErrorMessage = response.msg;
      });
      // showSnack(response.msg);

    }
    // Navigator.of(context).pop();
  }
}
