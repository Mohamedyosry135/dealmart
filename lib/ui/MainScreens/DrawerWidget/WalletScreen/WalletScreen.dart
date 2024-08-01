import 'dart:async';

import 'package:dealmart/resources/AppColors.dart';
import 'package:dealmart/ui/GeneralModels/GeneralAPi.dart';
import 'package:dealmart/ui/MainScreens/CartScreen/PaymentScreen.dart';
import 'package:dealmart/ui/MainScreens/DrawerWidget/WalletScreen/transactionModel.dart';
import 'package:dealmart/ui/MainScreens/bloc/UserInfo.dart';
import 'package:dealmart/utils/decimal_input.dart';
import 'package:dealmart/utils/global_vars.dart';
import 'package:dealmart/utils/image_file.dart' as image_file;
import 'package:dealmart/utils/colors_file.dart' as colorsValues;
import 'package:dealmart/utils/navigator.dart';
import 'package:dealmart/utils/size_config.dart';
import 'package:dealmart/utils/static_ui.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:toast/toast.dart';

class WalletScreen extends StatefulWidget {
  @override
  _WalletScreenState createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _amountFocusNode = FocusNode();
  TextEditingController amount_controller = TextEditingController();
  TransactionsModel transactionsModel;
  List<TransactionData> TransactionDataList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getTransaction();
  }

  getTransaction() {
    Future.delayed(Duration(seconds: 1), () {
      UserInfo().getTransaction(_scaffoldKey).then((value) {
        transactionsModel = value;

        TransactionDataList = List();

        transactionsModel.success.data.forEach((element) {
          setState(() {
            TransactionDataList.add(element);
          });
        });
      });
    });
  }

  getUserData() {
    Future.delayed(Duration(seconds: 1), () {
      UserInfo().getUserInfo(_scaffoldKey).then((value) {
        print("user res = " + value.toString());
        getTransaction();
        setState(() {
          GlobalVars.userData = value.user;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorsValues.whiteColor,
        elevation: 0.0,
        centerTitle: true,
        title: Container(
          padding: EdgeInsets.only(right: 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                translator.translate("ًWallet"),
                style: TextStyle(
                    color: Color(0xff212221),
                    fontWeight: FontWeight.w700,
                    fontSize: 28.0),
              )
            ],
          ),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios,
            color: Color(0xff212221),
            size: 23,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                height: 118,
                margin: EdgeInsets.only(left: 16, right: 16),
                width: SizeConfig.safeBlockHorizontal * 100,
                decoration: BoxDecoration(
                    gradient: new LinearGradient(
                      colors: [
                        Color.fromRGBO(0, 159, 254, 1.0),
                        Color.fromRGBO(0, 44, 255, 1.0)
                      ],
                      stops: [0.0, 1.0],
                      begin: FractionalOffset.topCenter,
                      end: FractionalOffset.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(12)),
                child: Container(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        child: Text(
                  translator.translate("Wallet Balance"),
                          style: TextStyle(
                              color: colorsValues.whiteColor,
                              fontSize: 17,
                              fontWeight: FontWeight.w400),
                        ),
                        padding: EdgeInsets.only(left: 5),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        " ${GlobalVars.userData.wallet.currentBalance} ${GlobalVars.Currency}",
                        style: TextStyle(
                            color: colorsValues.whiteColor,
                            fontSize: 27,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 35,
              ),
              Container(
                height: 25,
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Text(
                  translator.translate("Top Up History"),
                  style: TextStyle(
                      fontSize: 16,
                      color: colorsValues.charcoal2,
                      fontWeight: FontWeight.w800),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              // favouriteItem.length == 0 || favouriteItem.isEmpty || favouriteItem.toString() == 'null'?
              // StaticUI().NoDataFoundWidget():
              // Center(child: Text('No favorite added'),):
              Container(
                // height: SizeConfig.screenHeight - 540,
                child: TransactionDataList == null
                    ? StaticUI().progressIndicatorWidget()
                    : TransactionDataList.length == 0
                        ? StaticUI().NoDataFoundWidget()
                        : ListView.builder(
                            primary: true,
                            physics: ScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: TransactionDataList.length,
                            itemBuilder: (buildContext, index) {
                              return Container(
                                padding: EdgeInsets.only(
                                    left: 16, right: 16, top: 16, bottom: 16),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          translator.translate("Balance Top up"),
                                          style: TextStyle(
                                              color: colorsValues.brownishGrey4,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Text(
                                          GeneralApi(context). getDiffrenceTime(TransactionDataList[index].createdAt),
                                          style: TextStyle(
                                              color: colorsValues.brownishGrey4,
                                              fontSize: 15),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "${TransactionDataList[index].amount??""} ${GlobalVars.Currency}",
                                          style: TextStyle(
                                              color:
                                                  colorsValues.dustyOrangeTwo,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Text(
                                          "${TransactionDataList[index].isDone==1?translator.translate("Completed"):translator.translate("Not completed")}",
                                          style: TextStyle(
                                              color: colorsValues.pinkishGrey,
                                              fontSize: 15),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            }),
              ),

              SizedBox(
                height: 25,
              ),
              Container(
                height: 20,
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Text(
                  translator.translate("Top Up your wallet"),
                  style: TextStyle(
                      fontSize: 17,
                      color: colorsValues.brownishGrey,
                      fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(
                height: 19,
              ),
              Container(
                height: 67,
                width: SizeConfig.safeBlockHorizontal * 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  border: Border.all(
                      color: colorsValues.greyWalletBorder, width: 1),
                ),
                margin: EdgeInsets.only(left: 16, right: 16),
                child: Container(
                  margin: EdgeInsets.only(left: 15, right: 15, top: 8),
                  width: MediaQuery.of(context).size.width,
                  child: TextField(
                    controller: amount_controller,
                    focusNode: _amountFocusNode,
                    inputFormatters: [
                      DecimalTextInputFormatter(decimalRange: 2)
                    ],
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    decoration: new InputDecoration(
                        hintStyle: TextStyle(color: colorsValues.pinkishGrey),
                        counterText: '',
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        contentPadding: EdgeInsets.only(
                            left: 15, bottom: 11, top: 11, right: 15),
                        hintText:
                        translator.translate('Amount') + ' ' + "( " + GlobalVars.Currency + ' )'),
                    style: TextStyle(color: colorsValues.black),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),

              SizedBox(
                height: 19,
              ),

              GestureDetector(
                onTap: () {
                  if (amount_controller.text.isEmpty) {
                    Toast.show("please enter amount", context,
                        backgroundColor: Colors.red, duration: 4);
                  } else {
                    Navigator.push(
                        context,
                        CustomScalePageRoute(
                          builder: (context) => PaymentScreen(
                            totalPrice:
                                double.parse(amount_controller.text.trim()),
                            isWallet: true,
                          ),
                        )).then((value) {
                      getUserData();
                    });
                  }
                },
                child: Container(
                  margin: EdgeInsets.only(left: 16, right: 16),
                  width: MediaQuery.of(context).size.width,
                  height: 67,
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
                          translator.translate('Top Up'),
                    style: TextStyle(
                        color: WHITE,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  )),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [],
      ),
    );
  }
}
