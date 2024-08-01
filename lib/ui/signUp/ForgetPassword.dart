import 'package:custom_switch/custom_switch.dart';
import 'package:dealmart/base/BaseStatefullWidget.dart';
import 'package:dealmart/resources/AppColors.dart';
import 'package:dealmart/utils/validation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dealmart/utils/navigator.dart';
import 'package:dealmart/utils/size_config.dart';
import 'package:dealmart/utils/static_ui.dart';
import 'package:dealmart/utils/colors_file.dart' as colorsValues;
import 'package:dealmart/resources/Strings.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import 'bloc/RegisterBloc.dart';
import 'model/RegisterResponseModel.dart';


class ForgetPasswordScreen extends BaseStatefulWidget {
  String _phonenumber;
  ForgetPasswordScreen(this._phonenumber);
  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends BaseState<ForgetPasswordScreen> {

  final  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController password_controller = TextEditingController();
  final TextEditingController repeatPassword_controller = TextEditingController();
  final _passwordFocusNode = FocusNode();
  final _confirmPasswordFocusNode = FocusNode();
  bool showPassword=true;
  bool showconfirmPassword=true;




  @override
  Widget getAppbar() {
    // TODO: implement getAppbar
    return StaticUI().appBarWidget("");
  }

  @override
  Widget getBody(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(key: _scaffoldKey,backgroundColor: WHITE,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton:
      Padding(
        padding: const EdgeInsets.all(16),
        child: InkWell(
          onTap: (){
            if(password_controller.text.length  < 8){
              showSnack(Strings.txt_error_password_length());
            }else if (password_controller.text != repeatPassword_controller.text){
              showSnack(Strings.txt_error_confirm_passLword());
            }else{
              showLoadingDialog();
              RegisterBloc().callForgetPassword(onSuccess, onError,password_controller.text,"+2"+widget._phonenumber);
            }
            }


          ,
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
            child: Center(child: Text(translator.translate('Send'),style: TextStyle(color: WHITE,fontSize: 20,fontWeight: FontWeight.bold),)),
          ),
        ),
      )
      ,
      body: Container(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

SizedBox(height: 40,),
              Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                      translator.translate("Forget Password"),
                    style: TextStyle(color: Colors.black.withOpacity(.8),fontSize: 20,fontWeight: FontWeight.w600),
                  )),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: SizeConfig.safeBlockVertical * 5,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                width: MediaQuery.of(context).size.width,
                height: 64,
                decoration: BoxDecoration(
                    border: Border.all(color: _passwordFocusNode.hasFocus?PRIMARY_COLOR:Colors.grey.withOpacity(.1),width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(25))
                ),
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
                      contentPadding:
                      EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
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
                    border: Border.all(color: _confirmPasswordFocusNode.hasFocus?PRIMARY_COLOR:Colors.grey.withOpacity(.1),width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(25))
                ),
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
                      contentPadding:
                      EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                      labelText: translator.translate('Confirm Password')),
                ),
              ),
              SizedBox(
                height: 20,
              ),

            ],
          ),
        ),
      ),
    );
  }

  onError(error) {
    hideDialog();
    showSnack(error.toString());
    print(error);
  }

  onSuccess(RegisterResponseModel response) {
    hideDialog();
    StaticUI().showSnackbar("Password updated Succefully", _scaffoldKey,color: colorsValues.greenColor);
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushNamedAndRemoveUntil(context, "/sign_in", (r) => false);

    });
  }
}
