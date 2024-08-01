import 'package:dealmart/base/BaseStatefullWidget.dart';
import 'package:dealmart/resources/AppColors.dart';
import 'package:dealmart/ui/MainScreens/CartScreen/checkout_screen.dart';
import 'package:dealmart/ui/MainScreens/DrawerWidget/MyAddress/MyAddress.dart';
import 'package:dealmart/ui/MainScreens/DrawerWidget/MyAddress/address_details.dart';
import 'package:dealmart/ui/MainScreens/DrawerWidget/MyAddress/bloc/SetAddressBloc.dart';
import 'package:dealmart/ui/MainScreens/MainScreen.dart';
import 'package:dealmart/utils/image_file.dart';
import 'package:dealmart/utils/navigator.dart';
import 'package:dealmart/utils/size_config.dart';
import 'package:dealmart/utils/staticVar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
 import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:dealmart/utils/colors_file.dart' as colorsValues;
import 'package:localize_and_translate/localize_and_translate.dart';


class SetAddress extends BaseStatefulWidget {
  bool fromCheckOut=false;
  double lat,long;
  SetAddress(this.lat,this.long,{this.fromCheckOut});
  @override
  _SetAddressState createState() => _SetAddressState();
}
class _SetAddressState extends BaseState<SetAddress> {
  double lat = 0.0,
      long = 0.0;
  List data = List();
  Completer<GoogleMapController> _controller = Completer();
  bool cameraMoveStop = false;
  String address = ' ';
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocation(widget.lat, widget.long).then((res) {
      setState(() {
        address = res[0].addressLine;
        data.add(res[0].addressLine);
        data.add(lat.toString());
        data.add(long.toString());
      });
    });
    setState(() {
      long = widget.long;
      lat = widget.lat;
    });
    print("address ${address}");
  }

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, "");
      },
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: saveButton(),
        body: Stack(
          children: <Widget>[
            Stack(
              children: [
                Container(
//                  height: SizeConfig.screenHeight/1.3,
                  child: GoogleMap(
                    mapType: MapType.normal,
                    zoomControlsEnabled: false,
                    myLocationEnabled: true,
                    compassEnabled: false,
                    myLocationButtonEnabled: false,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(widget.lat, widget.long),
                      zoom: 14.4746,
                    ),
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                    markers: Set<Marker>.of(
                      <Marker>[
                        Marker(
                            draggable: true,
                            markerId: MarkerId("1"),
                            position: LatLng(lat, long),
                            icon: BitmapDescriptor.fromAsset(MY_LOCATION),
                            infoWindow: const InfoWindow(
                              title: "Ana",
                            )
                        )
                      ],
                    ),
                    onCameraIdle: () {
                      print('idle');
                      cameraMoveStop = true;
                      print(cameraMoveStop);

                      getLocation(lat, long).then((res) {
                        setState(() {
                          address = res[0].addressLine;
                          data.add(res[0].addressLine);
                          data.add(lat.toString());
                          data.add(long.toString());
                        });
                      });
                    },
                    onCameraMoveStarted: () {
                      print('start');
                      print(cameraMoveStop);
                    },
                    onCameraMove: (postion) {
                      print('ssss   ${postion.target}');
                      if (cameraMoveStop) {
                        print('stooped at ${postion.target}');
                        setState(() {
                          lat = postion.target.latitude;
                          long = postion.target.longitude;
                        });
                      }
                    },
                  ),
                ),

              ],
            ),

            appBar(),
          ],
        ),
      ),
    );
  }

  Future<void> _getCurrentLocation() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            bearing: 192.8334901395799,
            target: LatLng(widget.lat, widget.long),
            tilt: 59.440717697143555,
            zoom: 19.151926040649414
        )
    ));
  }

  Future<List<Address>> getLocation(var lat, var long) async {
    print('function  ${lat}  ${long}');
    final coordinates = new Coordinates(lat, long);
    var addresses =
    await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    print("adddresss  ${first.featureName} : ${first.addressLine}");
    return addresses;
  }

  Widget appBar() {
    return Positioned(
      top: 20.0,
      left: 10.0,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              icon: Icon(
                Icons.chevron_left,
                color: Colors.black,
                size: 30,
              ),
              onPressed: () {
                Navigator.pop(context, "");
              },
            ),
            SizedBox(height: 5.0,),
            Container(
              margin: EdgeInsets.only(left: 15.0, right: 15.0),
              child: Text(
                translator.translate("Address"),
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 35.0,
                    color: Colors.black
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget saveButton() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: _getCurrentLocation,
          child: Container(
            margin: EdgeInsets.only(left: 15.0,right: 15.0),
            alignment: Alignment.topRight,
            child: Icon(
              Icons.my_location,color: PRIMARY_COLOR,
              size: 40.0,

            ),
          ),
        ),
        SizedBox(height: 12.0,),
        Container(
          margin: EdgeInsets.only(left: 15.0,right: 15.0),
          height: 70,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: WHITE,
              borderRadius: BorderRadius.all(Radius.circular(15))
          ),
          child: Center(child: Row(
            children: [
              Image.asset(LOCATION,color: Color(0xfff85d0b),),
              SizedBox(width: 10,),
              Expanded(child: Text(address,overflow: TextOverflow.clip,)),
            ],
          )),
        ),
        InkWell(
          onTap: () {
           showLoadingDialog();
           // if(widget.fromCheckOut){
           //   SetAddressBloc().setAddress(
           //       _scaffoldKey,
           //       context,
           //       "${address}",
           //       "${lat}",
           //       "${long}"
           //   ).then((value){
           //     hideDialog();
           //
           //
           //     // Navigator.of(context).pop();
           //     // Navigator.of(context).pop();
           //     // Navigator.of(context).pop(address);
           //     // navigateAndKeepStack(context, MyAddress(fromCheckOut: true,));
           //     // navigateAndKeepStack(context, CheckoutScreen(productsList));
           //
           //
           //   });
           // }

           if(widget.fromCheckOut){
           Navigator.push(
             context,
             MaterialPageRoute(
               builder: (context) => AddressDetails(
                 widget.fromCheckOut,
                 Address: address,
                 isAddNew: true,lat:lat.toString() ,long: long.toString(),
               ),
             ),
           );
           }
           else {


             Navigator.push(
               context,
               MaterialPageRoute(
                 builder: (context) => AddressDetails(
                   widget.fromCheckOut,
                   Address: address,                     isAddNew: true,lat:lat.toString() ,long: long.toString(),

                 ),
               ),
             );

             // SetAddressBloc().setAddress(
             //     _scaffoldKey,
             //     context,
             //     "${address}",
             //     "${lat}",
             //     "${long}"
             // ).then((value){
             //
             //   // hideDialog();
             //   // Navigator.of(context).pop();
             //   // Navigator.of(context).pop(address);
             //   // navigateAndClearStack(context, MainScreen(position: 2,));
             // });
           }

//             navigateAndKeepStack(context, AddressDetails(
//               lat: "${lat}",
//               lng: "${long}",
//               address: address,
//             ));
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
    );
  }

  @override
  Widget getAppbar() {
    // TODO: implement getAppbar
    return PreferredSize(
      preferredSize: Size.fromHeight(0.0),
      child: AppBar(
        elevation: 0,
      ),
    );
  }

  @override
  Widget getBody(BuildContext context) {
    // TODO: implement getBody
    throw UnimplementedError();
  }
}