import 'package:connectivity/connectivity.dart';
import 'package:dealmart/resources/Strings.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class AppConfig {
  static final AppConfig shared = AppConfig._internal();
  ConnectivityResult _connectionStatus = ConnectivityResult.mobile;

  AppConfig._internal() {}
  LatLng userLocation = LatLng(0,0);



  void setConnection(ConnectivityResult status) {
    this._connectionStatus = status;
  }
  LatLng getUserLatlng() {
    return userLocation;
  }

  setUserLatlng(LatLng latlng){
    userLocation = latlng;
  }

  String getBaseUrl() {
    return "dealmart.herokuapp.com";
  }

  String getLang() {
    return Strings.english ? "English" : "Arabic";
  }

  int getLanguageId() {
    return getLang() == 'en' ? 1 : 2;
  }



  ConnectivityResult getConnectionStatus() {
    return _connectionStatus;
  }



  }


enum UserType {Customer}
