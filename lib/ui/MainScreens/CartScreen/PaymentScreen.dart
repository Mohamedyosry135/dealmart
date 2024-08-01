import 'package:dealmart/base/BaseStatefullWidget.dart';
import 'package:dealmart/resources/AppColors.dart';
import 'package:dealmart/ui/MainScreens/MainScreen.dart';
import 'package:dealmart/utils/bottomSheet.dart';
import 'package:dealmart/utils/global_vars.dart';
import 'package:dealmart/utils/navigator.dart';
import 'package:flutter/material.dart';
import 'package:dealmart/utils/size_config.dart';
import 'package:dealmart/utils/image_file.dart' as imagefile;
import 'package:dealmart/utils/colors_file.dart' as colorsfile;
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:toast/toast.dart';

import 'FailCheckOut.dart';
import 'SuccessCheckOut.dart';
import 'WebviewScreen.dart';
import 'bloc/CartBloc.dart';


class PaymentScreen extends BaseStatefulWidget {
  bool isWallet;
  double totalPrice;
  PaymentScreen({this.isWallet,this.totalPrice});
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends BaseState<PaymentScreen> {
  final GlobalKey<ScaffoldState> _bottomScaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

   bool promoValid = false;
  String promocode = "";
  final _cardNameFocusNode = FocusNode();
  final _cardNumberFocusNode = FocusNode();
  final _monthFocusNode = FocusNode();
  final _yearFocusNode = FocusNode();
  final cVVFocusNode = FocusNode();
  final _phoneFocusNode = FocusNode();
   TextEditingController cardName_controller = TextEditingController();
  TextEditingController cardNumber_controller = TextEditingController();
  TextEditingController month_controller = TextEditingController();
  TextEditingController year_controller = TextEditingController();
  TextEditingController vVV_controller = TextEditingController();
  TextEditingController _phoneController = TextEditingController();






  showGeneralBottomSheet(){
    return Container(key:_bottomScaffoldKey ,
        height: 500,
        width: SizeConfig.safeBlockHorizontal * 100,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(25),color: colorsfile.whiteColor),
        padding: EdgeInsets.only(left: 20,right: 20),
        child: SingleChildScrollView(
          child: Column(children: [
            SizedBox(height: 25,),
            Container(
              padding: EdgeInsets.only(left: 20,right: 20),
              child: Row(

                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                      onTap: (){
                        Navigator.of(context).pop();
                      },
                      child: Text(translator.translate("Cancel"),style: TextStyle(color: Color(0xff7e7c7c),fontSize: 14),)),

                ],),),
            SizedBox(height: 25,),
            Container(
              margin: EdgeInsets.only(left: 15, right: 15),
              padding: EdgeInsets.symmetric(horizontal: 10),
              width: MediaQuery.of(context).size.width,
              height: 64,
              decoration: BoxDecoration(
                  border: Border.all(color: _cardNameFocusNode.hasFocus?PRIMARY_COLOR:Colors.grey.withOpacity(.1),width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(25))
              ),
              child: TextField(
                controller: cardName_controller,
                focusNode: _cardNameFocusNode,

                decoration: new InputDecoration(
                    counterText: '',
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    contentPadding:
                    EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                    labelText: translator.translate('Cardholder Name...')),
              ),
            ),
            SizedBox(height: 15,),
            Container(
              margin: EdgeInsets.only(left: 15, right: 15),
              padding: EdgeInsets.symmetric(horizontal: 10),
              width: MediaQuery.of(context).size.width,
              height: 64,
              decoration: BoxDecoration(
                  border: Border.all(color: _cardNumberFocusNode.hasFocus?PRIMARY_COLOR:Colors.grey.withOpacity(.1),width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(25))
              ),
              child: TextField(
                controller: cardNumber_controller,
                focusNode: _cardNumberFocusNode,
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
                    labelText: translator.translate('Card Number...')),
              ),
            ),
            SizedBox(height: 15,),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(left: 15,right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  Container(
                    width: MediaQuery.of(context).size.width/4.6,
                    height: 50,
                    decoration: BoxDecoration(
                        border: Border.all(color: _monthFocusNode.hasFocus?PRIMARY_COLOR:Colors.grey.withOpacity(.1),width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(22))
                    ),
                    child: TextField(
                      controller: month_controller,
                      focusNode: _monthFocusNode,
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
                          labelText: 'MMM...'),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width/4.6,
                    height: 50,
                    decoration: BoxDecoration(
                        border: Border.all(color: _yearFocusNode.hasFocus?PRIMARY_COLOR:Colors.grey.withOpacity(.1),width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(22))
                    ),
                    child: TextField(
                      controller: year_controller,
                      focusNode: _yearFocusNode,
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
                          labelText: 'YY...'),
                    ),
                  ),
                  Container(

                    width: MediaQuery.of(context).size.width/4.6,
                    height: 50,
                    decoration: BoxDecoration(
                        border: Border.all(color: cVVFocusNode.hasFocus?PRIMARY_COLOR:Colors.grey.withOpacity(.1),width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(22))
                    ),
                    child: TextField(
                      controller: vVV_controller,
                      focusNode: cVVFocusNode,
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
                          labelText: 'CCV...'),
                    ),
                  ),
                ],),),
            SizedBox(height: 15,),
            Container(
              margin: EdgeInsets.only(left: 15, right: 15),
              padding: EdgeInsets.symmetric(horizontal: 10),
              width: MediaQuery.of(context).size.width,
              height: 64,
              decoration: BoxDecoration(
                  border: Border.all(color: _cardNameFocusNode.hasFocus?PRIMARY_COLOR:Colors.grey.withOpacity(.1),width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(25))
              ),
              child: Row(
                children: [
                  Text(
                    "${GlobalVars.Country}",
                    style: TextStyle(
                      color: colorsfile.dustyOrange,
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    height: 22,
                    width: 2,
                    color: colorsfile.greyBorder,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: SizeConfig.safeBlockHorizontal * 50,
                    height: 40,
                    padding: EdgeInsets.only(top: 20),
                    child: TextField(
                        controller: _phoneController,
                        focusNode: _phoneFocusNode,
                        keyboardType: TextInputType.phone,
                        textAlign: TextAlign.justify,
                        decoration: new InputDecoration(
                            counterText: '',
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintText: "0123456789"

                          // labelText: 'Address details'),
                        )),
                  )
                ],
              ),
            ),
            SizedBox(height: 50,),
            InkWell(onTap: (){

              if(cardNumber_controller.text.isEmpty||
                  vVV_controller.text.isEmpty||
                  month_controller.text.isEmpty||
                  year_controller.text.isEmpty||
                  cardName_controller.text.isEmpty){
                Toast.show("Please enter all data", context, backgroundColor: Colors.red);

              }
              else {
                Map data={
                  "card_number": cardNumber_controller.text,
                  "cvv": vVV_controller.text,
                  "expiry_month": month_controller.text,
                  "expiry_year": year_controller.text,
                  "customer_name": cardName_controller.text,
                  "amount": "${widget.totalPrice}",
                  "phone":GlobalVars.Country+_phoneController.text
                };

                print("data:  ${data}");
                showLoadingDialog();
                CartBloc().chargeCard(_scaffoldKey,data,widget.isWallet == true ? 0 : 1 ).then((value) {
                  hideDialog();
                  if(value != null && value['error'] == null){
                    print("${value}");
                    Navigator.push(context,
                      CustomScalePageRoute(
                        builder: (context) => URLWebView(cowpay_reference_id: "${value['otp']}",cowpay_url: "http://dealmart.herokuapp.com/api/otp/${value['otp']}",transaction_id: value['transaction_id'],isWallet: widget.isWallet,)))
                        .then((value) {Navigator.pop(context);}
                    );
                  }
                  else {
                    Toast.show("${value['error'].toString().replaceFirst("{", "").replaceFirst("}", "")}", context, backgroundColor: Colors.red,duration:4);
                  }
                  print("valuevalue ${value}");
                });
              }


            },
              child: Container(
                width: MediaQuery.of(context).size.width/1.4,
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
                      translator.translate('Proceed'),
                      style: TextStyle(
                          color: WHITE, fontSize: 16, fontWeight: FontWeight.bold),
                    )),
              ),
            ),
          ],),
        )

    );
  }
  showFawrylBottomSheet(){
    return Container(key:_bottomScaffoldKey ,
        height: 350,
        width: SizeConfig.safeBlockHorizontal * 100,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(25),color: colorsfile.whiteColor),
        padding: EdgeInsets.only(left: 20,right: 20),
        child: SingleChildScrollView(
          child: Column(children: [
            SizedBox(height: 25,),
            Container(
              padding: EdgeInsets.only(left: 20,right: 20),
              child: Row(

                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                      onTap: (){
                        Navigator.of(context).pop();
                      },
                      child: Text(translator.translate("Cancel"),style: TextStyle(color: Color(0xff7e7c7c),fontSize: 14),)),

                ],),),
            SizedBox(height: 25,),
            Container(
              margin: EdgeInsets.only(left: 15, right: 15),
              padding: EdgeInsets.symmetric(horizontal: 10),
              width: MediaQuery.of(context).size.width,
              height: 64,
              decoration: BoxDecoration(
                  border: Border.all(color: _cardNameFocusNode.hasFocus?PRIMARY_COLOR:Colors.grey.withOpacity(.1),width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(25))
              ),
              child: TextField(
                controller: cardName_controller,
                focusNode: _cardNameFocusNode,

                decoration: new InputDecoration(
                    counterText: '',
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    contentPadding:
                    EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                    labelText: translator.translate('Name ...')),
              ),
            ),

            SizedBox(height: 15,),
            Container(
              margin: EdgeInsets.only(left: 15, right: 15),
              padding: EdgeInsets.symmetric(horizontal: 10),
              width: MediaQuery.of(context).size.width,
              height: 64,
              decoration: BoxDecoration(
                  border: Border.all(color: _phoneFocusNode.hasFocus?PRIMARY_COLOR:Colors.grey.withOpacity(.1),width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(25))
              ),
              child: Row(
                children: [
                  Text(
                    "${GlobalVars.Country}",
                    style: TextStyle(
                      color: colorsfile.dustyOrange,
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    height: 22,
                    width: 2,
                    color: colorsfile.greyBorder,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: SizeConfig.safeBlockHorizontal * 50,
                    height: 40,
                    padding: EdgeInsets.only(top: 20),
                    child: TextField(
                        controller: _phoneController,
                        focusNode: _phoneFocusNode,
                        keyboardType: TextInputType.phone,
                        textAlign: TextAlign.justify,
                        decoration: new InputDecoration(
                            counterText: '',
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintText: "0123456789"

                          // labelText: 'Address details'),
                        )),
                  )
                ],
              ),
            ),
            SizedBox(height: 50,),
            InkWell(onTap: (){
              if(_phoneController.text.isEmpty||
                  cardName_controller.text.isEmpty){
                print(cardNumber_controller.text);
                Toast.show("Please enter all data", context, backgroundColor: Colors.red);
              }
              else {
                showLoadingDialog();
                CartBloc().chargeFawry(_scaffoldKey, cardName_controller.text.trim(), widget.totalPrice,_phoneController.text.trim(),widget.isWallet == true ? 0 : 1 ).then((value) {
                  hideDialog();
                  print("fawry resulte"+value.toString());
                  if(value['success'] != null ){
                    if (widget.isWallet){
                      Navigator.pop(context);
                    }else{
                      GlobalVars.cartLength = "0";
                      navigateAndClearStack(context, SuccessCheckOut());
                    }
                      Toast.show("${value['success'].toString().replaceFirst("{", "").replaceFirst("}", "")}", context, backgroundColor: Colors.green,duration:4);
                  }
                  else {
                    Toast.show("${value['error'].toString().replaceFirst("{", "").replaceFirst("}", "")}", context, backgroundColor: Colors.red,duration:4);
                  }
                });
              }


            },
              child: Container(
                width: MediaQuery.of(context).size.width/1.4,
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
                      'Proceed',
                      style: TextStyle(
                          color: WHITE, fontSize: 16, fontWeight: FontWeight.bold),
                    )),
              ),
            ),
          ],),
        )

    );
  }
  @override
  Widget getAppbar() {

  }

  @override
  Widget getBody(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(elevation: 0,automaticallyImplyLeading:false,backgroundColor: colorsfile.white2,
        title: Padding(
          padding: const EdgeInsets.only(right: 35),
          child: Center(
            child: Text(translator.translate('Payment'),style: TextStyle(color: colorsfile.charcoal,fontSize: 25,fontWeight: FontWeight.w600),
            ),
          ),
        ),
      leading: IconButton(iconSize: 35,color: colorsfile.charcoal,icon: Icon(Icons.keyboard_arrow_left,size: 35,), onPressed: (){
        Navigator.pop(context);
      }),),

      body: SafeArea(

        child: Container(padding: EdgeInsets.only(top:20,

          left: 16,
          right: 16,),
          child:
          SingleChildScrollView(


            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[

                Row(textDirection: TextDirection.ltr,children: [
                  Text(translator.translate('Select payment Option '),style: TextStyle(color: colorsfile.charcoal,fontSize: 16,fontWeight: FontWeight.w600),)],),
                Padding(padding: EdgeInsets.only(top:  26.0)),
                GestureDetector(onTap: (){
                  showRoundedModalBottomSheet(
                      autoResize: true,
                      dismissOnTap: false,
                      context: context,
                      radius: 30.0,
                      // This is the default
                      color: Colors.white,
                      // Also default
                      builder: (context) => showGeneralBottomSheet());
                },
                  child: Container(height: 90,child:Card(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                    child:
                    ListTile(contentPadding: EdgeInsets.only(top: 13,left: 19,right: 19),
                      leading: Image.asset(imagefile.credit,fit: BoxFit.cover,height: 30,),
                      title: Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: Text(translator.translate("Credit"),style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
                      ),

                    ),),
                  ),
                ),
                Padding(padding: EdgeInsets.only(top:  13.0)),
                GestureDetector(onTap: (){

                  showRoundedModalBottomSheet(
                      autoResize: true,
                      dismissOnTap: false,
                      context: context,
                      radius: 30.0,
                      // This is the default
                      color: Colors.white,
                      // Also default
                      builder: (context) => showFawrylBottomSheet() );


                },
                  child: Container(height: 90,child:Card(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                    child:
                    ListTile(contentPadding: EdgeInsets.only(top: 13,left: 0,right: 12),
                      leading: Image.asset(imagefile.fawery,fit: BoxFit.cover,height: 40,),
                      title: Text(translator.translate("fawry"),style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),

                    ),),
                  ),
                ),
                Padding(padding: EdgeInsets.only(top:  13.0)),
                widget.isWallet == false ? GestureDetector(onTap: (){
                  if (GlobalVars.defaultAddress.address.toString() == 'null') {
                    Toast.show("Please Choose Address", context,
                        duration: Toast.LENGTH_SHORT,
                        gravity: Toast.BOTTOM,
                        backgroundColor: Colors.red);
                  } else {
                    CartBloc().buyAllCart(_scaffoldKey).then((value) {
                      if (value == "200") {
                        GlobalVars.cartLength = "0";
                        navigateAndClearStack(context, SuccessCheckOut());
                      } else {
                        navigateAndKeepStack(context, FailCheckOut());
                        Toast.show("${value}", context,
                            duration: Toast.LENGTH_SHORT,
                            gravity: Toast.BOTTOM,
                            backgroundColor: Colors.red);
                      }
                    });
                  }
                },
                  child: Container(height: 90,child:Card(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                    child:
                    ListTile(contentPadding: EdgeInsets.only(top: 13,left: 19,right: 25),
                      leading: Image.asset(imagefile.wallet,fit: BoxFit.cover,height: 29,),
                      title: Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: Text(translator.translate("Wallet"),style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
                      ),

                    ),),
                  ),
                ) : Container(),
                Padding(padding: EdgeInsets.only(top:  13.0)),
                GestureDetector(onTap: (){
                  Toast.show("Not Supported yet", context, backgroundColor: Colors.red);
                },
                  child: Container(height: 90,child:Card(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                    child:
                    ListTile(contentPadding: EdgeInsets.only(top: 13,left: 12,right: 10),
                      leading: Image.asset(imagefile.zcash,fit: BoxFit.cover,height: 40,),
                      title: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Text(translator.translate("Zero Cash"),style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
                      ),

                    ),),
                  ),
                ),








              ],
            ),

          ),




        ),
      ),
    );
  }
}
