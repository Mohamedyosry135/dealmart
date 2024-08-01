import 'package:dealmart/ui/MainScreens/CartScreen/bloc/CartBloc.dart';
import 'package:dealmart/ui/MainScreens/DrawerWidget/OrderScreen/bloc/OrderBloc.dart';
import 'package:dealmart/ui/MainScreens/DrawerWidget/OrderScreen/model/OrderModel.dart';
import 'package:flutter/material.dart';

import 'dart:async';
import 'package:dealmart/base/BaseStatefullWidget.dart';
import 'package:dealmart/ui/MainScreens/MainScreen.dart';
import 'package:dealmart/ui/MyFavouritesScreens/bloc/GetFavourite.dart';
import 'package:dealmart/ui/MyFavouritesScreens/model/FavouriteModel.dart';
import 'package:dealmart/utils/navigator.dart';
import 'package:dealmart/utils/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dealmart/utils/colors_file.dart' as colorsValues;
import 'package:dealmart/utils/image_file.dart' as images;
import 'package:dealmart/utils/static_ui.dart' ;
import 'package:dealmart/utils/global_vars.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
class OrderScreen extends BaseStatefulWidget {
  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends BaseState<OrderScreen> {
  var name = "name";
  var details = "details details detailsdetails details details details details details detailsdetailsdetailsdetailsdetailsdetailsdetails";
  var price = "100"+" ${ GlobalVars.Currency}";
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  OrderModel orderModel;
  List<Order> orders = List();

  bool ongoingSelected = true;
  bool canceledSelected = false;
  bool finishedSelected = false;
  Future<bool> closeApp(){
    StaticUI().closeApp(context);
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                translator.translate("My"),
                style: TextStyle(
                    color: Color(0xff212221),
                    fontWeight: FontWeight.normal,
                    fontSize: 25
                ),
              ),
              SizedBox(width: 3.0,),
              Text(
                translator.translate("Orders"),
                style: TextStyle(
                    color: Color(0xff212221),
                    fontWeight: FontWeight.w800,
                    fontSize: 25.0
                ),
              )
            ],
          ),
        ),
      ),
      leading: IconButton(
        onPressed: (){
          navigateAndClearStack(context,  MainScreen(position: 2,));

        },
        icon: Icon(Icons.arrow_back_ios,color: Color(0xff212221),size: 23,),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(milliseconds: 200), () {
      getOrders("0") ;
    });


  }
  getOrders(String statue){
    showLoadingDialog();
    OrderBloc().getOrders(_scaffoldKey,"${statue}").then((value){
      hideDialog();
      orders = List();
      setState(() {
        orderModel = value;
        orderModel.orders.forEach((element) {
          orders.add(element);
        });
      });
    });
  }

  @override
  Widget getBody(BuildContext context) {
    SizeConfig().init(context);
    return WillPopScope(
      onWillPop: closeApp,

      child: SafeArea(child: SingleChildScrollView(
        child: Container(
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 10.0,),
              Container(
                height: 45,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                     borderRadius: BorderRadius.all(Radius.circular(18.0)),
                    border: Border.all(color: Colors.grey.withOpacity(.5))
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 3,
                      child: InkWell(
                        onTap: (){
                          setState(() {
                            ongoingSelected = true;
                            finishedSelected = false;
                            canceledSelected = false;
                            getOrders("0");
                          });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 60,
                          decoration: BoxDecoration(
                              gradient: ongoingSelected
                                  ? LinearGradient(
                                colors: [
                                  colorsValues.lightOrange,
                                  colorsValues.dustyOrange
                                ],
                                begin: FractionalOffset.center,
                                end: FractionalOffset.bottomCenter,
                              )
                                  : LinearGradient(begin: Alignment.topCenter,end: Alignment.bottomCenter, colors:[Colors.white, Colors.white]),
                              borderRadius: BorderRadius.all(Radius.circular(17.0)),
                              border: Border.all(color: Colors.transparent)
                          ),
                          child: Text(
                            translator.translate("Ongoing"),
                            style: TextStyle(
                              color: ongoingSelected? Colors.white:Colors.grey,
                              fontWeight: ongoingSelected? FontWeight.w700:FontWeight.w400,
                              fontSize: ongoingSelected? 17:15,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: InkWell(
                        onTap: (){
                          setState(() {
                            ongoingSelected = false;
                            finishedSelected = false;
                            canceledSelected = true;
                            getOrders("-1");
                          });
                        },
                        child: Container(
                          height: 60,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              gradient: canceledSelected
                                  ? LinearGradient(
                                colors: [
                                  colorsValues.lightOrange,
                                  colorsValues.dustyOrange
                                ],
                                begin: FractionalOffset.center,
                                end: FractionalOffset.bottomCenter,
                              )
                                  : LinearGradient(begin: Alignment.topCenter,end: Alignment.bottomCenter, colors:[Colors.white, Colors.white]),
                              borderRadius: BorderRadius.all(Radius.circular(17.0)),
                              border: Border.all(color: Colors.transparent)
                          ),
                          child: Text(
                            translator.translate("Canceled"),
                            style: TextStyle(
                              color: canceledSelected? Colors.white:Colors.grey,
                              fontWeight: canceledSelected? FontWeight.w700:FontWeight.w400,
                              fontSize: canceledSelected? 17:15,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: InkWell(
                        onTap: (){
                          setState(() {
                            ongoingSelected = false;
                            finishedSelected = true;
                            canceledSelected = false;
                            getOrders("1");
                          });
                        },
                        child: Container(
                          height: 60,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              gradient: finishedSelected
                                  ? LinearGradient(
                                colors: [
                                  colorsValues.lightOrange,
                                  colorsValues.dustyOrange
                                ],
                                begin: FractionalOffset.center,
                                end: FractionalOffset.bottomCenter,
                              )
                                  : LinearGradient(begin: Alignment.topCenter,end: Alignment.bottomCenter, colors:[Colors.white, Colors.white]),
                              borderRadius: BorderRadius.all(Radius.circular(17.0)),
                              border: Border.all(color: Colors.transparent)
                          ),
                          child: Text(
                            translator.translate("Finished"),
                            style: TextStyle(
                              color: finishedSelected? Colors.white:Colors.grey,
                              fontWeight: finishedSelected? FontWeight.w700:FontWeight.w400,
                              fontSize: finishedSelected? 17:15,
                            ),
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
              orders.length == 0 || orders.isEmpty || orders.toString() == 'null'
              ? StaticUI().NoDataFoundWidget()
              // ? Container(alignment: Alignment.center,margin: EdgeInsets.only(top: 40.0),child: Text('No Orders',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),)
              : Container(
                child: Column(
                  children: [

                    SizedBox(height: 18.0,),
                     ListView.builder(
                        primary: true,
                        physics: ScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: orders.length,
                        itemBuilder: (buildContext, index){
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 40),
                            child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),),
                              child: Stack(children: [

                                ClipRRect(
                                  borderRadius:BorderRadius.circular(10),
                                  child: Container(
                                    child: Slidable(
                                        actionPane: SlidableDrawerActionPane(),
                                        actionExtentRatio: 0.22,
                                        child: Stack(children: [
                                          Positioned(top: 0,left: 0,bottom: 0,child: Container(width: 20,color: colorsValues.tomato,)),
                                          Positioned(top: 0,right: 0,bottom: 0,child: Container(width: 20,color: colorsValues.apple,)),

                                          Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: colorsValues.whiteColor),
                                            child: Container(
                                              padding: EdgeInsets.only(left: 15,top: 5,right: 5,bottom: 0),
                                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),border: Border.all(color: colorsValues.greyBorder.withOpacity(.2)),color: colorsValues.greyBorder.withOpacity(.4)),
                                              child: Column(
                                                children: [
                                                  Container(padding: EdgeInsets.only(top: 0,right: 8),
                                                    child: Align(alignment: Alignment.topRight,
                                                      child: InkWell(
                                                        child: IconButton(
                                                          icon:  orders[index].product.isFavourit == 1 ? Icon(
                                                            Icons.favorite,
                                                            color: colorsValues.orangeColor,
                                                            size: 25,
                                                          ) : Icon(
                                                            FontAwesome.heart_o,
                                                            color:Color.fromRGBO(
                                                                249, 115, 2, 1),
                                                            size: 25,
                                                          ),
                                                          onPressed: orders[index].product.isFavourit == 1 ? (){
                                                            print("remove to fav");

                                                            showLoadingDialog();
                                                            GetFavouritesBloc().removeFromFavourites(_scaffoldKey,orders[index].product.id.toString()).then((value){
                                                              hideDialog();
                                                              setState(() {
                                                                orders[index].product.isFavourit = orders[index].product.isFavourit == 1 ? 0 : 1;
                                                              });
                                                            });
                                                          }:() {
                                                            print("add to fav");
                                                            showLoadingDialog();
                                                            GetFavouritesBloc().addFavourites(_scaffoldKey,orders[index].product.id).then((value){
                                                              hideDialog();
                                                              setState(() {
                                                                orders[index].product.isFavourit = orders[index].product.isFavourit == 1 ? 0 : 1;
                                                              });
                                                            });
                                                          },
                                                          iconSize: 25,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      Expanded(
                                                        flex: 2,
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            ClipRRect(borderRadius: BorderRadius.circular(12),
                                                              child: FadeInImage.assetNetwork(fit: BoxFit.fill,
                                                                placeholder: images.car,
                                                                image: "https://dealmart.herokuapp.com/products/${orders[index].product.id}/${orders[index].product.numberPhotos}.jpg",
                                                                width: SizeConfig.safeBlockVertical * 14,
                                                                height: SizeConfig.safeBlockVertical * 13,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 3,
                                                        child: Container(
                                                          margin: EdgeInsets.only(left: 0,right: 4),
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: [
                                                              Text(
                                                                orders[index].product.name,
                                                                style: TextStyle(
                                                                    fontSize: 18,
                                                                    fontWeight: FontWeight.w700
                                                                ),

                                                              ),
                                                              Text(
                                                                orders[index].product.description,
                                                                style: TextStyle(
                                                                    fontSize: 13,
                                                                    fontWeight: FontWeight.w300,
                                                                    color: colorsValues.black,height: 1.5
                                                                ),
                                                              ),
                                                              SizedBox(height: 6.0,),
                                                              Row(
                                                                children: [
                                                                  Text(
                                                                    "${orders[index].product.price}",
                                                                    style: TextStyle(
                                                                        fontSize: 16,
                                                                        fontWeight: FontWeight.w600,
                                                                        color: colorsValues.blackColor
                                                                    ),
                                                                  ),
                                                                  SizedBox(width: 5.0,),
                                                                  Text(
                                                                    translator.translate("EPG"),
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

                                                    ],),
                                                  SizedBox(height:16,),




                                                ],crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.start,),),
                                          ),
                                        ],)
        ,

                                        actions: <Widget>[
                                          IconSlideAction(
                                            onTap: (){
                                              showLoadingDialog();
                                              GetFavouritesBloc().removeOrder(_scaffoldKey, orders[index].id.toString()).then((value){
                                                hideDialog();
                                                setState(() {
//                                    GlobalVars.favIds.removeAt(GlobalVars.favIds.indexOf(favouriteItem[index].productId.toString()));
                                                });
                                                navigateAndClearStack(context, MainScreen(position: 0,));
                                              });
                                            },
                                            caption: 'delete',
                                            foregroundColor: colorsValues.whiteColor,
                                            color: colorsValues.tomato,
                                            iconWidget: Container(padding: EdgeInsets.only(bottom: 5),child: Icon(Icons.delete_outline,color: colorsValues.whiteColor,size: 35,)) ,
                                          ),
                                        ],
                                        secondaryActions: <Widget>[
                                          IconSlideAction(
                                            onTap: orders[index].amount == 0.0
                                                ? null:(){
                                              showLoadingDialog();
                                              CartBloc().addToCart(_scaffoldKey,orders[index].id,1).then((value){
                                                hideDialog();
                                                navigateAndKeepStack(context, MainScreen(position: 3,));
                                                //   showSnack('Added successfully');
                                              });
                                            },
                                            caption: 'Reorder',
                                            color: colorsValues.apple,
                                            foregroundColor: colorsValues.whiteColor,
                                            iconWidget: Container(padding: EdgeInsets.only(bottom: 5),child: Icon(Icons.refresh,color: colorsValues.whiteColor,)) ,
                                          ),
                                        ]
                                    ),
                                  ),
                                )
                              ],),
                            ),
                          );

                        })
                  ],
                ),
              ),
            ],) ,padding: EdgeInsets.only(left: 16,right: 16,top: 10,bottom: 30),),
      ),),
    );
  }
}
