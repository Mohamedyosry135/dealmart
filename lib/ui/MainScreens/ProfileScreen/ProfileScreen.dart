import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dealmart/base/BaseStatefullWidget.dart';
import 'package:dealmart/resources/AppColors.dart';
import 'package:dealmart/resources/Strings.dart';
import 'package:dealmart/ui/MainScreens/ProfileScreen/bloc/UpdateProfile.dart';
import 'package:dealmart/ui/MainScreens/bloc/UserInfo.dart';
import 'package:dealmart/ui/signUp/model/RegisterResponseModel.dart';
import 'package:dealmart/utils/ImagePickerHelper.dart';
import 'package:dealmart/utils/global_vars.dart';
import 'package:dealmart/utils/navigator.dart';
import 'package:dealmart/utils/shared_utils.dart';
import 'package:dealmart/utils/size_config.dart';
import 'package:dealmart/utils/static_ui.dart';
import 'package:flutter/material.dart';
import 'package:dealmart/utils/image_file.dart' as image_file;
import 'package:dealmart/utils/colors_file.dart' as colorsValues;
import 'package:flutter/services.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:toast/toast.dart';

import '../MainScreen.dart';
import 'model/EditProfileResponse.dart';

class ProfileScreen extends BaseStatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends BaseState<ProfileScreen> {
   TextEditingController name_controller = TextEditingController();
   TextEditingController email_controller = TextEditingController();
   TextEditingController phone_controller = TextEditingController();
   TextEditingController oldPassword_controller = TextEditingController();
   TextEditingController newPassword_controller = TextEditingController();

   final _passwordFocusNode = FocusNode();
   final _usernameFocusNode = FocusNode();
   final _emailFocusNode = FocusNode();
   final _confirmPasswordFocusNode = FocusNode();
   final _phoneFocusNode = FocusNode();

  bool obscureText = false;
  bool obscureText2 = false;
  bool isSocial = false;
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
  File _image;
   final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  RegExp emailRegExp = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
   void _onFocusChange(){
     setState(() {

     });
   }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _usernameFocusNode.addListener(_onFocusChange);
    _passwordFocusNode.addListener(_onFocusChange);
    _emailFocusNode.addListener(_onFocusChange);
    _confirmPasswordFocusNode.addListener(_onFocusChange);
    _phoneFocusNode.addListener(_onFocusChange);

