import 'package:dealmart/base/BaseStatefullWidget.dart';
import 'package:dealmart/resources/AppColors.dart';
import 'package:dealmart/resources/Strings.dart';
import 'package:dealmart/ui/MainScreens/MainScreen.dart';
 import 'package:dealmart/ui/signUp/ForgetPassword.dart';
import 'package:dealmart/ui/signUp/bloc/RegisterBloc.dart';
import 'package:dealmart/ui/signUp/termsAndConditions.dart';
import 'package:dealmart/ui/sign_in/bloc/SoicalLogin.dart';
import 'package:dealmart/ui/sign_in/model/LoginResponse.dart';
import 'package:dealmart/utils/navigator.dart';
import 'package:dealmart/utils/shared_utils.dart';
import 'package:dealmart/utils/size_config.dart';
import 'package:dealmart/utils/static_ui.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dealmart/utils/image_file.dart' as image_file;
import 'package:dealmart/utils/colors_file.dart' as colorsValues;
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:dealmart/utils/staticVar.dart' as staticVar;

import 'model/RegisterResponseModel.dart';


class VerificationCodeScreen extends BaseStatefulWidget {
  String  name;
  String  phone;
  String  email;
  String  password;
  bool isForgetPassword  ;
  VerificationCodeScreen({this.name,this.phone,this.email,this.password,this.isForgetPassword = false});
  @override
  _VerificationCodeScreenState createState() => _VerificationCodeScreenState();
}

class _VerificationCodeScreenState extends BaseState<VerificationCodeScreen> {
  TextEditingController _pinCodeController  = TextEditingController();
  String verificationId;

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("phonephone : ${widget.phone}");
    loginUser(context);
  }

  @override
  Widget getAppbar() {
    // TODO: implement getAppbar
    return StaticUI().appBarWidget("");
  }


  @override
  Widget getBody(BuildContext context) {
    SizeConfig().init(context);
    return  Container(
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 20.0,right: 20.0),
          child: Column(

            children: [
              SizedBox(
                height: 70,
              ),
              Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    translator.translate("Code Verification"),
                    style: TextStyle(color: Colors.black.withOpacity(.8),fontSize: 20,fontWeight: FontWeight.w500),
                  )),
              SizedBox(
                height: 20,
              ),
              Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                      translator.translate("Enter the verification code we just sent to your Phone"),
                    style: TextStyle(color: Colors.grey.withOpacity(.5),fontSize: 14),
                  )),
              SizedBox(
                height: 40,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                width: MediaQuery.of(context).size.width,
                height: 64,

                child: PinCodeTextField(
                  length: 6,
                  obsecureText: false,
                  animationType: AnimationType.fade,
                  textInputType: TextInputType.number,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.underline,
                    fieldHeight: 50,
                    fieldWidth: 40,
                    activeColor: Color(0xfffa9f42),
                    activeFillColor: Colors.transparent,
                    inactiveColor: Color(0xffebebeb),
                    inactiveFillColor: Colors.transparent,
                    selectedColor: Color(0xfffa9f42),
                    selectedFillColor: Colors.transparent,


                  ),
                  animationDuration: Duration(milliseconds: 300),
                  backgroundColor: Colors.transparent,

                  enableActiveFill: true,
                  controller: _pinCodeController,

                ),
              ),



              SizedBox(
                height: 20,
              ),


              Container(padding: EdgeInsets.only(left: 20,right: 10),
                child: Column(
                  children: [
                    SizedBox(height: 21,),

                    InkWell(
                      onTap: (){
  _verifiyWithCode(context);
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
                        child: Center(child: Text( translator.translate('Verify Code'),style: TextStyle(color: WHITE,fontSize: 16,fontWeight: FontWeight.bold),)),
                      ),
                    ),


                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(onTap: (){
                loginUser(context);
              },
                child: Container(
                  child: Column(mainAxisAlignment: MainAxisAlignment.center,children: [
                    Text( translator.translate("Resend Code?")),
                    SizedBox(
                      height: 1,
                    ),
                    Container(height: 1,color: Colors.black,width: 90,)
                  ],),
                ),
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
    if(response.code == 200){
      setUserToken(response.accessToken);
      // navigateAndKeepStack(context,  ConfirmPhoneNumber());
      navigateAndClearStack(context, MainScreen(position: 2,));
    }
    else
      showSnack(response.msg);
  }

  Future<void> _verifiyWithCode(BuildContext context) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    final code = _pinCodeController.text.trim();
    AuthCredential credential = PhoneAuthProvider.getCredential(verificationId: verificationId, smsCode: code);
    try{
      AuthResult result = await _auth.signInWithCredential(credential);
      FirebaseUser user = result.user;
      IdTokenResult token = await user.getIdToken();
      if(user != null){
        if (widget.isForgetPassword){

          navigateAndKeepStack(context, ForgetPasswordScreen(widget.phone));

    }else {
        showLoadingDialog();
        RegisterBloc().callRegister(onSuccess, onError, widget.name,widget.phone,widget.email,widget.password);}
      }

    } on PlatformException  catch( error){
      showSnack(error.message);
    }



  }
  Future<bool> loginUser(BuildContext context) async{

  print("phonephone ${widget.phone}");
  print("isForgetPassword ${widget.isForgetPassword}");
    FirebaseAuth _auth = FirebaseAuth.instance;
    _auth.verifyPhoneNumber(
        phoneNumber: widget.phone,
        timeout: Duration(seconds: 60),
        verificationCompleted: (AuthCredential credential) async{
          AuthResult result = await _auth.signInWithCredential(credential);
          FirebaseUser user = result.user;
          IdTokenResult token = await user.getIdToken();
          staticVar.Jwt_token = token.token.toString();
          if(user != null){
            print("login");
            Future.delayed(Duration(seconds: 2)).then((_){
              _pinCodeController.text = "";
            }).then((_){
              Future.delayed(Duration(seconds: 1)).then((_){
 if (widget.isForgetPassword){
   navigateAndKeepStack(context, ForgetPasswordScreen(widget.phone));
 }else {
   RegisterBloc().callRegister(
       onSuccess, onError, widget.name,  widget.phone, widget.email,
       widget.password);
 }});
            });
          }else{
            print("Error");
          }

          //This callback would gets called when verification is done auto maticlly
        },
        verificationFailed: (AuthException exception){
          print(exception.message);
          print("login2");
        },
        codeSent: (String verificationId, [int forceResendingToken]){
          this.verificationId =  verificationId;

          print("login3 $forceResendingToken");
          //  Loader.hideDialog(context);
        },
        codeAutoRetrievalTimeout: ( String verificationId){
          this.verificationId =  verificationId;
          print("login4 $verificationId");
        }
    );
  }

}
