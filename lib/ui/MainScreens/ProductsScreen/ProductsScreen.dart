import 'package:dealmart/base/BaseStatefullWidget.dart';
import 'package:dealmart/resources/AppColors.dart';
import 'package:dealmart/ui/GeneralModels/GeneralAPi.dart';
import 'package:dealmart/ui/MainScreens/CartScreen/bloc/CartBloc.dart';
import 'package:dealmart/ui/MainScreens/DrawerWidget/DrawerWidget.dart';
import 'package:dealmart/ui/MainScreens/DrawerWidget/MyAddress/bloc/getAddressBloc.dart';
import 'package:dealmart/ui/MainScreens/DrawerWidget/MyAddress/model/Address_model.dart';
import 'package:dealmart/ui/MainScreens/MainScreen.dart';
import 'package:dealmart/ui/MainScreens/ProductsScreen/bloc/WinnersBloc.dart';
import 'package:dealmart/ui/MainScreens/ProductsScreen/model/ProductModel.dart';
import 'package:dealmart/ui/MainScreens/ProductsScreen/model/TodayWinnerModel.dart';
import 'package:dealmart/ui/MainScreens/ProductsScreen/model/TopWinnerModel.dart';
import 'package:dealmart/ui/MainScreens/ProfileScreen/model/EditProfileResponse.dart';
import 'package:dealmart/ui/MainScreens/bloc/UserInfo.dart';
import 'package:dealmart/ui/MyFavouritesScreens/bloc/GetFavourite.dart';
import 'package:dealmart/ui/Notifications/notification_helper.dart';
import 'package:dealmart/ui/WinnersScreen/WinnersScreen.dart';
import 'package:dealmart/ui/sign_in/SignIn.dart';
import 'package:dealmart/utils/global_vars.dart';
import 'package:dealmart/utils/image_file.dart';
import 'package:dealmart/utils/navigator.dart';
import 'package:dealmart/utils/size_config.dart';
import 'package:dealmart/utils/static_ui.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
//import 'package:flutter_svg/svg.dart';
import 'package:dealmart/utils/image_file.dart' as image_file;
import 'package:dealmart/utils/colors_file.dart' as colors;
import 'package:dealmart/utils/shared_utils.dart' as shared;

import 'package:flutter_svg/flutter_svg.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import 'bloc/ProductBloc.dart';
import 'product_details/ProductDetailsScreen.dart';
import 'ProductsAds.dart';

class ProductsScreen extends BaseStatefulWidget {
  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends BaseState<ProductsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<TopWinner> topWinner = List();
  TopWinnerModel _topWinnerModel;
  final FirebaseMessaging _fcm = FirebaseMessaging();

