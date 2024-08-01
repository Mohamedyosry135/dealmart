import 'package:dealmart/base/BaseStatefullWidget.dart';
import 'package:dealmart/resources/AppColors.dart';
import 'package:dealmart/utils/size_config.dart';
import 'package:dealmart/utils/static_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dealmart/utils/image_file.dart' as image_file;
import 'package:dealmart/utils/colors_file.dart' as colorsValues;
import 'package:localize_and_translate/localize_and_translate.dart';

class ContactUs extends BaseStatefulWidget {
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends BaseState<ContactUs> {
  final TextEditingController name_controoler = TextEditingController();
  final TextEditingController email_controoler = TextEditingController();
  final TextEditingController message_controoler = TextEditingController();

  final _usernameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _messageFocusNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _usernameFocusNode.addListener(_onFocusChange);
    _emailFocusNode.addListener(_onFocusChange);
    _messageFocusNode.addListener(_onFocusChange);
  }
  void _onFocusChange(){
    setState(() {

    });
  }
  @override
  Widget getAppbar() {
    // TODO: implement getAppbar
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0.0,
      centerTitle: true,
      title: Text(
        translator.translate("Contact Us"),
        style: TextStyle(
            color: Color(0xff212221),
            fontWeight: FontWeight.w600,
            fontSize: 30.0
        ),
      ),
      leading: IconButton(
        onPressed: ()=>Navigator.pop(context),
        icon: Icon(Icons.arrow_back_ios,color: Color(0xff212221),size: 30,),
      ),
    );
  }

  @override
  Widget getBody(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.only(left: 10.0,right: 10.0),
              child: Image.asset(
                'images/contact_image.png',
              ),
            ),
            Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Text(
                  translator.translate("Need any help?"),
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20,color: Color(0xff212221)),
                )),
            SizedBox(
              height: 12,
            ),
            Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Text(
                  translator.translate("Send Us a message"),
                  style: TextStyle(
                      color: Color(0xff9b9b9b), fontSize: 14),
                )),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              margin: EdgeInsets.only(left: 20, right: 20),
              width: MediaQuery.of(context).size.width,
              height: 64,
              decoration: BoxDecoration(
                  border: Border.all(color: _usernameFocusNode.hasFocus?PRIMARY_COLOR:Colors.grey.withOpacity(.1),width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(25))
              ),
              child: TextField(
                controller: name_controoler,
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
                    labelText: translator.translate('Full Name')),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              margin: EdgeInsets.only(left: 20, right: 20),
              width: MediaQuery.of(context).size.width,
              height: 64,
              decoration: BoxDecoration(
                  border: Border.all(color: _emailFocusNode.hasFocus?PRIMARY_COLOR:Colors.grey.withOpacity(.1),width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(25))
              ),
              child: TextField(
                controller: email_controoler,
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
                    labelText: translator.translate('Email')),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              margin: EdgeInsets.only(left: 20, right: 20),
              width: MediaQuery.of(context).size.width,
//              height: 64,
              decoration: BoxDecoration(
                  border: Border.all(color: _messageFocusNode.hasFocus?PRIMARY_COLOR:Colors.grey.withOpacity(.1),width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(25))
              ),
              child: TextField(
                controller: message_controoler,
                focusNode: _messageFocusNode,
                maxLines: 8,
                decoration: new InputDecoration(
                    counterText: '',
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    contentPadding: EdgeInsets.only(left: 15, bottom: 10, top: 10, right: 15),
                    labelText: translator.translate('Your Message')),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: Center(
                  child: Text(
                      translator.translate("Send"),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600
                    ),
                  )
              ),
              width: SizeConfig.safeBlockHorizontal * 90,
              height: 60,
              decoration: BoxDecoration(
                  gradient: new LinearGradient(
                    colors: [
                      Color.fromRGBO(250, 159, 66, 1.0),
                      Color.fromRGBO(238, 117, 42, 1.0)
                    ],
                    stops: [0.0, 1.0],
                    begin: FractionalOffset.topCenter,
                    end: FractionalOffset.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(12)),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
