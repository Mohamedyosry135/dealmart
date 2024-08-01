import 'package:dealmart/base/BaseStatefullWidget.dart';
import 'package:dealmart/resources/AppColors.dart';
import 'package:dealmart/resources/Strings.dart';
import 'package:dealmart/ui/MainScreens/MainScreen.dart';
import 'package:dealmart/ui/signUp/bloc/RegisterBloc.dart';
import 'package:dealmart/ui/signUp/termsAndConditions.dart';
import 'package:dealmart/ui/sign_in/bloc/SoicalLogin.dart';
import 'package:dealmart/ui/sign_in/model/LoginResponse.dart';
import 'package:dealmart/utils/global_vars.dart';
import 'package:dealmart/utils/navigator.dart';
import 'package:dealmart/utils/shared_utils.dart';
import 'package:dealmart/utils/size_config.dart';
import 'package:dealmart/utils/static_ui.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dealmart/utils/image_file.dart' as image_file;
import 'package:dealmart/utils/colors_file.dart' as colorsValues;
import 'package:flutter_icons/flutter_icons.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:toast/toast.dart';

import 'VerificationCodeScreen.dart';
import 'model/RegisterResponseModel.dart';

class RegistScreen extends BaseStatefulWidget {
  @override
  _RegistScreenState createState() => _RegistScreenState();
}

class _RegistScreenState extends BaseState<RegistScreen> {
  final TextEditingController name_controller = TextEditingController();
  final TextEditingController email_controller = TextEditingController();
  final TextEditingController phone_controller = TextEditingController();
  final TextEditingController password_controller = TextEditingController();
  final TextEditingController repeatPassword_controller =
      TextEditingController();
  final _passwordFocusNode = FocusNode();
  final _usernameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _confirmPasswordFocusNode = FocusNode();
  final _phoneFocusNode = FocusNode();
  bool isValidNumber = false;
  String pattern = r'^(010|011|012|015)[0-9]{8}$';
  RegExp regExp;
  RegExp emailRegExp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  FirebaseAuth _auth = FirebaseAuth.instance;

