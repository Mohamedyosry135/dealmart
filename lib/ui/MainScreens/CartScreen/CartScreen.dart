import 'dart:async';

import 'package:dealmart/base/BaseStatefullWidget.dart';
import 'package:dealmart/ui/MainScreens/CartScreen/bloc/CartBloc.dart';
import 'package:dealmart/ui/MainScreens/CartScreen/checkout_screen.dart';
import 'package:dealmart/ui/MainScreens/MainScreen.dart';
import 'package:dealmart/ui/MainScreens/ProductsScreen/model/ProductModel.dart';
import 'package:dealmart/utils/global_vars.dart';
import 'package:dealmart/utils/navigator.dart';
import 'package:dealmart/utils/size_config.dart';
import 'package:dealmart/utils/staticVar.dart';
import 'package:flutter/material.dart';
import 'package:dealmart/utils/colors_file.dart' as colors;
import 'package:dealmart/utils/image_file.dart' as images;
import 'package:dealmart/utils/shared_utils.dart' as shared;
import 'package:dealmart/utils/static_ui.dart';
import 'package:flutter/services.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:toast/toast.dart';

import 'model/CartResponseModel.dart';

class CartScreen extends BaseStatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends BaseState<CartScreen> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  List<SuccessCart> products = List();
  List<SuccessCart> selectedProducts = List();
  List productsIndex= List();
  List selectedProductsIndex= List();
  CartResponseModel cartResponseModel;
  List<int> productQuantity = List();
  int totalPrice = 0;
  var map = Map();
  @override
  Widget getAppbar() {
    // TODO: implement getAppbar
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0.0,
      centerTitle: true,
      title: Container(
        padding: EdgeInsets.only(right: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              translator.translate("My"),
              style: TextStyle(
                  color: Color(0xff212221),
                  fontWeight: FontWeight.w400,
                  fontSize: 21
              ),
            ),
            SizedBox(width: 5.0,),
            Text(
              translator.translate("Cart"),
              style: TextStyle(
                  color: Color(0xff212221),
                  fontWeight: FontWeight.w700,
                  fontSize: 24
              ),
            )
          ],
        ),
      ),
      leading: IconButton(

        onPressed: ()=> closeApp(),
        icon: Icon(Icons.arrow_back_ios,color: Color(0xff212221),size: 23,),
      ),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(milliseconds: 200), () {
      showLoadingDialog();
      getCart();

    });
  }
  List productsId = List();
  bool checked = false;
  int counter = 0;
  int index = 0;
  getCart(){
    CartBloc().getCarts(_scaffoldKey).then((value){
      hideDialog();
      setState(() {
        cartResponseModel = value;
        cartResponseModel.success.forEach((element) {
          products.add(element);
          productsId.add(element.productId);
        });
        productsId = productsId.toSet().toList();
        print("productsId ${productsId}");
        print("productsId ${products.length}");
         for(int i=0;i<productsId.length;i++){
           print("hhhhhh${checked}");
           counter = 0;
           for(int j=0;j<products.length;j++){

             if(productsId[i] == products[j].productId){
               print("hhhhhh1${checked}");
               if(checked){
                  productsIndex.add(j);
                 counter+= products[j].amount;
                }else{
                 selectedProductsIndex.add(j);
                  counter+=products[j].amount;
                  checked = true;
                  index = j;
               }
             }

           }
           print("counter ${counter}");
           products[index].amount = counter;
           totalPrice += (int.parse(products[index].product.price) * counter);
           checked = false;
         }
        print("productsIndex ${productsIndex}");
        print("productsIndex ${products.length}");
        GlobalVars.cartLength = "${products.length}";
        shared.setCartLength("${products.length}");
        for(int i=0;i<products.length;i++){
          productQuantity.add(products[i].amount);
//          totalPrice += (int.parse(products[i].product.price) * products[i].amount);
        }
      });
    });
  }
  Future<bool> closeApp(){
    StaticUI().closeApp(context);
  }
  checkAvailability(){
    showDialog(
        context: context,
        builder: (context)=>AlertDialog(
          elevation: 10.0,
          backgroundColor: Colors.white,
          titlePadding: EdgeInsets.all(10.0),
          title: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    child: Text(translator.translate("out of quantity"),style: TextStyle(fontSize: 25,color: Colors.black,fontWeight: FontWeight.w700),)
                ),
                SizedBox(height: 35.0,),
                Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap:(){
                          Navigator.pop(context);
                        },
                        child: Text(
                          translator.translate("Ok"),
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                              color: Colors.black
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
  @override
  Widget getBody(BuildContext context) {
    // TODO: implement getBody
    SizeConfig().init(context);
    return SafeArea(child: SingleChildScrollView(
      child: WillPopScope(
        onWillPop: closeApp,
        child: Container(child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ( products==null || products.length==0)? StaticUI().NoDataFoundWidget():
            // ( products==null || products.length==0)? Center(child: Text('No cart added'),):
            ListView.builder(
                primary: true,
                physics: ScrollPhysics(),
                shrinkWrap: true,
                itemCount: products.length,
                itemBuilder: (buildContext, index) {
                  return productQuantity[index] == 0? Container():
                  productsIndex.contains(index)? Container():Container(
                    margin: EdgeInsets.only(bottom: 30),
                    padding: EdgeInsets.only(left: 16,top: 8,right: 8,bottom: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Color(0xffe3e3e3))),
                    child: Column(
                      children: [
                        Container(
                          child: Align(alignment: Alignment.topRight,
                            child: InkWell(
                              child: Icon(
                                Icons.clear, color: colors.blackColor,size: 20,),
                              onTap: () {
                                showLoadingDialog();
                                CartBloc().removeFromCarts(_scaffoldKey, products[index].productId.toString()).then((value){
                                  hideDialog();
                                  navigateAndClearStack(context, MainScreen(position: 3,));
                                });
                              },
                            ),
                          ),
                        ),
                      SizedBox(height: 2,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(borderRadius:BorderRadius.circular(10),
                                  child: FadeInImage.assetNetwork(
                                      placeholder: images.car,
                                      image: "https://dealmart.herokuapp.com/products/${products[index].product.id}/${products[index].product.numberPhotos}.jpg",
                                    width: SizeConfig.safeBlockVertical * 11,
                                    height: SizeConfig.safeBlockVertical * 11,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                        onTap: () {
                                          print("ClickHere");
                                          setState(() {
                                            if(products[index].amount > 0){
//                                              productQuantity[index] -= 1;
//                                              totalPrice -= int.parse(products[index].product.price);
                                              showLoadingDialog();
                                              CartBloc().editCartsAmount(_scaffoldKey, products[index].productId.toString(),"${products[index].amount - 1}").then((value){
                                                hideDialog();
                                                navigateAndClearStack(context, MainScreen(position: 3,));
                                              });
                                            }
                                          });
                                        },
                                        child: Container(
  //                            padding: EdgeInsets.all(4),
                                          alignment: Alignment.center,
                                          child: Text("-",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 25),),
                                          width: 29,
                                          height: 29,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(29),
                                            color: colors.brownishGrey2,),)),
                                    SizedBox(width: 4,),
                                    GestureDetector(
                                        onTap: () {

                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(4),
                                          child: Center(child: Text("${products[index].amount}", style: TextStyle(
                                              fontWeight: FontWeight.bold, fontSize: 14),)),
                                          width: 29,
                                          height: 29,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(29),),)),
                                    SizedBox(width: 4,),
                                    GestureDetector(
                                        onTap: () {
                                          setState(() {
//                                            productQuantity[index] += 1;
//                                            totalPrice += int.parse(products[index].product.price);
                                            print("productQuantity ${products[index].amount}");
                                            print("productQuantity ${products[index].productId}");
                                            print("productQuantity ${products[index].product.amount}");
                                            if(products[index].amount + 1 < products[index].product.amount){
                                              showLoadingDialog();
                                              CartBloc().editCartsAmount(_scaffoldKey, products[index].productId.toString(),"${products[index].amount + 1}").then((value){
                                                hideDialog();
                                                navigateAndClearStack(context, MainScreen(position: 3,));
                                              });
                                            }else{
                                              checkAvailability();
                                            }
                                          });
                                        },
                                        child: Container(
  //                            padding: EdgeInsets.all(4),
                                          alignment: Alignment.center,
                                          child: Text("+",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 23),),
                                          width: 29,
                                          height: 29,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(29),
                                            color: colors.brownishGrey2,),))
                                  ],),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: Container(
                              margin: EdgeInsets.only(left: 0,right: 7.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    products[index].product.name,
                                    style: TextStyle(
                                        fontSize: 19,
                                        fontWeight: FontWeight.w700
                                    ),

                                  ),
                                  SizedBox(height: 6,),
                                  Text(
                                    products[index].product.description,
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xff676767)
                                    ),
                                  ),
                                  SizedBox(height: 6.0,),
                                  Row(
                                    children: [
                                      Text(
                                        "${products[index].product.price}",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            color: colors.blackColor
                                        ),
                                      ),
                                      SizedBox(width: 5.0,),
                                      Text(
                                     "${GlobalVars.Currency}",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xff676767)
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),

                        ],
                      ),



                    ],
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,),);
                }),




            ( products==null || products.length==0)? Container():ClipRRect(borderRadius: BorderRadius.circular(25),
              child: Container(
                margin: EdgeInsets.only(bottom: 30),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: colors.greyBorder)),
                child: Column(children: [

                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(translator.translate("Taxes"), style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.normal,color: Color(0xff232520)),),
                        Text("${GlobalVars.order_fees_amount} ${ GlobalVars.Currency}", style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600,color: Color(0xff212221)),),
                      ],),
                  ),

                  Divider(height: 2, color: colors.greyBorder,),

                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(translator.translate("Shipping Fees"), style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.normal,color: Color(0xff232520)),),
                        Text("${GlobalVars.recharge_fees_amount} ${ GlobalVars.Currency}", style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600,color: Color(0xff212221)),),
                      ],),
                  ),


                  Container(height: 68,decoration: BoxDecoration(color: colors.charcoal,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(25),
                          bottomRight: Radius.circular(25))),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(translator.translate("Total price"), style: TextStyle(fontSize: 16,
                              fontWeight: FontWeight.w300,
                              color: Color(0xffffffff)),),
                          Text("${totalPrice} ${ GlobalVars.Currency}", style: TextStyle(fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xffffffff)),),
                        ],),
                    ),
                  ),


                ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,),),
            ),
            SizedBox(height: 30,),

          ],),
          padding: EdgeInsets.only(left: 16, right: 16, top: 30, bottom: 30),),
      ),
    ),);
  }

  @override
  FloatingActionButtonLocation floatingActionButtonLocation() {
    // TODO: implement floatingActionButtonLocation
    return FloatingActionButtonLocation.centerDocked;
  }

    @override
  Widget floatingActionButton() {
      SizeConfig().init(context);
    return products.length==0?Container():Row(children: [
      Container(
          height: 70,
          width: SizeConfig.safeBlockHorizontal * 50,
          child: FlatButton(
            shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.only(topRight: Radius.circular(17))),
            color: colors.white2,
            onPressed: () {},
            child: Column(
              children: [
                Padding(padding: EdgeInsets.only(top: 14.0)),
                Text(
                  translator.translate('Total '),
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ),
                Padding(padding: EdgeInsets.only(top: 6.0)),
                Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                  Text(
                    "${totalPrice}",
                    style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                        fontWeight: FontWeight.w800),
                  ),
                  SizedBox(width: 3,),
                  Text(
                    '${ GlobalVars.Currency}' ,
                    style: TextStyle(
                        fontSize: 16.0,
                        color: colors.brownishGrey,
                        fontWeight: FontWeight.w500),
                  ),
                ],

                )
              ],
            ),
          )),
      Container(
          decoration:BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(17)),
              gradient: LinearGradient(begin: Alignment.topCenter,end: Alignment.bottomCenter,
          colors: [colors.azure, colors.vibrantBlue])),height: 70,
          width: SizeConfig.safeBlockHorizontal*50,
          child: FlatButton(
            child: Text(
              translator.translate("Proceed to Checkout"),softWrap: true,
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: Color(0xfff8f8f8),
              ),
              textAlign: TextAlign.center,
            ),
            onPressed: (){
              selectedProducts = List();
              for(int i = 0;i<selectedProductsIndex.length;i++){
                setState(() {
                  if(products[selectedProductsIndex[i]].amount != 0){
                    selectedProducts.add(products[selectedProductsIndex[i]]);
                  }
                });
              }
              print("finalLength ${products.length}");
              print("finalLength ${selectedProducts.length}");
              productsList=selectedProducts;
              navigateAndKeepStack(context, CheckoutScreen(selectedProducts));
            },
          )),
    ],);
  }
}
