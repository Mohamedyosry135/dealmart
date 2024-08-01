import 'package:carousel_slider/carousel_slider.dart';
import 'package:dealmart/base/BaseStatefullWidget.dart';
import 'package:dealmart/ui/MainScreens/CartScreen/bloc/CartBloc.dart';
import 'package:dealmart/ui/MainScreens/MainScreen.dart';
import 'package:dealmart/ui/MainScreens/ProductsScreen/product_details/bloc/productDetailsBloc.dart';
import 'package:dealmart/ui/MainScreens/ProductsScreen/product_details/model/ProductDetailsModel.dart';
import 'package:dealmart/ui/MyFavouritesScreens/bloc/GetFavourite.dart';
import 'package:dealmart/utils/global_vars.dart';
import 'package:dealmart/utils/image_file.dart';
import 'package:dealmart/utils/navigator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dealmart/utils/size_config.dart';
import 'package:dealmart/utils/image_file.dart' as imagefile;
import 'package:dealmart/utils/colors_file.dart' as colorsfile;
import 'package:flutter_icons/flutter_icons.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:dealmart/utils/image_file.dart' as image_file;
import 'package:share/share.dart';
class ProductDetailsScreen extends BaseStatefulWidget {
  String productId;
  ProductDetailsScreen({this.productId});
  @override
  _State createState() => _State();
}