  bool obscureText = false;
  bool obscureText2 = false;
  bool agreeTermsAndConditions = false;
  void _toggle() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  void _toggle2() {
    setState(() {
      obscureText2 = !obscureText2;
    });
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
  void initState() {
    // TODO: implement initState
    super.initState();
    regExp = new RegExp(pattern);
    _usernameFocusNode.addListener(_onFocusChange);
    _passwordFocusNode.addListener(_onFocusChange);
    _emailFocusNode.addListener(_onFocusChange);
    _confirmPasswordFocusNode.addListener(_onFocusChange);
    _phoneFocusNode.addListener(_onFocusChange);
  }

  @override
  Widget getBody(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 20.0, right: 20.0),
          child: Column(
            children: [
              Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    translator.translate("Sign Up"),
                    style: TextStyle(
                        color: Colors.black.withOpacity(.8),
                        fontSize: 26,
                        fontWeight: FontWeight.bold),
                  )),
              SizedBox(
                height: 20,
              ),
              Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                      translator.translate("Please fill below the required data to be one of the winners"),
                    style: TextStyle(
                        color: Colors.grey.withOpacity(.5), fontSize: 16),
                  )),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                width: MediaQuery.of(context).size.width,
                height: 64,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: _usernameFocusNode.hasFocus
                            ? PRIMARY_COLOR
                            : colorsValues.borderGray,
                        width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(25))),
                child: TextField(
                  controller: name_controller,
                  focusNode: _usernameFocusNode,
                  decoration: new InputDecoration(
                      counterText: '',
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      contentPadding: EdgeInsets.only(
                          left: 15, bottom: 11, top: 11, right: 15),
                      labelStyle: TextStyle(color: colorsValues.geyHintText),
                      labelText: translator.translate('Full Name')),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                width: MediaQuery.of(context).size.width,
                height: 64,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: _emailFocusNode.hasFocus
                            ? PRIMARY_COLOR
                            : colorsValues.borderGray,
                        width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(25))),
                child: TextField(
                  controller: email_controller,
                  focusNode: _emailFocusNode,
                  decoration: new InputDecoration(
                      counterText: '',
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      contentPadding: EdgeInsets.only(
                          left: 15, bottom: 11, top: 11, right: 15),
                      labelStyle: TextStyle(color: colorsValues.geyHintText),
                      labelText: translator.translate('Email...')),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                width: MediaQuery.of(context).size.width,
                height: 64,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: _phoneFocusNode.hasFocus
                            ? PRIMARY_COLOR
                            : colorsValues.borderGray,
                        width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(25))),
                child: TextField(
                  controller: phone_controller,
                  focusNode: _phoneFocusNode,                    keyboardType: TextInputType.phone,

                  decoration: new InputDecoration(
                      counterText: '',
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      contentPadding: EdgeInsets.only(
                          left: 15, bottom: 11, top: 11, right: 15),
                      labelStyle: TextStyle(color: colorsValues.geyHintText),
                      labelText: translator.translate('Phone...')),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                width: MediaQuery.of(context).size.width,
                height: 64,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: _passwordFocusNode.hasFocus
                            ? PRIMARY_COLOR
                            : colorsValues.borderGray,
                        width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(25))),
                child: TextField(
                  controller: password_controller,
                  focusNode: _passwordFocusNode,
                  decoration: new InputDecoration(
                      counterText: '',
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      contentPadding: EdgeInsets.only(
                          left: 15, bottom: 11, top: 11, right: 15),
                      labelStyle: TextStyle(color: colorsValues.geyHintText),
                      labelText: translator.translate('Password')),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                width: MediaQuery.of(context).size.width,
                height: 64,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: _confirmPasswordFocusNode.hasFocus
                            ? PRIMARY_COLOR
                            : colorsValues.borderGray,
                        width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(25))),
                child: TextField(
                  controller: repeatPassword_controller,
                  focusNode: _confirmPasswordFocusNode,
                  decoration: new InputDecoration(
                      counterText: '',
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      contentPadding: EdgeInsets.only(
                          left: 15, bottom: 11, top: 11, right: 15),
                      labelStyle: TextStyle(color: colorsValues.geyHintText),
                      labelText: translator.translate('Confirm Password')),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          agreeTermsAndConditions = !agreeTermsAndConditions;
                        });
                      },
                      child: Container(
                        width: 25,
                        height: 25,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border:
                                Border.all(color: colorsValues.orangeColor)),
                        child: Center(
                            child: agreeTermsAndConditions
                                ? Icon(
                                    Icons.check,
                                    color: colorsValues.orangeColor,
                                    size: 14,
                                  )
                                : Container()),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          translator.translate("By Clicking Sign Up You agreed to our"),
                          style: TextStyle(fontWeight: FontWeight.w300),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        InkWell(
                          onTap: () {
                            navigateAndKeepStack(context, TermsAndConditions());
                          },
                          child: Text(
                            translator.translate("Terms & Conditions"),
                            style: TextStyle(color: colorsValues.orangeColor),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20, right: 10),
                child: Column(
                  children: [
                    SizedBox(
                      height: 21,
                    ),
                    InkWell(
                      onTap: () {
                        if (!agreeTermsAndConditions)
                          showSnack(Strings.acceptTermsAndCondation());
                        else if (phone_controller.text.isEmpty)
                          showSnack(Strings.enterMobileNumber());
                        else if (name_controller.text.isEmpty)
                          showSnack(Strings.txt_enter_full_name());
                        else if (email_controller.text.isEmpty ||
                            !emailRegExp.hasMatch(email_controller.text))
                          showSnack(Strings.txt_valid_email());
                        else if (password_controller.text.length < 8)
                          showSnack(Strings.txt_error_password_length());
                        else if (password_controller.text !=
                            repeatPassword_controller.text)
                          showSnack(Strings.txt_error_confirm_passLword());
                        else if (!isValidNumber) {
                          showLoadingDialog();
                          if (phone_controller.text.substring(0, 1) == "0") {
                            print("Country ${GlobalVars.Country}");
                            print(
                                "CountryCountry ${phone_controller.text.substring(1)}");
                            RegisterBloc()
                                .checkUser(
                              "${GlobalVars.Country}" +
                                  "${phone_controller.text.substring(1)}",
                              email_controller.text,
                            )
                                .then((code) {
                              hideDialog();
                              if (code == 200) {
                                navigateAndKeepStack(
                                    context,
                                    VerificationCodeScreen(
                                      email: email_controller.text,
                                      name: name_controller.text,
                                      password: password_controller.text,
                                      phone: "${GlobalVars.Country}" +
                                          "${phone_controller.text.substring(1)}",
                                    ));
                              } else if (code == 401) {
                                showSnack(Strings.txt_error_unique_user());
                              } else {
                                showSnack(Strings.txt_error());
                              }
                            });
                          } else {
                            RegisterBloc()
                                .checkUser(
                                    "${GlobalVars.Country}${phone_controller.text}",
                                    email_controller.text)
                                .then((code) {
                              hideDialog();
                              if (code == 200) {
                                navigateAndKeepStack(
                                    context,
                                    VerificationCodeScreen(
                                      email: email_controller.text.substring(1),
                                      name: name_controller.text,
                                      password: password_controller.text,
                                      phone: "${GlobalVars.Country}" +
                                          "${phone_controller.text}",
                                    ));
                              } else if (code == 401) {
                                showSnack(Strings.txt_error_unique_user());
                              } else {
                                showSnack(Strings.txt_error());
                              }
                            });
                          }
                        } else
                          showSnack(Strings.txt_error_phone_number());
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 62,
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
                                translator.translate('Sign Up'),
                          style: TextStyle(
                              color: WHITE,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
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
                            color: Color.fromRGBO(246, 246, 246, 1),
                          ),
                        ),
                        Text(
                          translator.translate('Or Sign Up with'),
                          style: TextStyle(
                              color: Color.fromRGBO(102, 102, 102, 1),
                              fontSize: 15),
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
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          translator.translate('If you have an account'),
                          style: TextStyle(
                              color: Color.fromRGBO(22, 22, 22, 1),
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                                translator.translate('Sign In'),
                              style: TextStyle(
                                  color: PRIMARY_COLOR,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  decoration: TextDecoration.none),
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
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
                // Toast.show("There's Error", context,backgroundColor: Colors.red);
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
                // Toast.show("There's Error", context,backgroundColor: Colors.red);
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
    hideDialog();
    showSnack(error.toString());
    print(error);
  }

  onSuccess(RegisterResponseModel response) {
    hideDialog();
    if (response.code == 200) {
      setUserToken(response.accessToken);
      // navigateAndKeepStack(context,  ConfirmPhoneNumber());
      navigateAndClearStack(
          context,
          MainScreen(
            position: 2,
          ));
    } else
      showSnack(response.msg);
  }
}