  List<TodayWinner> todayWinner = List();
  TodayWinnerModel _todayWinnerModel;
  AddressModel addressModel;
  List<Adress> address = List();
  ProductModel _productModel;
  List<Product> product = List();
  @override
  Widget getDrawer() {
    // TODO: implement getDrawer
    return Container(
        width: MediaQuery.of(context).size.width / 1.3, child: DrawerWidget(
    )
    );
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
  Widget getAppbar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(0.0),
      child: AppBar(
        elevation: 0,
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fcm.getToken().then((firebaseToken) {
      print("firebase_token initstate  ${firebaseToken}");
      GeneralApi(context).setTocken(firebaseToken).then((value) {
        NotificationCenter(context).initConfigure();

        getAddress();
        getData();

      });


    });

  }

  getAddress() {
    GetAddress().getAddress(_scaffoldKey).then((value) {
      hideDialog();
      setState(() {
        addressModel = value;
        addressModel.success.forEach((element) {
          address.add(element);
          if(element.isDefault==1){
            setState(() {
              GlobalVars.defaultAddress=element;
            });
          }
        });
        print("addd ${address.length}");
        // if (address.isNotEmpty ||
        //     address.length == 0 ||
        //     address.toString() != 'null') {
        //   setState(() {
        //     if(address.length==0){
        //
        //     }
        //     else {
        //       GlobalVars.defaultAddress  = address[0];
        //
        //     }
        //   });
        // }
      });
    });
  }

  getData() {
    UserInfo().getUserInfo(_scaffoldKey).then((value) {
      if (value == null || value.toString() == 'nuul') {
        shared.removeKeyFromShared(context, key: 'userToken');
        shared.setRememberMe(false);
        navigateAndClearStack(context, SignIn());
      } else {
        GlobalVars.userData = value.user;
      }
    });


    WinnersBloc().getTopWinners(_scaffoldKey).then((value) {
      setState(() {
        _topWinnerModel = value;
        _topWinnerModel.topWinner.forEach((element) {
          topWinner.add(element);
        });
      });
      print("Length ${topWinner.length}");
    });
    WinnersBloc().getTodayWinners(_scaffoldKey).then((value) {
      _todayWinnerModel = value;
      _todayWinnerModel.todayWinner.forEach((element) {
        todayWinner.add(element);
      });
    });

    ProductBloc().getProduct(_scaffoldKey).then((value) {
      setState(() {
        _productModel = value;
        _productModel.success.data.forEach((element) {
          product.add(element);
        });
      });
    });
  }

  Future<bool> closeApp() {
    StaticUI().closeApp(context);
  }

  @override
  Widget getBody(BuildContext context) {
    SizeConfig().init(context);
    return WillPopScope(
      onWillPop: closeApp,
      child: Container(
        padding: EdgeInsets.only(left: 5, right: 5),
        child: ListView(
          children: <Widget>[
            Stack(
              children: <Widget>[
                ProductsAds(),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          openDrawer();
                        },
                        child: SvgPicture.asset(
                          MENU,
                          width: 35,
                          height: 35,
                          fit: BoxFit.cover,
                          color: WHITE,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              height: 100,
              padding: EdgeInsets.all(10),
              color: Color.fromRGBO(243, 243, 243, 1),
              margin: EdgeInsets.only(top: 34, left: 16, right: 16, bottom: 21),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Image.asset(
                    'images/free_delivery.png',
                    width: MediaQuery.of(context).size.width / 2.5,
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(translator.translate('Free Delivery'),
                          style: TextStyle(
                              color: BLACK,
                              fontSize: 14,
                              fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: 3,
                      ),
                      Text('Lorem ipsum dolor sit amet,\nconsetetur',
                          style: TextStyle(
                              color: BLACK,
                              fontSize: 10,
                              fontWeight: FontWeight.w300)),
                      Container(
                          margin: EdgeInsets.only(top: 7),
                          padding:
                              EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                          decoration: BoxDecoration(
                              border: Border.all(color: BLACK, width: 1)),
                          child: Center(
                              child: Text(
                            translator.translate('Read more'),
                            style: TextStyle(
                                color: BLACK,
                                fontSize: 10,
                                fontWeight: FontWeight.normal),
                          )))
                    ],
                  ),
                  Container()
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                translator.translate('Join Winners!'),
                style: TextStyle(
                    color: Color(0xff212221), fontSize: 25, fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(
              height: 17,
            ),
            Container(
              height: 130,
              child: ListView(
                physics: AlwaysScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                children: [
                  GestureDetector(
                    onTap: () {
                      navigateAndKeepStack(context, WinnersScreen(todayWinner));
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 10, bottom: 10, left: 4),
                      width: 238,
                      // width: MediaQuery.of(context).size.width / 1.5,
                      height: 130,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Color.fromRGBO(227, 227, 227, 1)),
                          borderRadius: BorderRadius.all(Radius.circular(17))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 15),
                            child: Text(
                              translator.translate('Top Winners'),
                              style: TextStyle(
                                  color: Color(0xff212221),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          topWinner.toString() == 'null'
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : topWinner.length == 0 || topWinner.isEmpty
                                  ? Center(
                                      child: Text(translator.translate("There's no Top Winners")),
                                    )
                                  : Container(
                                      height: 40.0,
                                      child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: topWinner.length,
                                          itemBuilder: (context, index) {
                                            return Container(
                                                margin: EdgeInsets.only(
                                                    top: 10, left: 20),
//                                    width: MediaQuery.of(context).size.width/1.5,
                                                child:

                                                    /*
                                         Stack(
                                          children: [
                                            index == 0? Container(
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(70.0),
                                                child: FadeInImage.assetNetwork(
                                                  placeholder: image_file.placeHolderImageProfile,
                                                  image: topWinner[index].user.profilePicture.toString() == 'null'? "" : "https://dealmart.herokuapp.com/" + topWinner[index].user.profilePicture,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              width: 70,
                                              height: 70,
                                            ):Container(width: 0,height: 0,),
                                            index != 0? Positioned(
                                              left: 40.0*index,
                                              child: Container(
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(70.0),
                                                  child: FadeInImage.assetNetwork(
                                                    placeholder: image_file.placeHolderImageProfile,
                                                    image: topWinner[index].user.profilePicture.toString() == 'null'? "" : "https://dealmart.herokuapp.com/" + topWinner[index].user.profilePicture,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                width: 70,
                                                height: 70,
                                              ),
                                            ):Container(),

                                         */
                                                    Row(
                                                  children: <Widget>[
                                                    Container(
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(70.0),
                                                        child: FadeInImage
                                                            .assetNetwork(
                                                          placeholder: image_file
                                                              .placeHolderImageProfile,
                                                          image: topWinner[
                                                                          index]
                                                                      .user
                                                                      .profilePicture
                                                                      .toString() ==
                                                                  'null'
                                                              ? ""
                                                              : "https://dealmart.herokuapp.com/" +
                                                                  topWinner[
                                                                          index]
                                                                      .user
                                                                      .profilePicture,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                      width: 70,
                                                      height: 70,
                                                    ),
                                                  ],
                                                ));
                                          }),
                                    ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width:5 ,),
                  GestureDetector(
                    onTap: () {
                      navigateAndKeepStack(context, WinnersScreen(todayWinner));
                    },
                    child: Container(
                      margin: EdgeInsets.all(10),
                      width: 238,
                      // width: MediaQuery.of(context).size.width / 1.5,
                      height: 130,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Color.fromRGBO(227, 227, 227, 1)),
                          borderRadius: BorderRadius.all(Radius.circular(17))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 15),
                            child: Text(
                              translator.translate('Today Winners'),
                              style: TextStyle(
                                  color: Color(0xff212221),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          todayWinner.toString() == 'null'
                              ? Center(child: CircularProgressIndicator())
                              : todayWinner.length == 0 || todayWinner.isEmpty
                                  ? Center(
                                      child: Text(translator.translate("There's no winners Today")),
                                    )
                                  : Container(
                                      height: 60.0,
                                      child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: todayWinner.length,
                                          itemBuilder: (context, index) {
                                            return Container(
                                                margin: EdgeInsets.only(
                                                    top: 10, left: 20),
//                                    width: MediaQuery.of(context).size.width/1.5,
                                                child: Row(
                                                  children: <Widget>[
                                                    Container(
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(70.0),
                                                        child: FadeInImage
                                                            .assetNetwork(
                                                          placeholder: image_file
                                                              .placeHolderImageProfile,
                                                          image: todayWinner[
                                                                          index]
                                                                      .user
                                                                      .profilePicture
                                                                      .toString() ==
                                                                  'null'
                                                              ? ""
                                                              : "https://dealmart.herokuapp.com/" +
                                                                  todayWinner[
                                                                          index]
                                                                      .user
                                                                      .profilePicture,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                      width: 70,
                                                      height: 70,
                                                    ),
                                                  ],
                                                ));
                                          }),
                                    ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: 34,
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                translator.translate('Other Campaigns'),
                style: TextStyle(
                    color: Color(0xff212221), fontSize: 25, fontWeight: FontWeight.w600),
              ),
            ),

            SizedBox(
              height: 34,
            ),

            product.toString() == 'null'
                ? product.length == 0 || product.isEmpty
                    ? Center(
                        child: Container(
                          margin: EdgeInsets.only(top: 30.0),
                          child: Text(
                            translator.translate("No Product"),
                            style: TextStyle(
                                fontSize: 22.0,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                        ),
                      )
                    : Center(
                        child: CircularProgressIndicator(),
                      )
                : Container(
                    child: Column(
                      children: [
                        Container(
                          height: 165,
                          child: ListView.builder(
                              physics: AlwaysScrollableScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: product.length,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: () {
                                    navigateAndKeepStack(
                                        context,
                                        ProductDetailsScreen(
                                          productId:
                                              product[index].id.toString(),
                                        ));
                                  },
                                  child: Container(
//                    margin: EdgeInsets.all(5),
                                    margin: EdgeInsets.only(left: 8),
                                    padding: EdgeInsets.only(
                                        left: 4, right: 10, top: 5),
                                    width:
                                        MediaQuery.of(context).size.width / 2.3,
//                    height: 300,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Color.fromRGBO(
                                                227, 227, 227, 1)),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15))),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Card(
                                              elevation: 5,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(25))),
                                              child: Padding(
                                                padding: EdgeInsets.all(10.0),
                                                child: Text(
                                                  '${product[index].price} ${ GlobalVars.Currency}',
                                                  style: TextStyle(
                                                      fontSize: 9,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: BLACK),
                                                ),
                                              ),
                                            ),
                                            Icon(
                                              FontAwesome.shopping_cart,
                                              size: 18,
                                            )
                                          ],
                                        ),
                                        Image.asset(
                                          CLOCK,
                                          height: 45,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              translator.translate('Buy '),
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color.fromRGBO(
                                                      0, 118, 254, 1)),
                                            ),
                                            Text(
                                              '${product[index].name}',
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold,
                                                  color: BLACK),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            LinearPercentIndicator(

                                              padding: EdgeInsets.only(top: 9),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  3,
                                              lineHeight: 7.0,
                                              percent: (product[index].sold /
                                                      (product[index].amount +
                                                          product[index]
                                                              .sold)) /
                                                  100.0,
                                              backgroundColor: Colors.grey[200],
                                              progressColor: Color(0xfffebd06),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              '${product[index].sold} /',
                                              style: TextStyle(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.bold,
                                                  color: BLACK),
                                            ),
                                            Text(
                                              '${product[index].amount + product[index].sold} Sold',
                                              style: TextStyle(
                                                  fontSize: 11, color: BLACK),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Container(
                                          height: 1,
                                          color:
                                              Color.fromRGBO(227, 227, 227, 1),
                                        ),
                                        SizedBox(
                                          height: 6,
                                        ),
                                        product[index].gift == null ||
                                                product[index]
                                                        .gift.giftProduct
                                                        .toString() ==
                                                    'null'
                                            ? Container()
                                            : Container(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: <Widget>[
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          translator.translate('Win '),
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color: BLACK),
                                                        ),
                                                        Text(
                                                          '${product[index].gift.giftProduct.name}',
                                                          style: TextStyle(
                                                              fontSize: 11,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: BLACK),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 25),
                          child: Text(
                            translator.translate('Hot Deals'),
                            style: TextStyle(
                                color: BLACK,
                                fontSize: 20,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: product.length,
                            itemBuilder: (BuildContext context, int index) {
                              print("productsold ${product[index].sold}");
                              print("productamount ${product[index].amount}");
                              print("productProduct ${product[index].sold/product[index].amount}");
                              print("productProduct ${((product[index]
                                  .sold /
                                  product[index]
                                      .amount) /
                                  100)}");
                              return Container(
                                padding: EdgeInsets.only(
                                    bottom: 10.0, right: 10.0, left: 10.0),
                                margin: EdgeInsets.only(
                                    bottom: 10.0, right: 10.0, left: 10.0),
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        product[index].amount == 0.0
                                            ? Container(
                                                child: Stack(
                                                  overflow: Overflow.visible,
                                                  children: [
                                                    Container(
                                                      width: 110,
                                                      height: 110.0,
                                                      padding:
                                                          EdgeInsets.all(10),
                                                      decoration: BoxDecoration(
                                                        color: Colors.red
                                                            .withOpacity(.2),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    80.0)),
                                                      ),
                                                      margin: EdgeInsets.only(
                                                          left: 7.0,
                                                          right: 7.0),
                                                    ),
                                                    Positioned(
                                                      bottom: 10,
                                                      child: Container(
                                                        width: 110,
                                                        height: 110.0,
                                                        padding:
                                                            EdgeInsets.all(10),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.red,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          80.0)),
                                                        ),
                                                        margin: EdgeInsets.only(
                                                            left: 7.0,
                                                            right: 7.0),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            SizedBox(
                                                              height: 5.0,
                                                            ),
                                                            Container(
                                                              child: Text(
                                                                "SOLD\nOUT",textAlign: TextAlign.center,
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      18.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 8.0,
                                                            ),
                                                            Container(
                                                              color:
                                                                  Colors.white,
                                                              height: 1.5,
                                                              width:
                                                                  MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
                                                            ),
                                                            Container(
                                                              child: Text(
                                                                translator.translate("Lottery Date"),
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      15.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              child: Text(
                                                                product[index]
                                                                                .gift ==
                                                                            null ||
                                                                        product[index].gift.toString() ==
                                                                            "null" ||
                                                                        product[index].gift.winner ==
                                                                            null ||
                                                                        product[index].gift.winner.toString() ==
                                                                            "null"
                                                                    ? "No Date"
                                                                    : "${product[index].gift.winner.announceDate?.substring(0, 10) ?? ""}",
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      12.5,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            : CircularPercentIndicator(

                                                radius: 100.0,
                                                lineWidth: product[index].amount == 0.0
                                                    ? 3
                                                    : 5,
                                                percent:
                                                    product[index].amount == 0.0
                                                        ? 1
                                                        : ((product[index]
                                                                    .sold)
                                                        /
                                                        (product[index].sold + product[index].amount)),
                                                center: Center(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      Text(
                                                        '${product[index].sold} Sold',
                                                        style: TextStyle(
                                                            color: BLACK,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Container(
                                                        margin: EdgeInsets
                                                            .symmetric(
                                                                vertical: 5,
                                                                horizontal: 15),
                                                        color: Colors.grey,
                                                        height: 1,
                                                      ),
                                                      Text(
                                                        translator.translate('Out of'),
                                                        style: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Text(
                                                        '${product[index].sold + product[index].amount}',
                                                        style: TextStyle(
                                                            color: BLACK,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                progressColor:
                                                    product[index].amount == 0.0
                                                        ? colors.whiteThree
                                                        : colors.marigold,
                                          backgroundColor:colors.whiteThree ,
                                              ),
                                        GestureDetector(
                                          onTap: product[index].amount == 0.0
                                              ? null : () {
                                             showLoadingDialog();
                                            product[index].isFavourit == 1 ?

                                            GetFavouritesBloc()
                                                .removeFromFavourites(
                                                _scaffoldKey,
                                                product[index].id.toString())
                                                .then((value) {
                                              hideDialog();
                                              setState(() {
                                                product[index].isFavourit = product[index].isFavourit == 1 ? 0 : 1;
                                              });
                                            }) :  GetFavouritesBloc()
                                                .addFavourites(
                                                _scaffoldKey,
                                                product[index].id)
                                                .then((value) {
                                              hideDialog();
                                              setState(() {
                                                product[index].isFavourit = product[index].isFavourit == 1 ? 0 : 1;
                                              });
                                            });
                                          }
                                              ,
                                          child: product[index].isFavourit == 1
                                              ? Icon(
                                                  Icons.favorite,
                                                  color:
                                                      product[index].amount ==
                                                              0.0
                                                          ? colors.orangeColor
                                                              .withOpacity(.2)
                                                          : colors.orangeColor,
                                                  size: 25,
                                                )
                                              : Icon(
                                                  FontAwesome.heart_o,
                                                  color:
                                                      product[index].amount ==
                                                              0.0
                                                          ? Color.fromRGBO(
                                                              249, 115, 2, .2)
                                                          : Color.fromRGBO(
                                                              249, 115, 2, 1),
                                                  size: 25,
                                                ),
                                        )
                                      ],
                                    ),
                                    Container(
                                        height: 200,
                                        margin: EdgeInsets.symmetric(
                                            vertical: 15, horizontal: 20),
                                        decoration: BoxDecoration(
                                            // borderRadius: BorderRadius.circular(10),
                                            ),
                                        child: FadeInImage.assetNetwork(
                                          placeholder: 'images/car_test.png',
                                          image:
                                              "https://dealmart.herokuapp.com/products/${product[index].id}/${product[index].id}.jpg",
                                        )),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          translator.translate('Buy '),
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color:
                                                  product[index].amount == 0.0
                                                      ? Color.fromRGBO(
                                                          0, 122, 254, .2)
                                                      : Color.fromRGBO(
                                                          0, 122, 254, 1)),
                                        ),
                                        Text(
                                          '${product[index].name} For ',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color:
                                                  product[index].amount == 0.0
                                                      ? BLACK.withOpacity(.2)
                                                      : BLACK),
                                        ),
                                        Text(
                                          '${product[index].price} ',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color:
                                                  product[index].amount == 0.0
                                                      ? PRIMARY_COLOR
                                                          .withOpacity(.2)
                                                      : PRIMARY_COLOR),
                                        ),
                                        Text(
                                          '${ GlobalVars.Currency}',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              color:
                                                  product[index].amount == 0.0
                                                      ? PRIMARY_COLOR
                                                          .withOpacity(.2)
                                                      : PRIMARY_COLOR),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        InkWell(
                                          onTap: product[index].amount == 0.0
                                              ? null
                                              : () {
                                                  navigateAndKeepStack(
                                                      context,
                                                      ProductDetailsScreen(
                                                        productId:
                                                            product[index]
                                                                .id
                                                                .toString(),
                                                      ));
                                                },
                                          child: Container(
                                            height: 45,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2.43,
                                            margin: EdgeInsets.only(top: 20),
                                            decoration: BoxDecoration(
                                                gradient: new LinearGradient(
                                                  colors: [
                                                    product[index].amount == 0.0
                                                        ? Color(0xff009ffd)
                                                            .withOpacity(.2)
                                                        : Color(0xff009ffd),
                                                    product[index].amount == 0.0
                                                        ? Color(0xff002cff)
                                                            .withOpacity(.2)
                                                        : Color(0xff002cff),
                                                  ],
                                                  stops: [0.0, 2],
                                                  begin: FractionalOffset
                                                      .topCenter,
                                                  end: FractionalOffset
                                                      .bottomCenter,
                                                ),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(15))),
                                            child: Center(
                                              child:  product[index].isCart==0? InkWell(
                                                onTap: (){
                                                  showLoadingDialog();
                                                  CartBloc().addToCart(_scaffoldKey,product[index].id,1).then((value){
                                                    hideDialog();
                                                    navigateAndKeepStack(context, MainScreen(position: 3,));
                                                    //   showSnack('Added successfully');
                                                  });
                                                },
                                                child: Text(
                                                  translator.translate('Buy and win'),
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.bold,
                                                      color: WHITE),
                                                ),
                                              ):

                                              Container(child:
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  GestureDetector(
                                                      onTap: () {
                                                         setState(() {
                                                          if(product[index].amount > 0){
//
                                                            showLoadingDialog();
                                                            CartBloc().editCartsAmount(_scaffoldKey, product[index].id.toString(),"${product[index].cart_amount - 1}").then((value){
                                                              hideDialog();
                                                              navigateAndClearStack(context, MainScreen(position: 2,));
                                                            });
                                                          }
                                                        });
                                                      },
                                                      child: Container(
                                                        //                            padding: EdgeInsets.all(4),
                                                        alignment: Alignment.center,
                                                        child: Center(child: Text("-",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20,color: colors.primaryAppColor),textAlign: TextAlign.center,)),
                                                        width: 23,
                                                        height: 23,
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(29),
                                                          color: colors.brownishGrey2,),)),
                                                  SizedBox(width: 2,),
                                                  Container(
                                                    padding: EdgeInsets.all(4),
                                                    child: Center(child: Text("${product[index].cart_amount}", style: TextStyle(
                                                        fontWeight: FontWeight.bold, fontSize: 14,color: colors.whiteColor),)),
                                                    width: 29,
                                                    height: 29,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(29),),),
                                                  SizedBox(width: 4,),
                                                  GestureDetector(
                                                      onTap: () {
                                                        print("amountamount ${product[index].amount}");
                                                        setState(() {
//
                                                            if(product[index].cart_amount + 1 < (product[index].amount)){
                                                            showLoadingDialog();
                                                            CartBloc().editCartsAmount(_scaffoldKey, product[index].id.toString(),"${product[index].cart_amount + 1}").then((value){
                                                              hideDialog();
                                                              navigateAndClearStack(context, MainScreen(position: 2,));
                                                            });
                                                          }else{
                                                            checkAvailability();
                                                          }
                                                        });
                                                      },
                                                      child: Container(
                                                        //                            padding: EdgeInsets.all(4),
                                                        alignment: Alignment.center,
                                                        child: Text("+",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20,color: colors.primaryAppColor),),
                                                        width: 23,
                                                        height: 23,
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(29),
                                                          color: colors.whiteColor,),))
                                                ],),
                                              )
                                              ,
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: product[index].amount == 0.0
                                              ? null
                                              : () {
                                                  navigateAndKeepStack(
                                                      context,
                                                      ProductDetailsScreen(
                                                        productId:
                                                            product[index]
                                                                .id
                                                                .toString(),
                                                      ));
                                                },
                                          child: Container(
                                            height: 45,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2.43,
                                            margin: EdgeInsets.only(top: 20),
                                            decoration: BoxDecoration(
                                                gradient: new LinearGradient(
                                                  colors: [
                                                    product[index].amount == 0.0
                                                        ? Color(0xfffa9f42)
                                                            .withOpacity(.2)
                                                        : Color(0xfffa9f42),
                                                    product[index].amount == 0.0
                                                        ? Color(0xffee752a)
                                                            .withOpacity(.2)
                                                        : Color(0xffee752a),
                                                  ],
                                                  stops: [0.0, 2.0],
                                                  begin: FractionalOffset
                                                      .centerLeft,
                                                  end: FractionalOffset
                                                      .centerRight,
                                                ),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(15))),
                                            child: Center(
                                              child: Text(
                                                translator.translate('More Details'),
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: WHITE),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    product[index].gift == null ||
                                            product[index].gift.giftProduct.toString() ==
                                                'null'
                                        ? Container()
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Text(
                                                translator.translate('Get a chance to '),
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                    color: product[index]
                                                                .amount ==
                                                            0.0
                                                        ? BLACK.withOpacity(.2)
                                                        : Color(0xff393434)),
                                              ),
                                              Text(
                                                translator.translate('Win '),
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w400,
                                                    color:
                                                        product[index].amount ==
                                                                0.0
                                                            ? PRIMARY_COLOR
                                                                .withOpacity(.2)
                                                            : PRIMARY_COLOR),
                                              ),
                                              Text(
                                                '${product[index].gift.giftProduct.name}',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                    color: product[index]
                                                                .amount ==
                                                            0.0
                                                        ? BLACK.withOpacity(.2)
                                                        : Color(0xff393434)),
                                              ),
                                            ],
                                          ),
                                    Container(
                                      margin: EdgeInsets.only(
                                          bottom: 10.0, top: 13.0),
                                      color: colors.borderColor,
                                      height: 1,
                                    ),
                                  ],
                                ),
                              );
                            })
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
