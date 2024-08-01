
import 'package:dealmart/base/BaseStatefullWidget.dart';
import 'package:dealmart/resources/AppColors.dart';
import 'package:dealmart/ui/MainScreens/CartScreen/CartScreen.dart';
import 'package:dealmart/ui/MainScreens/DrawerWidget/OrderScreen/OrderScreen.dart';
 import 'package:dealmart/ui/MainScreens/ProductsScreen/ProductsScreen.dart';
import 'package:dealmart/ui/MainScreens/ProfileScreen/ProfileScreen.dart';
import 'package:dealmart/ui/MainScreens/bloc/UserInfo.dart';
import 'package:dealmart/utils/global_vars.dart';
 import 'package:dealmart/utils/notification_helper.dart';
 import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:dealmart/utils/navigator.dart';
import 'package:dealmart/utils/notification_helper.dart';
import 'package:dealmart/utils/static_ui.dart';
 import 'package:dealmart/utils/image_file.dart' as image_file;
import 'package:dealmart/utils/colors_file.dart' as colorsValues;
import 'package:flutter_icons/flutter_icons.dart';

import 'DrawerWidget/FavouritesScreen/FavouriteScreen.dart';

class MainScreen extends BaseStatefulWidget {
int position;


MainScreen({this.position});


  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends BaseState<MainScreen> {
  int selectedTab;
  final _pageOptions = [
    OrderScreen(),
    // ProductsScreen(),


    FavouriteScreen(),
    ProductsScreen(),

    CartScreen(),
    ProfileScreen(),


  ];

  @override
  void initState() {

    selectedTab=widget.position;

    Future.delayed(Duration.zero, () {
      NotificationCenter(context).initConfigure();
    });

  }

  Widget selectTabIcon(int index, String image) {

    return  selectedTab != index
        ? Container(
        padding: EdgeInsets.all(8),
        width: 40,
        height: 40,
        child: Image.asset(
          image,
          color:selectedTab != index
              ? colorsValues.greyColorXd
              : PRIMARY_COLOR,
        )
    ) :
    index == 2 ? Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10)
          ),
          gradient: new LinearGradient(
            colors: [
              selectedTab != index ? Colors.white : Color(0xfffa9f42),
              selectedTab != index ? Colors.white:Color(0xffee752a)
            ],
            stops: [0.0, 3.0],
            begin: FractionalOffset.centerRight,
            end: FractionalOffset.centerRight,
          ),
        ),
        padding: EdgeInsets.all(10),
        child: Image.asset(
          image,
          height: 24,
          width: 24,
          color:selectedTab != index
              ? colorsValues.greyColorXd
              : WHITE,
        )

    ):Container(

        width: 24,
        height: 24,
        child: Image.asset(
          image,
          color: selectedTab != index
              ? Colors.grey
              : PRIMARY_COLOR,
        ));
  }
  bool cartTapped = false;
  bool homeTapped = true;
  @override
  Widget getBottomNaviagationBar() {
    // TODO: implement getBottomNaviagationBar
    return Container(decoration: BoxDecoration(boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.1),
        spreadRadius: 6,
        blurRadius: 6,
        offset: Offset(0, 6), // changes position of shadow
      ),
    ],borderRadius:BorderRadius.only(topLeft: Radius.circular(55),topRight: Radius.circular(55)) ),
      child: ClipRRect(borderRadius: BorderRadius.only(topLeft: Radius.circular(50),topRight: Radius.circular(50)),clipBehavior:Clip.antiAlias ,
        child: BottomAppBar(shape: CircularNotchedRectangle(),
          color: Colors.blueGrey,
          notchMargin: 2.0,
          clipBehavior: Clip.antiAlias,
          elevation: 1,

          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(40)),
              boxShadow: [
                BoxShadow(
                  color: Color(0x1c000000).withOpacity(0.11),
                  offset: Offset(0.0, 0.0), //(x,y)
                  blurRadius: 6,
                ),
              ],
            ),
            child: Theme(
              data: Theme.of(context).copyWith(
                  canvasColor: colorsValues.whiteColor,
                  primaryColor: colorsValues.primaryAppColor,
                  textTheme: Theme.of(context).textTheme.copyWith(
                      caption: new TextStyle(color: colorsValues.greyColorXd))),
              child: BottomNavigationBar(
                showSelectedLabels: false,
                showUnselectedLabels: false,
                selectedFontSize: 0,
                unselectedFontSize: 0,
                type: BottomNavigationBarType.fixed,
                currentIndex:  selectedTab,
                onTap: (int index) {
                  setState(() {

                    selectedTab=index;

                  });
                },
                fixedColor: colorsValues.primaryAppColor,
                items: [
                  BottomNavigationBarItem(
                      icon: selectTabIcon(0, image_file.home),
                      title: Text('')
                  ),
                  BottomNavigationBarItem(
                      icon: selectTabIcon(1, image_file.FAVORITE),
                      title: Text('')),
                  BottomNavigationBarItem(
                      icon: Container(width: 70,height: 87,
                          margin: EdgeInsets.only(top:7 ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(17),
                                topRight: Radius.circular(17)
                            ),
                            gradient: new LinearGradient(
                              colors: [
                                 colorsValues.lightOrange,
                                colorsValues.dustyOrange
                              ],
                              begin: FractionalOffset.center,
                              end: FractionalOffset.bottomCenter,
                            ),
                          ),
                          padding: EdgeInsets.all(21),
                          child: Image.asset(
                            image_file.products,
                            height: 24,
                            width: 24,
                            color: WHITE,
                          )

                      ),

                      title: Text('')
                  ),
                  BottomNavigationBarItem(
                      icon: InkWell(
                        onTap: (){
                          setState(() {
                            selectedTab = 3;
                           // cartTapped = !cartTapped;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(8),
                          width: 40,
                          height: 40,
                          child: Stack(
                            overflow: Overflow.visible,
                            children: [
                              Container(
                                child: Image.asset(
                                  image_file.SHOOPING_CAR,
                                  color:  selectedTab == 3 ? PRIMARY_COLOR: Colors.grey,
                                ),
                              ),
                              GlobalVars.cartLength == 'null' ||  GlobalVars.cartLength =="0"?Container():   Positioned(
                                top: -8,
                                right: -8,
                                child: Container(
                                  width: 16,
                                  height: 16,
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.all(1),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(16)),
                                    gradient: new LinearGradient(
                                      colors: [
                                        colorsValues.lightOrange,
                                        colorsValues.dustyOrange
                                      ],
                                      begin: FractionalOffset.center,
                                      end: FractionalOffset.bottomCenter,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      GlobalVars.cartLength == 'null' ? "0" : " ${GlobalVars.cartLength}",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10.0,
                                          fontWeight: FontWeight.w500
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      title: Text('')),
                  BottomNavigationBarItem(
                      icon: selectTabIcon(4, image_file.ACCOUNT), title: Text('')),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget getAppbar() {
    // TODO: implement getAppbar
    return null;
  }

  @override
  Widget getBody(BuildContext context) {
    // TODO: implement getBody

    return _pageOptions[selectedTab];
  }
}
