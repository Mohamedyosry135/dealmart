import 'dart:async';
import 'dart:ui';
// import 'dart:html';
 // ignore: avoid_web_libraries_in_flutter
 import 'package:dealmart/base/BaseStatefullWidget.dart';
import 'package:dealmart/resources/AppColors.dart';
import 'package:dealmart/ui/MainScreens/CartScreen/FailCheckOut.dart';
import 'package:dealmart/ui/MainScreens/CartScreen/PaymentScreen.dart';
import 'package:dealmart/ui/MainScreens/CartScreen/SuccessCheckOut.dart';
import 'package:dealmart/ui/MainScreens/CartScreen/WebviewScreen.dart';
import 'package:dealmart/ui/MainScreens/DrawerWidget/MyAddress/MyAddress.dart';
import 'package:dealmart/utils/bottomSheet.dart';
import 'package:dealmart/utils/global_vars.dart';
import 'package:dealmart/utils/navigator.dart';
import 'package:dealmart/utils/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dealmart/utils/colors_file.dart' as colors;
import 'package:dealmart/utils/image_file.dart' as images;
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:toast/toast.dart';
import '../MainScreen.dart';
import 'bloc/CartBloc.dart';
import 'model/CartResponseModel.dart';

class CheckoutScreen extends BaseStatefulWidget {
  List<SuccessCart> products;
  CheckoutScreen(this.products);

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends BaseState<CheckoutScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  TextEditingController _promoController = TextEditingController();
  double totalPrice = 0.0;
  bool promoValid = false;
  String promocode = "";




  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTotal();
  }

  getTotal() {
    for (int i = 0; i < widget.products.length; i++) {
      setState(() {
        totalPrice += (double.parse(widget.products[i].product.price) *
            widget.products[i].amount);
      });
    }
  }


  @override
  Widget getAppbar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0.0,
      centerTitle: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
      translator.translate("Checkout"),
            style: TextStyle(
                color: Color(0xff212221),
                fontWeight: FontWeight.w600,
                fontSize: 22.0),
          )
        ],
      ),
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: Icon(
          Icons.arrow_back_ios,
          color: Color(0xff212221),
          size: 20,
        ),
      ),
    );
  }

  @override
  Widget getBody(BuildContext context) {


    // TODO: implement getBody
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        floatingActionButton:  floatButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

        body: SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 38.0,
                ),
                shoppingAddress(),

                SizedBox(
                  height: 50.0,
                ),
                cartItems(),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  margin: EdgeInsets.only(left: 20.0, right: 20.0),
                  color: Color(0xff020202),
                  height: 1.0,
                  width: MediaQuery.of(context).size.width,
                ),
                SizedBox(
                  height: 25.0,
                ),
                messageToSeller(),
                SizedBox(
                  height: 59.0,
                ),
                promoCode(),
                SizedBox(
                  height: MediaQuery.of(context).size.height/7,
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget shoppingAddress() {
    return Container(
      padding: EdgeInsets.only(left: 20.0, right: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: Text(
                    translator.translate("Shopping address"),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                        color: Color(0xff020202)),
                  ),
                ),
                InkWell(
                  onTap: () async{

                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyAddress(
                          fromCheckOut: true,
                        ),
                      ),
                    ).then((value) {
                      setState(() {
                        GlobalVars.defaultAddress.address=value;

                      });
                     });

                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        border: Border.all(
                            color: Colors.grey.withOpacity(.5), width: 1)),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Color(0xfffb8903),
                      size: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 13.0,
          ),
          Container(
            margin: EdgeInsets.only(left: 10.0, right: 10.0),
            child: Text(
              GlobalVars.defaultAddress.address.toString() == 'null'
                  ? "No Address Added"
                  : "${GlobalVars.defaultAddress.address}",
              style: TextStyle(
                  color: Color(0xff020202),
                  fontSize: 17,
                  // fontWeight: FontWeight.w400,
                  height: 1.8),
            ),
          ),
        ],
      ),
    );
  }



  Widget messageToSeller() {
    return Container(
      padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: Text(
                    translator.translate("Optional*"),
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 17.0,
                        color: Color(0xff020202)),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 25.0,
          ),
          Container(
            padding: EdgeInsets.only(bottom: 0.0),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: colors.borderGray, width: 2.0))),
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: translator.translate("Message to seller..."),
                hintStyle: TextStyle(
                    color: Color(0xff020202),
                    fontSize: 17,
                    fontWeight: FontWeight.w300),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget promoCode() {
    return Container(
      padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: Text(
                    translator.translate("PromoCode"),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                        color: Color(0xff020202)),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 34.0,
          ),
          Container(
            padding: EdgeInsets.only(bottom: 0.0),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: colors.borderColor, width: 2.0))),
            child: TextField(
              controller: _promoController,
              decoration: InputDecoration(
                suffixIcon: promoValid
                    ? Icon(Icons.check, color: Colors.orange, size: 30)
                    : Icon(Icons.check, color: Colors.orange, size: 0),
                prefixIcon: InkWell(
                  onTap: promoValid
                      ? null
                      : () {
                          showLoadingDialog();
                          CartBloc()
                              .checkPromo(_scaffoldKey, _promoController.text)
                              .then((value) {
                            hideDialog();
                            if (value == "error") {
                              Toast.show("PromoCode is not valid", context,
                                  backgroundColor: Colors.red);
                            } else {
                              setState(() {
                                promoValid = true;
                                promocode = _promoController.text;
                                totalPrice =
                                    (double.parse(value) - totalPrice).abs();
                              });
                            }
                          });
                        },
                  child: Icon(
                    Icons.add_circle_outline,
                    size: 25,
                  ),
                ),
                border: InputBorder.none,
                hintText: translator.translate("Add promo code..."),
                hintStyle: TextStyle(
                    color: Color(0xff020202),
                    fontSize: 17,
                    fontWeight: FontWeight.w300),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget cartItems() {
    return Container(
      padding: EdgeInsets.only(left: 20.0, right: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: Text(
                    translator.translate("Items"),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                        color: Color(0xff020202)),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 23.0,
          ),
          ListView.builder(
              primary: true,
              physics: ScrollPhysics(),
              shrinkWrap: true,
              itemCount: widget.products.length,
              itemBuilder: (buildContext, index) {
                return Container(
                  margin: EdgeInsets.only(bottom: 30),
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FadeInImage.assetNetwork(
                                placeholder: images.car,
                                image:
                                    "https://dealmart.herokuapp.com/products/${widget.products[index].product.id}/${widget.products[index].product.numberPhotos}.jpg",
                                width: SizeConfig.safeBlockVertical * 11,
                                height: SizeConfig.safeBlockVertical * 11,
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(left: 7.0, right: 7.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.products[index].product.name,
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xff020202)),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    widget.products[index].product.description ,
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300,
                                        color: Color(0xff020202),
                                        height: 1.5),
                                  ),
                                  SizedBox(
                                    height: 12.0,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "${widget.products[index].product.price}",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xff020202)),
                                      ),
                                      SizedBox(
                                        width: 5.0,
                                      ),
                                      Text(
                                        translator.translate("EPG"),
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Color(0xff020202)),
                                      )
                                    ],
                                  ),
                                  // SizedBox(height: 6.0,),
                                  // Row(
                                  //   children: [
                                  //     Text(
                                  //       "Amount :",
                                  //       style: TextStyle(
                                  //           fontSize: 16,
                                  //           fontWeight: FontWeight.w600,
                                  //           color: colors.blackColor
                                  //       ),
                                  //     ),
                                  //     SizedBox(width: 5.0,),
                                  //     Text(
                                  //       "${widget.products[index].amount}",
                                  //       style: TextStyle(
                                  //           fontSize: 16,
                                  //           fontWeight: FontWeight.w400,
                                  //           color: Color(0xff676767)
                                  //       ),
                                  //     )
                                  //   ],
                                  // ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                  ),
                );
              }),
        ],
      ),
    );
  }

  Widget floatButton() {
    return Row(
      children: [
        Container(
            color: colors.whiteColor,
            height: SizeConfig.safeBlockVertical * 9,
            width: SizeConfig.safeBlockHorizontal * 50,
            child: FlatButton(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    translator.translate("Total"),
                    style: TextStyle(
                        fontSize: 14, color: Color(0xff020202), height: 1.5),
                    textAlign: TextAlign.center,
                  ),
                  Row( crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${totalPrice}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,fontSize: 16, color: Color(0xff020202), height: 1.5),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(width: 5,),
                      Text(
                        "${ GlobalVars.Currency}",
                        // "${ GlobalVars.Currency}",
                        style: TextStyle(fontWeight: FontWeight.w400,
                            fontSize: 14, color: Color(0xff020202), height: 1.5),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ],
              ),
              onPressed: () {},
            )),
        Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(17)),
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [colors.azure, colors.vibrantBlue])),
            height: SizeConfig.safeBlockVertical * 9,
            width: SizeConfig.safeBlockHorizontal * 50,
            child: FlatButton(
              child: Text(
                translator.translate("Pay"),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: colors.whiteColor),
                textAlign: TextAlign.center,
              ),
              onPressed: () {
                if (GlobalVars.defaultAddress.address.toString() == 'null') {
                  Toast.show("Please Choose Address", context,
                      duration: Toast.LENGTH_SHORT,
                      gravity: Toast.BOTTOM,
                      backgroundColor: Colors.red);
                } else {

                  navigateAndKeepStack(context, PaymentScreen(isWallet: false,totalPrice: totalPrice,));
                }
              },
            )),
      ],
    );
  }
}
