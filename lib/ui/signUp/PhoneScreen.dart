import 'package:dealmart/base/BaseStatefullWidget.dart';
import 'package:dealmart/resources/AppColors.dart';
import 'package:dealmart/resources/Strings.dart';
import 'package:dealmart/ui/signUp/bloc/RegisterBloc.dart';
import 'package:dealmart/utils/global_vars.dart';
import 'package:dealmart/utils/navigator.dart';
import 'package:dealmart/utils/static_ui.dart';
import 'package:flutter/material.dart';
import 'package:dealmart/utils/colors_file.dart' as colorsValues;
import 'package:dealmart/utils/size_config.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import 'VerificationCodeScreen.dart';

class PhoneScreen extends BaseStatefulWidget {
  bool isFordetPassword;
  PhoneScreen({this.isFordetPassword = false});
  @override
  _PhoneScreenState createState() => _PhoneScreenState();
}

class _PhoneScreenState extends BaseState<PhoneScreen> {

  final  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController phone_controller = TextEditingController();
  final _phoneFocusNode = FocusNode();

  Color signUpcolor =  colorsValues.lightOrange ;
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
                    translator.translate("Forget Password"),
                    style: TextStyle(color: Colors.black.withOpacity(.8),fontSize: 20,fontWeight: FontWeight.w600),
                  )),
              SizedBox(
                height: 20,
              ),
              Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                      translator.translate("Enter the email or phone associated to your account"),
                    style: TextStyle(color: Colors.grey.withOpacity(.5),fontSize: 14),
                  )),
              SizedBox(
                height: 40,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                width: MediaQuery.of(context).size.width,
                height: 64,

                child: Container(
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
                    keyboardType: TextInputType.phone,
                    decoration: new InputDecoration(

                        counterText: '',
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        contentPadding:
                        EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                        labelText: translator.translate('Phone ...')),
                  ),
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
                        if(phone_controller.text.isEmpty)
                          showSnack(Strings.enterMobileNumber());
                        else
                          {

                            String Phone="";

                            if(phone_controller.text.substring(0, 1) == "0"){
                              Phone="${GlobalVars.Country}${phone_controller.text.substring(1)}";
                            }
                            else{
                              Phone= "${GlobalVars.Country}${phone_controller.text}";
                            }
                            RegisterBloc().checkUser(Phone, "email",isOnlyPhone: true).then((value) {
                              if(value==200){
                                showSnack("Not registered");

                              }
                              else {
                                navigateAndKeepStack(context, VerificationCodeScreen(phone:Phone ,isForgetPassword: true,));

                              }
                            });

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
                        child: Center(child: Text(translator.translate('Send'),style: TextStyle(color: WHITE,fontSize: 20,fontWeight: FontWeight.bold),)),
                      ),
                    ),


                  ],
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

  @override
  Widget getAppbar() {
    // TODO: implement getAppbar
    return StaticUI().appBarWidget("");

  }


}