    if(GlobalVars.userData == null)
    Timer(Duration(milliseconds: 200), () {
      showLoadingDialog();
      UserInfo().getUserInfo(_scaffoldKey).then((value){
        hideDialog();
        GlobalVars.userData = value.user;
        if(GlobalVars.userData != null){
          name_controller = TextEditingController(text: GlobalVars.userData.fullName);
          email_controller = TextEditingController(text: GlobalVars.userData.email);
          phone_controller = TextEditingController(text: GlobalVars.userData.phone);
          setState(() {
             if(GlobalVars.userData.isGoogleOrFacebookAccount == 0){
               isSocial = false;
             }else{
               isSocial = true;
             }
          });
        }
      });
    });
    else{
      name_controller = TextEditingController(text: GlobalVars.userData.fullName);
      email_controller = TextEditingController(text: GlobalVars.userData.email);
      phone_controller = TextEditingController(text: GlobalVars.userData.phone);
    }

  }
  @override
  Widget getAppbar() {
    // TODO: implement getAppbar
    return AppBar(
      elevation: 0.0,
      backgroundColor: Color(0xfff7f7f7),
      centerTitle: true,
      title: Text(
        translator.translate("Profile"),
        style: TextStyle(color: colorsValues.blackColor),
      ),

    );
  }
   Future<bool> closeApp(){
     StaticUI().closeApp(context);
   }
  @override
  Widget getBody(BuildContext context) {
    SizeConfig().init(context);
    return WillPopScope(
      onWillPop: closeApp,
      child: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40.0),
                        bottomRight: Radius.circular(40.0)),
                    color: Color(0xfff7f7f7)
                ),
                padding: EdgeInsets.only(bottom: 20, top: 20,left: 15.0,right: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: (){
                              ImagePickerHelper().pickImage(context, (File image) async {
                                await setState(() {
                                  _image = image;
                                });
                              });
                            },
                            child: Container(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(35.0),
                                child: _image==null?FadeInImage.assetNetwork(
                                  placeholder: image_file.placeHolderImageProfile,
                                  image: GlobalVars.userData == null? "" :GlobalVars.userData.profilePicture.toString() == 'null'? "" :"https://dealmart.herokuapp.com/" + GlobalVars.userData.profilePicture,
                                  fit: BoxFit.cover,
                                ):Image.file(_image),
                              ),
                              width: 70,
                              height: 70,
                            ),

                          ),
                          SizedBox(width: 10.0,),
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                              Text(
                                GlobalVars.userData == null?"" :"${GlobalVars.userData.fullName}",
                                style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(""),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        showLoadingDialog();
                        if(_image == null){
                          callUpdate();
                        }
                        else{
                          UpdateProfileBloc().callUpdateImage(onImageSuccess, onError, _image);
                        }
                      },
                      child: Container(
                        width: 70,
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Color.fromRGBO(80, 81, 80, 1.0)),
                        child: Center(
                            child: Text(
                              translator.translate("Save"),
                              style: TextStyle(color: colorsValues.whiteColor),
                            )),
                      ),
                    ),
                  ],
                ),



              ),

              SizedBox(height: 20,),
              Container(
                margin: EdgeInsets.only(left: 15, right: 15),
                padding: EdgeInsets.symmetric(horizontal: 10),
                width: MediaQuery.of(context).size.width,
                height: 64,
                decoration: BoxDecoration(
                    border: Border.all(color: _usernameFocusNode.hasFocus?PRIMARY_COLOR:Colors.grey.withOpacity(.1),width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(25))
                ),
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
                      contentPadding:
                      EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                      labelText: translator.translate('Phone or email')),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.only(left: 15, right: 15),
                padding: EdgeInsets.symmetric(horizontal: 10),
                width: MediaQuery.of(context).size.width,
                height: 64,
                decoration: BoxDecoration(
                    border: Border.all(color: _emailFocusNode.hasFocus?PRIMARY_COLOR:Colors.grey.withOpacity(.1),width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(25))
                ),
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
                      contentPadding:
                      EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                      labelText:  translator.translate('Email...')),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.only(left: 15, right: 15),
                padding: EdgeInsets.symmetric(horizontal: 10),
                width: MediaQuery.of(context).size.width,
                height: 64,
                decoration: BoxDecoration(
                    border: Border.all(color: _phoneFocusNode.hasFocus?PRIMARY_COLOR:Colors.grey.withOpacity(.1),width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(25))
                ),
                child: TextField(
                  controller: phone_controller,
                  focusNode: _phoneFocusNode,
                  decoration: new InputDecoration(
                      counterText: '',
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      contentPadding:
                      EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                      labelText:  translator.translate('Phone...')),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.only(left: 15, right: 15),
                padding: EdgeInsets.symmetric(horizontal: 10),
                width: MediaQuery.of(context).size.width,
                height: 64,
                decoration: BoxDecoration(
                    border: Border.all(color: _passwordFocusNode.hasFocus?PRIMARY_COLOR:Colors.grey.withOpacity(.1),width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(25))
                ),
                child: TextField(
                  controller: oldPassword_controller,
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
                      labelText:  translator.translate('Old password')),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.only(left: 15, right: 15),
                padding: EdgeInsets.symmetric(horizontal: 10),
                width: MediaQuery.of(context).size.width,
                height: 64,
                decoration: BoxDecoration(
                    border: Border.all(color: _confirmPasswordFocusNode.hasFocus?PRIMARY_COLOR:Colors.grey.withOpacity(.1),width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(25))
                ),
                child: TextField(
                  controller: newPassword_controller,
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
                      labelText:  translator.translate('New Password')),
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

  void callUpdate(){
//    if(phone_controller.text.isEmpty)
//      showSnack(Strings.enterMobileNumber());
//    else if(name_controller.text.isEmpty )
//      showSnack(Strings.txt_enter_full_name());
//    else if(email_controller.text.isEmpty || !emailRegExp.hasMatch(email_controller.text))
//      showSnack(Strings.txt_valid_email());
//    else if(password_controller.text.length < 8)
//      showSnack(Strings.txt_error_password_length());
//    else if(password_controller.text != repeatPassword_controller.text)
//      showSnack(Strings.txt_error_confirm_passLword());
//    else {
     showLoadingDialog();
      UpdateProfileBloc().callUpdateProfile(onSuccess, onError, name_controller.text,phone_controller.text,email_controller.text,oldPassword_controller.text);
      if(oldPassword_controller.text.isNotEmpty || newPassword_controller.text.isNotEmpty){
        UpdateProfileBloc().callUpdatePassword(oldPassword_controller.text,newPassword_controller.text,isSocial).then((value){
          hideDialog();
          if(value == "200"){
            Toast.show("Password updated successfully", context,backgroundColor: Colors.green);
            navigateAndClearStack(context, MainScreen(position: 2,));
          }else{
            Toast.show(value, context,backgroundColor: Colors.red);
          }
        });
      }
  }

  onError(error) {
    hideDialog();
    showSnack(error.toString());
    print(error);
  }

  onSuccess(EditProfileResponse response) {
    hideDialog();
    if(response.code == 200){
//      setState(() {
//        GlobalVars.userData = response.success;
//      });
      showSnack('Profile updated successfully');
       navigateAndClearStack(context, MainScreen(position: 2,));
    }
    else
      showSnack("error");
  }
   onImageSuccess(dynamic response) {

    final Map parsed = json.decode(response.toString());
    print("updateResponse ${parsed['code']}");
//    EditProfileResponse xx = EditProfileResponse.fromJson(parsed);
    if (parsed['code'].toString() == '200' ) {
      callUpdate();
    } else
      showSnack(parsed['success']);
  }
}