class _State extends BaseState<ProductDetailsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  ProductDetails _productDetails;
  GiftProduct _giftProduct;
  bool showBuyProduct = true ;
  bool showwinProduct = false ;
  @override
  Widget getAppbar() {
    // TODO: implement getAppbar
    return null;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("id ${widget.productId}");
    ProductDetailsBloc().productDetails(_scaffoldKey, widget.productId).then((value){
      setState(() {
        _productDetails = value.success;
        if (_productDetails.gift != null && _productDetails.gift.giftProduct != null ) {
        _giftProduct = _productDetails.gift.giftProduct;
        showwinProduct = true ;
        }
      });
    });
  }
  bool overviewTapped = true;
  bool specificationTapped = false;
  @override
  Widget getBody(BuildContext context) {
    SizeConfig().init(context);
    return Stack(
      children: [
        SingleChildScrollView(
          child: _productDetails.toString() == 'null'? Container(
            margin: EdgeInsets.only(top: 150.0),
            alignment: Alignment.center,
            child: CircularProgressIndicator(),
          ):Container(
            padding: EdgeInsets.only(
              top: SizeConfig.safeBlockVertical * 6,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.keyboard_arrow_left,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      iconSize: 40,
                    )
                  ],
                ),
                Padding(padding: EdgeInsets.only(top: 10)),
                Container(
                  padding: EdgeInsets.only(left: 19.0),
                  child: Row(
                    children: [
                      Text(
                        translator.translate('Buy'),
                        style: TextStyle(
                            fontSize: 22.0,
                            color: colorsfile.brownishGrey,
                            fontWeight: FontWeight.w500),
                      ),
                      Padding(padding: EdgeInsets.only(left: 16)),
                      Text(
                        '${_productDetails.name}',
                        style: TextStyle(
                            fontSize: 25,
                            color: colorsfile.blackColor,
                            fontWeight: FontWeight.w700),
                      ),
                      IconButton(
                        icon: Icon(
                          showBuyProduct == false ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          setState(() {
                            showBuyProduct = !showBuyProduct;
                          });

                        },
                        iconSize: 40,
                      )
                    ],
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 28)),
                showBuyProduct == false ? Container() : Container(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0),
                  child: Column(
                    children: [

                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(width: 16,),
                          IconButton(
                            icon: Icon(
                              Icons.share,
                              color: colorsfile.pumpkin_orange,
                            ),
                            onPressed: () {
                             // Share.share('');
                            },
                            iconSize: 24.8,
                          ),
                          Padding(padding: EdgeInsets.only(left: 0.0)),
                          IconButton(
                            icon:  _productDetails.isFavourit == 1 ? Icon(
    Icons.favorite,
    color: colorsfile.orangeColor,
    size: 25,
    ) : Icon(
    FontAwesome.heart_o,
    color:Color.fromRGBO(
    249, 115, 2, 1),
    size: 25,
    ),
                            onPressed: _productDetails.isFavourit == 1 ? (){
                              print("remove to fav");

    showLoadingDialog();
    GetFavouritesBloc().removeFromFavourites(_scaffoldKey,_productDetails.id.toString()).then((value){
    hideDialog();
    setState(() {
      _productDetails.isFavourit = _productDetails.isFavourit == 1 ? 0 : 1;
    });
    });
    }:() {
             print("add to fav");
                              showLoadingDialog();
                              GetFavouritesBloc().addFavourites(_scaffoldKey,_productDetails.id).then((value){
                                hideDialog();
                                setState(() {
                                  _productDetails.isFavourit = _productDetails.isFavourit == 1 ? 0 : 1;
                                });
                              });
                            },
                            iconSize: 25,
                          ),
                          SizedBox(width: 8,),
                        ],
                      ),
                      SizedBox(height: 20.0,),
                      Container(
                        alignment: Alignment.center,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(0.0),
                          child: FadeInImage.assetNetwork(
                            placeholder: image_file.car,
                            image: "https://dealmart.herokuapp.com/products/${_productDetails.id}/${_productDetails.id}.jpg",
                            fit: BoxFit.cover,
                          ),
                        ),
                        width: 260,
                        height: 250,
                      ),
                    ],
                  ),
                ),
                showBuyProduct == false ? Container() : Padding(padding: EdgeInsets.only(top: 20)),
                showBuyProduct == false ? Container() : Container(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0),
                  child: new LinearPercentIndicator(
                    width: SizeConfig.safeBlockHorizontal * 91,
                    lineHeight: 16.0,
                    percent: _productDetails.sold/(_productDetails.sold+_productDetails.amount),
                      progressColor:
                      _productDetails.amount == 0.0
                          ? colorsfile.whiteThree
                          : colorsfile.marigold,
                      backgroundColor:colorsfile.whiteThree

                  ),
                ),
                showBuyProduct == false ? Container() : Padding(padding: EdgeInsets.only(top: 22.0)),
                showBuyProduct == false ? Container() : Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${_productDetails.sold} /',
                        style: TextStyle(
                            fontSize: 26.0,
                            color: colorsfile.blackTwo,
                            fontWeight: FontWeight.w700),
                      ),
                      Text(
                        '${_productDetails.amount + _productDetails.sold} Sold',
                        style: TextStyle(
                            fontSize: 26.0,
                            color: colorsfile.blackTwo,
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
                showBuyProduct == false ? Container() : Padding(padding: EdgeInsets.only(top: 16.0)),
                showBuyProduct == false ? Container() : Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color: Color(0xfff8f8f8),),

                  margin: EdgeInsets.only(left: 16, right: 16.0,bottom: 15.0),
                  padding: EdgeInsets.only(left: 16, right: 16,bottom: 16,top: 16),
                  child: Column(
                    children: [
                      Stack(children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 6,right: 8,top: 26),
                          child: Divider(),
                        ),
                        Row(
                          children: [
                            FlatButton(
                              color: Colors.transparent,
                              padding: EdgeInsets.only(left: 16.0),
                              onPressed: () {
                                setState(() {
                                  overviewTapped = true;
                                  specificationTapped = false;
                                });
                              },
                              child: Column(
                                children: <Widget>[
                                  Text(
    translator.translate('Overview'),
                                    style: TextStyle(
                                        fontSize:  overviewTapped? 16 : 14,
                                        color: overviewTapped? colorsfile.brownishGrey : colorsfile.grey  ,
                                        fontWeight: overviewTapped? FontWeight.w800 :  FontWeight.w400,backgroundColor: Colors.transparent),
                                  ),
                                  Padding(padding: EdgeInsets.only(top: 3.0)),
                                  Container(
                                    height: SizeConfig.safeBlockVertical * 0.2,
                                    color: overviewTapped? colorsfile.brownishGrey : Colors.transparent,
                                    width: SizeConfig.safeBlockHorizontal * 18,
                                  )
                                ],
                              ),
                            ),
                            FlatButton(
                              padding: EdgeInsets.only(left: 22.0),
                              onPressed: () {
                                setState(() {
                                  overviewTapped = false;
                                  specificationTapped = true;
                                });
                              },
                              child: Column(
                                children: <Widget>[
                                  Text(
    translator.translate('Specifications'),
                                    style: TextStyle(
                                        fontSize: specificationTapped ? 16 : 14,
                                        color: specificationTapped ?colorsfile.brownishGrey: colorsfile.grey ,
                                        fontWeight: specificationTapped ? FontWeight.w800 :  FontWeight.w400),
                                  ),
                                  Padding(padding: EdgeInsets.only(top: 3.0)),
                                  Container(
                                    height: SizeConfig.safeBlockVertical * 0.2,
                                    color: specificationTapped ?colorsfile.brownishGrey: Colors.transparent,
                                    width: SizeConfig.safeBlockHorizontal * 23,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],),


                      Container(
                        padding: EdgeInsets.only(left: 8,right: 8,top: 16.0),
                        child: Text(
                          specificationTapped? "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd" :'${_productDetails.description}',
                          style: TextStyle(
                              fontSize: 15,
                              color: colorsfile.grey,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                    ],
                  ),
                ),

                Padding(padding: EdgeInsets.only(top: 10)),
                _giftProduct == null ? Container() : Container(
                  padding: EdgeInsets.only(left: 19.0),
                  child: Row(crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
    translator.translate('ًWin'),
                          style: TextStyle(
                              fontSize: 20.0,
                              color: colorsfile.brownishGrey,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(left: 16)),
                      Text(
                        '${_giftProduct.name}',
                        style: TextStyle(
                            fontSize: 25.0,
                            color: colorsfile.blackColor,
                            fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        icon: Icon(
                          showwinProduct == false ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          setState(() {
                            showwinProduct = !showwinProduct;
                          });

                        },
                        iconSize: 40,
                      )
                    ],
                  ),
                ),
                _giftProduct == null ? Container() : Padding(padding: EdgeInsets.only(top: 28)),
                showwinProduct == false ? Container() : Container(
                  padding: EdgeInsets.only(left: 25.0, right: 25.0),
                  child: Column(
                    children: [

                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.share,
                              color: colorsfile.pumpkin_orange,
                            ),
                            onPressed: () {

                            },
                            iconSize: 25,
                          ),
                          Padding(padding: EdgeInsets.only(left: 0.0)),
                          IconButton(
                            icon: _productDetails.isFavourit == 1 ? Icon(
    Icons.favorite,
    color:colorsfile.orangeColor,
    size: 25,
    ) : Icon(
    FontAwesome.heart_o,
    color: Color.fromRGBO(
    249, 115, 2, 1),
    size: 25,
    ),
                            onPressed: _productDetails.isFavourit == 1 ? (){

                              showLoadingDialog();
                              GetFavouritesBloc().removeFromFavourites(_scaffoldKey,_productDetails.id.toString()).then((value){
                                hideDialog();
                                setState(() {
                                  _productDetails.isFavourit = _productDetails.isFavourit == 1 ? 0 : 1;
                                });

                              });
                            }:() {
                              showLoadingDialog();
                              GetFavouritesBloc().addFavourites(_scaffoldKey,_giftProduct.id).then((value){
                                hideDialog();
                                setState(() {
                                  _productDetails.isFavourit = _productDetails.isFavourit == 1 ? 0 : 1;
                                });
                              });
                            },
                            iconSize: 25,
                          )
                        ],
                      ),
                      SizedBox(height: 20.0,),
                      Container(
                        alignment: Alignment.center,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(0.0),
                          child: FadeInImage.assetNetwork(
                            placeholder: image_file.car,
                            image: "https://dealmart.herokuapp.com/products/${_giftProduct.id}/${_giftProduct.id}.jpg",
                            fit: BoxFit.cover,
                          ),
                        ),
                        width: 260,
                        height: 250,
                      ),
                    ],
                  ),
                ),
                showwinProduct == false ? Container() : Padding(padding: EdgeInsets.only(top: 16.0)),
                showwinProduct == false ? Container() : Padding(padding: EdgeInsets.only(top: 16.0)),
                showwinProduct == false ? Container() : Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color: Color(0xfff8f8f8),),

                  margin: EdgeInsets.only(left: 16, right: 16.0,bottom: 15.0),
                  padding: EdgeInsets.only(left: 16, right: 16,bottom: 16,top: 16),
                  child: Column(
                    children: [
                      Stack(children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 16,right: 8,top: 26),
                          child: Divider(),
                        ),
                        Row(
                          children: [
                            FlatButton(
                              color: Colors.transparent,
                              padding: EdgeInsets.only(left: 16.0),
                              onPressed: () {
                                setState(() {
                                  overviewTapped = true;
                                  specificationTapped = false;
                                });
                              },
                              child: Column(
                                children: <Widget>[
                                  Text(
    translator.translate('Overview'),
                                    style: TextStyle(
                                        fontSize:  overviewTapped? 14 : 13,
                                        color: overviewTapped? colorsfile.brownishGrey : colorsfile.grey  ,
                                        fontWeight: overviewTapped? FontWeight.bold :  FontWeight.w600,backgroundColor: Colors.transparent),
                                  ),
                                  Padding(padding: EdgeInsets.only(top: 6.0)),
                                  Container(
                                    height: SizeConfig.safeBlockVertical * 0.2,
                                    color: overviewTapped? colorsfile.brownishGrey : Colors.transparent,
                                    width: SizeConfig.safeBlockHorizontal * 18,
                                  )
                                ],
                              ),
                            ),
                            FlatButton(
                              padding: EdgeInsets.only(left: 22.0),
                              onPressed: () {
                                setState(() {
                                  overviewTapped = false;
                                  specificationTapped = true;
                                });
                              },
                              child: Column(
                                children: <Widget>[
                                  Text(
    translator.translate('Specifications'),
                                    style: TextStyle(
                                        fontSize: specificationTapped ? 14 : 13,
                                        color: specificationTapped ?colorsfile.brownishGrey: colorsfile.grey ,
                                        fontWeight: specificationTapped ? FontWeight.bold :  FontWeight.w600),
                                  ),
                                  Padding(padding: EdgeInsets.only(top: 6.0)),
                                  Container(
                                    height: SizeConfig.safeBlockVertical * 0.2,
                                    color: specificationTapped ?colorsfile.brownishGrey: Colors.transparent,
                                    width: SizeConfig.safeBlockHorizontal * 23,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],),


                      Container(
                        padding: EdgeInsets.only(left: 16,right: 16,top: 16.0),
                        child: Text(
                          specificationTapped? "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd" :'${_giftProduct.description}',
                          style: TextStyle(
                              fontSize: 15,
                              color: colorsfile.grey,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 100,)
              ],
            ),
          ),
        ),
        _productDetails.toString() == 'null' || _productDetails.amount != 0.0 ? Container(
          margin: EdgeInsets.only(top: 10.0),
          alignment: Alignment.bottomCenter ,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  height: 72,
                  width: SizeConfig.safeBlockHorizontal * 50,
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.only(topRight: Radius.circular(17))),
                    color: colorsfile.white2,
                    onPressed: () {},
                    child: Column(
                      children: [
                        Padding(padding: EdgeInsets.only(top: 14.0)),
                        Text(
                          translator.translate('Total '),
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        ),
                        Padding(padding: EdgeInsets.only(top: 6.0)),
                        Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                          Text(
                            _productDetails.toString() == 'null'? '0' : '${_productDetails.price}',
                            style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 3,),
                          Text(
                            '${ GlobalVars.Currency}' ,
                            style: TextStyle(
                                fontSize: 16.0,
                                color: colorsfile.brownishGrey,
                                fontWeight: FontWeight.w400),
                          ),
                        ],

                        )
                      ],
                    ),
                  )),
              Container(
                  decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.only(topLeft: Radius.circular(17)),
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            colorsfile.azure,
                            colorsfile.vibrantBlue
                          ])),
                  height: 72,
                  width: SizeConfig.safeBlockHorizontal * 50,
                  child: FlatButton(
                    onPressed: () {
                      showLoadingDialog();
                      CartBloc().addToCart(_scaffoldKey,_productDetails.id,1).then((value){
                        hideDialog();
                        navigateAndKeepStack(context, MainScreen(position: 3,));
                        //   showSnack('Added successfully');
                      });
                    },
                    child: Text(
                      translator.translate('Add to Cart'),
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w800),
                    ),
                  ))
            ],
          ),
        ) : Container(),
        SizedBox(height: 100,)
      ],
    );
  }
}

