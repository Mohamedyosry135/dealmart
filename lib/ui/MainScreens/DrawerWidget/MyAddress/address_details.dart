import 'dart:async';

import 'package:dealmart/base/BaseStatefullWidget.dart';
import 'package:dealmart/resources/AppColors.dart';
import 'package:dealmart/ui/MainScreens/DrawerWidget/MyAddress/model/Address_model.dart';
import 'package:dealmart/ui/map_view/MapView.dart';
import 'package:dealmart/utils/global_vars.dart';
import 'package:dealmart/utils/navigator.dart';
import 'package:dealmart/utils/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import '../../MainScreen.dart';
import 'bloc/SetAddressBloc.dart';
import 'package:dealmart/utils/colors_file.dart' as colorsValues;

class AddressDetails extends BaseStatefulWidget {
  // String lat, lng, address;
  Adress AddressItem;
  bool fromCheckOut;
  String Address;
  bool isAddNew=false;
  String lat;
  String long;

  // AddressDetails({this.address, this.lat, this.lng});
  AddressDetails(this.fromCheckOut,{this.AddressItem,this. Address,this.isAddNew,this.lat,this.long});
  @override
  _AddressDetailsState createState() => _AddressDetailsState();
}

class _AddressDetailsState extends BaseState<AddressDetails> {
  TextEditingController _addressController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  final _firstnameFocusNode = FocusNode();
  final _lastnameFocusNode = FocusNode();
  final _phoneFocusNode = FocusNode();
  final _addressFocusNode = FocusNode();
  bool EditAddress = true;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Completer<GoogleMapController> _controller = Completer();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.AddressItem==null){
      setState(() {
       // _addressController.text=widget.Address;
      });
    }
    else {
      setState(() {

        _addressController.text = widget.AddressItem.address;
        _phoneController.text = widget.AddressItem.phone??"";
        _firstNameController.text = widget.AddressItem.firstName??"";
        _lastNameController.text = widget.AddressItem.lastName??"";



      });
    }

  }

  changeAddressWidget() {
    return Column(
      children: [
        SizedBox(
          height: 23.0,
        ),
        Container(
          alignment: translator.currentLanguage == 'ar'
              ? Alignment.centerRight
              : Alignment.centerLeft,
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Text(
            translator.translate("Address information"),
            style: TextStyle(
                color: colorsValues.blackTwo,
                fontSize: 20,
                fontWeight: FontWeight.w700),
          ),
        ),
        SizedBox(
          height: 23.0,
        ),
        Container(
          alignment: translator.currentLanguage == 'ar'
              ? Alignment.centerRight
              : Alignment.centerLeft,
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Text(
    translator.translate("Address details"),
            style: TextStyle(
              color: colorsValues.dustyOrange,
              fontSize: 15,
            ),
          ),
        ),
        SizedBox(
          height: 12.0,
        ),
        Container(

          height: 50,
          alignment: translator.currentLanguage == 'ar'
              ? Alignment.centerRight
              : Alignment.centerLeft,
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Container(
            width: SizeConfig.safeBlockHorizontal * 90,
            height: 40,
            padding: EdgeInsets.only(top: 20),
            child: TextField(
                controller: _addressController,
                textAlign: TextAlign.justify,

                decoration: new InputDecoration(
                    counterText: '',
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: translator.translate("Address details")

                  // labelText: 'Address details'),
                )),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Container(
          height: 1,
          width: SizeConfig.safeBlockHorizontal * 100,
          margin: EdgeInsets.only(left: 20, right: 20),
          color: colorsValues.greyBorder,
        )
      ],
    );
  }

  Widget LasttNameWidget() {
    return Column(
      children: [
        Container(
          alignment: translator.currentLanguage == 'ar'
              ? Alignment.centerRight
              : Alignment.centerLeft,
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Text(
            translator.translate("Last name"),
            style: TextStyle(
              color: colorsValues.dustyOrange,
              fontSize: 15,
            ),
          ),
        ),
        SizedBox(
          height: 12.0,
        ),
        Container(
          width: SizeConfig.safeBlockHorizontal * 100,
          height: 50,
          alignment: translator.currentLanguage == 'ar'
              ? Alignment.centerRight
              : Alignment.centerLeft,
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Container(
            width: SizeConfig.safeBlockHorizontal * 50,
            height: 40,
            padding: EdgeInsets.only(top: 20),
            child: TextField(
                controller: _lastNameController,
                focusNode: _lastnameFocusNode,
                keyboardType: TextInputType.text,
                textAlign: TextAlign.justify,
                decoration: new InputDecoration(
                    counterText: '',
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: translator.translate("Last name")

                    // labelText: 'Address details'),
                    )),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Container(
          height: 1,
          width: SizeConfig.safeBlockHorizontal * 100,
          margin: EdgeInsets.only(left: 20, right: 20),
          color: colorsValues.greyBorder,
        )
      ],
    );
  }

  Widget PhoneWidget() {
    return Column(
      children: [
        Container(
          alignment: translator.currentLanguage == 'ar'
              ? Alignment.centerRight
              : Alignment.centerLeft,
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Text(
            translator.translate("Mobile number"),
            style: TextStyle(
              color: colorsValues.dustyOrange,
              fontSize: 15,
            ),
          ),
        ),
        SizedBox(
          height: 12.0,
        ),
        Container(
          width: SizeConfig.safeBlockHorizontal * 100,
          height: 50,
          alignment: translator.currentLanguage == 'ar'
              ? Alignment.centerRight
              : Alignment.centerLeft,
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Row(
            children: [
              Text(
                "${GlobalVars.Country}",
                style: TextStyle(
                  color: colorsValues.dustyOrange,
                  fontSize: 15,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                height: 22,
                width: 2,
                color: colorsValues.greyBorder,
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
        SizedBox(
          width: 10,
        ),
        Container(
          height: 1,
          width: SizeConfig.safeBlockHorizontal * 100,
          margin: EdgeInsets.only(left: 20, right: 20),
          color: colorsValues.greyBorder,
        )
      ],
    );
  }

  Widget FirstNameWidget() {
    return Column(
      children: [
        Container(
          alignment: translator.currentLanguage == 'ar'
              ? Alignment.centerRight
              : Alignment.centerLeft,
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Text(
            translator.translate("First name"),
            style: TextStyle(
              color: colorsValues.dustyOrange,
              fontSize: 15,
            ),
          ),
        ),
        SizedBox(
          height: 12.0,
        ),
        Container(
          width: SizeConfig.safeBlockHorizontal * 100,
          height: 50,
          alignment: translator.currentLanguage == 'ar'
              ? Alignment.centerRight
              : Alignment.centerLeft,
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Container(
            width: SizeConfig.safeBlockHorizontal * 50,
            height: 40,
            padding: EdgeInsets.only(top: 20),
            child: TextField(
                controller: _firstNameController,
                focusNode: _firstnameFocusNode,
                keyboardType: TextInputType.text,
                textAlign: TextAlign.justify,
                decoration: new InputDecoration(
                    counterText: '',
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: translator.translate("First name")

                    // labelText: 'Address details'),
                    )),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Container(
          height: 1,
          width: SizeConfig.safeBlockHorizontal * 100,
          margin: EdgeInsets.only(left: 20, right: 20),
          color: colorsValues.greyBorder,
        )
      ],
    );
  }

  @override
  Widget getAppbar() {
    // TODO: implement getAppbar
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0.0,
      centerTitle: true,
      title: Center(
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(right: 20),
          child: Text(
          translator.translate("Address details"),
            style: TextStyle(
                color: Color(0xff212221),
                fontWeight: FontWeight.w800,
                fontSize: 25.0),
          ),
        ),
      ),
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          Icons.arrow_back_ios,
          color: Color(0xff212221),
          size: 25,
        ),
      ),
    );
  }

  @override
  Widget getBody(BuildContext context) {
    SizeConfig().init(context);
    // TODO: implement getBody
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // resizeToAvoidBottomPadding: false,
      // floatingActionButton: GestureDetector(
      //   onTap: () {
      //     showLoadingDialog();
      //     GlobalVars.defaultAddress.address=_addressController.text;
      //
      //     if(widget.isAddNew!=null){
      //       if(widget.fromCheckOut){
      //         SetAddressBloc()
      //             .setAddress(_scaffoldKey, context, "${GlobalVars.defaultAddress.address}",
      //             "${widget.lat}", "${widget.long}",
      //             first_name: _firstNameController.text,
      //             last_name: _lastNameController.text,
      //             phone: _phoneController.text).then((value) {
      //           hideDialog();
      //
      //           Navigator.of(context).pop();
      //           // Navigator.of(context).pop();
      //           Navigator.of(context).pop();
      //           Navigator.of(context).pop();
      //           Navigator.of(context).pop(GlobalVars.defaultAddress.address);
      //         });
      //
      //       }
      //       else {
      //         SetAddressBloc()
      //             .setAddress(_scaffoldKey, context, "${GlobalVars.defaultAddress.address}",
      //             "${widget.lat}", "${widget.long}",
      //             first_name: _firstNameController.text,
      //             last_name: _lastNameController.text,
      //             phone: _phoneController.text)
      //             .then((value) {
      //           hideDialog();
      //           Navigator.of(context).pop();
      //           Navigator.of(context).pop();
      //           Navigator.of(context).pop(GlobalVars.defaultAddress.address);
      //         });
      //
      //
      //       }
      //     }
      //     else {
      //       if(widget.fromCheckOut){
      //         Navigator.of(context).pop();
      //         Navigator.of(context).pop();
      //         Navigator.of(context).pop(GlobalVars.defaultAddress.address);
      //
      //       }
      //       else {
      //         SetAddressBloc()
      //             .setAddress(_scaffoldKey, context, "${GlobalVars.defaultAddress.address}",
      //             "${widget.AddressItem.lat}", "${widget.AddressItem.lng}",
      //             first_name: _firstNameController.text,
      //             last_name: _lastNameController.text,
      //             phone: _phoneController.text)
      //             .then((value) {
      //           hideDialog();
      //           // Navigator.of(context).pop();
      //           Navigator.of(context).pop(GlobalVars.defaultAddress.address);
      //         });
      //
      //
      //       }
      //     }
      //
      //
      //   },
      //   child: Container(
      //     margin: EdgeInsets.all(20),
      //     width: MediaQuery.of(context).size.width,
      //     height: 62,
      //     decoration: BoxDecoration(
      //       gradient: new LinearGradient(
      //         colors: [
      //           Color(0xfffa9f42),
      //           Color(0xffee752a),
      //         ],
      //         stops: [0.0, 1.0],
      //         begin: FractionalOffset.topCenter,
      //         end: FractionalOffset.bottomCenter,
      //       ),
      //       borderRadius: BorderRadius.all(Radius.circular(15)),
      //     ),
      //     child: Center(
      //         child: Text(
      //       "SAVE ADDRESS",
      //       style: TextStyle(
      //           color: WHITE, fontSize: 16, fontWeight: FontWeight.bold),
      //     )),
      //   ),
      // ),
      body: SingleChildScrollView(
        // physics: ScrollPhysics(),
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: 15.0,
              ),
              changeAddressWidget(),
              SizedBox(
                height: 23.0,
              ),
              Container(
                alignment: translator.currentLanguage == 'ar'
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Text(
                  translator.translate("Personal information"),
                  style: TextStyle(
                      color: colorsValues.blackTwo,
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                ),
              ),
              SizedBox(
                height: 25.0,
              ),
              PhoneWidget(),
              SizedBox(
                height: 19.0,
              ),
              FirstNameWidget(),
              SizedBox(
                height: 19.0,
              ),
              LasttNameWidget(),
              SizedBox(
                height: SizeConfig.safeBlockVertical * 3,
              ),
              GestureDetector(
                onTap: () {
                  showLoadingDialog();
                  GlobalVars.defaultAddress.address=_addressController.text;

                  if(widget.isAddNew!=null){
                    if(widget.fromCheckOut){
                      SetAddressBloc()
                          .setAddress(_scaffoldKey, context, "${GlobalVars.defaultAddress.address}",
                          "${widget.lat}", "${widget.long}",
                          first_name: _firstNameController.text,
                          last_name: _lastNameController.text,
                          phone: _phoneController.text).then((value) {
                        hideDialog();

                        Navigator.of(context).pop();
                        // Navigator.of(context).pop();
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                        Navigator.of(context).pop(GlobalVars.defaultAddress.address);
                      });

                    }
                    else {
                      SetAddressBloc()
                          .setAddress(_scaffoldKey, context, "${GlobalVars.defaultAddress.address}",
                          "${widget.lat}", "${widget.long}",
                          first_name: _firstNameController.text,
                          last_name: _lastNameController.text,
                          phone: _phoneController.text)
                          .then((value) {
                        hideDialog();
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                        Navigator.of(context).pop(GlobalVars.defaultAddress.address);
                      });


                    }
                  }
                  else {
                    if(widget.fromCheckOut){
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                      Navigator.of(context).pop(GlobalVars.defaultAddress.address);

                    }
                    else {
                      SetAddressBloc()
                          .setAddress(_scaffoldKey, context, "${GlobalVars.defaultAddress.address}",
                          "${widget.AddressItem.lat}", "${widget.AddressItem.lng}",
                          first_name: _firstNameController.text,
                          last_name: _lastNameController.text,
                          phone: _phoneController.text)
                          .then((value) {
                        hideDialog();
                        // Navigator.of(context).pop();
                        Navigator.of(context).pop(GlobalVars.defaultAddress.address);
                      });


                    }
                  }


                },
                child: Container(
                  margin: EdgeInsets.all(20),
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
                          translator.translate("SAVE ADDRESS"),
                        style: TextStyle(
                            color: WHITE, fontSize: 16, fontWeight: FontWeight.bold),
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
