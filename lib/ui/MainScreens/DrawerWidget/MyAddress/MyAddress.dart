import 'dart:async';

import 'package:dealmart/base/BaseStatefullWidget.dart';
import 'package:dealmart/resources/AppColors.dart';
import 'package:dealmart/ui/MainScreens/DrawerWidget/MyAddress/address_details.dart';
import 'package:dealmart/ui/MainScreens/DrawerWidget/MyAddress/model/Address_model.dart';
import 'package:dealmart/ui/map_view/MapView.dart';
import 'package:dealmart/utils/global_vars.dart';
import 'package:dealmart/utils/navigator.dart';
import 'package:dealmart/utils/size_config.dart';
import 'package:dealmart/utils/static_ui.dart';
import 'package:flutter/material.dart';
import 'package:dealmart/utils/colors_file.dart' as colorsValues;
import 'package:geolocator/geolocator.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:location/location.dart';

import '../../MainScreen.dart';
import 'bloc/SetAddressBloc.dart';
import 'bloc/getAddressBloc.dart';

class MyAddress extends BaseStatefulWidget {
  bool fromCheckOut = false;

  MyAddress({this.fromCheckOut});

  @override
  _MyAddressState createState() => _MyAddressState();
}

class _MyAddressState extends BaseState<MyAddress> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  AddressModel addressModel;
  List<Adress> addressList ;
  double currentLat = 0.0, currentLong = 0.0;
  String currentAddress = "";
  int SelectedAddrssId;
  int _selectedIndex;
  _onSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Location location = new Location();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gettingData();
  }

  gettingData() {
    getCurrentLocation();
    Timer(Duration(milliseconds: 200), () {
      // showLoadingDialog();
      GetAddress().getAddress(_scaffoldKey).then((value) {
        // hideDialog();
        setState(() {
          addressModel = value;
          addressList=List();
          for (int x = 0; x < addressModel.success.length; x++) {
            addressList.add(addressModel.success[x]);

            if (addressModel.success[x].isDefault == 1) {
              setState(() {
                GlobalVars.defaultAddress = addressModel.success[x];
                SelectedAddrssId = addressModel.success[x].id;
                currentAddress = addressModel.success[x].address;
                _onSelected(x);
              });
            }
          }

          // if(address.isNotEmpty || address.length == 0 || address.toString() != 'null'){
          //   setState(() {
          //     GlobalVars.defaultAddress = address[0];
          //   });
          // }
        });
      });
    });
  }

  getCurrentLocation() async {
    try {
      Position position = await Geolocator().getLastKnownPosition();
      setState(() {
        currentLong = position.longitude;
        currentLat = position.latitude;
      });
    } catch (_) {
      try {
        var my_location;
        my_location = await location.getLocation().then((dd) {
          setState(() {
            currentLat = dd.latitude;
            currentLong = dd.longitude;
          });
        });
      } catch (e) {
        print("location error $e");
      }
    }
    print("cuurentLat ${currentLat}");
    print("cuurentLat ${currentLong}");
  }

  // @override
  // Widget floatingActionButton() {
  //   // TODO: implement floatingActionButton
  //   return InkWell(
  //     onTap: () {
  //       if (SelectedAddrssId == null) {
  //         StaticUI().showSnackbar("Please choose address", _scaffoldKey);
  //       }
  //       if (widget.fromCheckOut) {
  //         GlobalVars.defaultAddress.address=currentAddress;
  //
  //         SetAddressBloc()
  //             .setAddressDefault(_scaffoldKey, SelectedAddrssId)
  //             .then((value) {
  //           Navigator.of(context).pop();
  //         });
  //       } else {
  //         SetAddressBloc()
  //             .setAddressDefault(_scaffoldKey, SelectedAddrssId)
  //             .then((value) {
  //
  //           navigateAndClearStack(
  //               context,
  //               MainScreen(
  //                 position: 2,
  //               ));
  //
  //         });
  //
  //       }
  //     },
  //     child: Container(
  //       child: Center(
  //           child: Text(
  //         "Confirm address",
  //         style: TextStyle(
  //             color: WHITE, fontWeight: FontWeight.bold, fontSize: 20),
  //       )),
  //       width: SizeConfig.safeBlockHorizontal * 90,
  //       height: 60,
  //       decoration: BoxDecoration(
  //           gradient: new LinearGradient(
  //             colors: [
  //               Color.fromRGBO(250, 159, 66, 1.0),
  //               Color.fromRGBO(238, 117, 42, 1.0)
  //             ],
  //             stops: [0.0, 1.0],
  //             begin: FractionalOffset.topCenter,
  //             end: FractionalOffset.bottomCenter,
  //           ),
  //           borderRadius: BorderRadius.circular(12)),
  //     ),
  //   );
  // }

  @override
  Widget getAppbar() {
    // TODO: implement getAppbar
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0.0,
      centerTitle: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            translator.translate("My"),
            style: TextStyle(
                color: Color(0xff212221),
                fontWeight: FontWeight.w400,
                fontSize: 30.0),
          ),
          SizedBox(
            width: 5.0,
          ),
          Text(
    translator.translate("Addresses"),
            style: TextStyle(
                color: Color(0xff212221),
                fontWeight: FontWeight.w700,
                fontSize: 30.0),
          )
        ],
      ),
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: Icon(
          Icons.arrow_back_ios,
          color: Color(0xff212221),
          size: 30,
        ),
      ),
    );
  }

  @override
  Widget getBody(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      child: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          children: [
            addressList==null?StaticUI().progressIndicatorWidget():
            addressList.length == 0 ||
                    addressList.isEmpty ||
                    addressList.toString() == 'null'
                ? Center(
                    child: Text(translator.translate('Empty')),
                  )
                : ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: addressList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () async {
                          _onSelected(index);
                          SelectedAddrssId = addressList[index].id;
                          currentAddress = addressModel.success[index].address;
                          if (widget.fromCheckOut) {
                            if (addressList[index].isDefault == 1) {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddressDetails(
                                      widget.fromCheckOut,
                                      AddressItem: addressList[index]),
                                ),
                              ).then((value) {
gettingData();
                              });
                            } else {
                              showLoadingDialog();

                              SetAddressBloc()
                                  .setAddressDefault(
                                      _scaffoldKey, SelectedAddrssId)
                                  .then((value) async {
                                hideDialog();
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddressDetails(
                                        widget.fromCheckOut,
                                        AddressItem: addressList[index]),
                                  ),
                                ).then((value) {
                                  gettingData();
                                });
                              });
                            }
                          } else {
                            if (addressList[index].isDefault == 1) {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddressDetails(
                                    widget.fromCheckOut,
                                    AddressItem: addressList[index],
                                  ),
                                ),
                              ).then((value) {
gettingData();                              });
                            } else {
                              showLoadingDialog();

                              SetAddressBloc()
                                  .setAddressDefault(
                                      _scaffoldKey, SelectedAddrssId)
                                  .then((value) async {
                                hideDialog();
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddressDetails(
                                      widget.fromCheckOut,
                                      AddressItem: addressList[index],
                                    ),
                                  ),
                                ).then((value) {
                                  gettingData();
                                });
                              });
                            }
                          }
                        },
                        child: Card(
                          margin: EdgeInsets.all(10),
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                          child: Center(
                            child: Container(
                                padding: EdgeInsets.all(20),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text("${addressList[index].address}"),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    InkWell(
                                      onTap: () async{
                                        _onSelected(index);
                                        SelectedAddrssId = addressList[index].id;
                                        currentAddress =
                                            addressModel.success[index].address;
                                        if (addressList[index].isDefault == 1) {
                                          await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => AddressDetails(
                                                widget.fromCheckOut,
                                                AddressItem: addressList[index],
                                              ),
                                            ),
                                          ).then((value) {
                                            gettingData();
                                          });
                                        } else {
                                          showLoadingDialog();

                                          SetAddressBloc()
                                              .setAddressDefault(_scaffoldKey,
                                                  SelectedAddrssId)
                                              .then((value)async {
                                            hideDialog();
                                            await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => AddressDetails(
                                                  widget.fromCheckOut,
                                                  AddressItem: addressList[index],
                                                ),
                                              ),
                                            ).then((value) {
                                              gettingData();
                                            });
                                          });
                                        }
                                      },
                                      child: Container(
                                        padding: EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 25,
                                              height: 25,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  border: Border.all(
                                                      color: colorsValues
                                                          .orangeColor)),
                                              child: _selectedIndex != null &&
                                                      _selectedIndex == index
                                                  ? Center(
                                                      child: Icon(
                                                      Icons.check,
                                                      color: colorsValues
                                                          .orangeColor,
                                                      size: 14,
                                                    ))
                                                  : Container(),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Container(
                                              child: Text(
                                                translator.translate("Default address"),
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    )
                                  ],
                                )),
                          ),
                        ),
                      );
                    }),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () async{

          await      Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SetAddress(
                              currentLat,
                              currentLong,
                              fromCheckOut: widget.fromCheckOut,
                            ))).then((value) {
                         //     gettingData();
          });
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: Container(
                  width: SizeConfig.safeBlockHorizontal * 50,
                  padding: EdgeInsets.all(10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 25,
                        height: 25,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border:
                                Border.all(color: colorsValues.orangeColor)),
                        child: Center(
                            child: Icon(
                          Icons.add,
                          color: colorsValues.orangeColor,
                          size: 14,
                        )),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        child: Text(translator.translate("Add new address")),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
