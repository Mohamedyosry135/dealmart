import 'dart:async';

import 'package:dealmart/ui/GeneralModels/GeneralAPi.dart';
import 'package:dealmart/utils/global_vars.dart';
import 'package:dealmart/utils/navigator.dart';
import 'package:dealmart/utils/shared_utils.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:dealmart/utils/colors_file.dart' as colors;
//import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:toast/toast.dart';

import 'FailCheckOut.dart';
import 'SuccessCheckOut.dart';
import 'bloc/CartBloc.dart';



class URLWebView extends StatefulWidget {
  final String cowpay_reference_id;
  final String cowpay_url;
  final int transaction_id ;
  final bool isWallet;
  URLWebView({this.cowpay_reference_id,this.cowpay_url,this.transaction_id,this.isWallet});
  @override
  URLWebViewState createState() => URLWebViewState();
}

class URLWebViewState extends State<URLWebView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  InAppWebViewController webView;
  String url = "";
  double progress = 0;
  Timer timer;

  @override
  void initState() {
    super.initState();
  timer = Timer.periodic(Duration(seconds: 10), (Timer t) => _checkSuccessPayment(widget.transaction_id));
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  _checkSuccessPayment(int transaction_id){
    // FlutterWebBrowser
    CartBloc().checkTarnsaction(_scaffoldKey, '${transaction_id}').then((value)  {
      if (value == -1 ){
        timer.cancel();
        Toast.show("Failed to received money ", context, backgroundColor: Colors.red);
        timer =  Timer.periodic(Duration(seconds: 5), (Timer t) {
          timer.cancel();
          Navigator.pop(context);
        });
      }
      else if (value == 1 ){
        if (widget.isWallet){
          Toast.show("received money succeed", context, backgroundColor: Colors.green);
          timer =  Timer.periodic(Duration(seconds: 4), (Timer t) {
            timer.cancel();
            Navigator.pop(context);
          });
        }else{
          if (GlobalVars.defaultAddress.address.toString() == 'null') {
            Toast.show("Please Choose Address", context,
                duration: Toast.LENGTH_SHORT,
                gravity: Toast.BOTTOM,
                backgroundColor: Colors.red);
          } else {
            CartBloc().buyAllCart(_scaffoldKey).then((value) {
              if (value == "200") {
                GlobalVars.cartLength = "0";
                navigateAndClearStack(context, SuccessCheckOut());
              } else {
                navigateAndKeepStack(context, FailCheckOut());
                Toast.show("${value}", context,
                    duration: Toast.LENGTH_SHORT,
                    gravity: Toast.BOTTOM,
                    backgroundColor: Colors.red);
              }
            });
          }
        }

      }
    });
  }
  @override
  Widget build(BuildContext context) {
    print(widget.cowpay_url);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
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
                  translator.translate("Confirm payment method"),
                  style: TextStyle(
                      color: Color(0xff212221),
                      fontWeight: FontWeight.w700,
                      fontSize: 18
                  ),
                )
              ],
            ),
          ),
          leading: IconButton(

            onPressed: (){
              timer.cancel();
              Navigator.pop(context);} ,
            icon: Icon(Icons.arrow_back_ios,color: Color(0xff212221),size: 20,),
          ),
        )
        ,
        body: Container(
            child: InAppWebView(
              initialUrl: widget.cowpay_url,
              initialHeaders: {},
              initialOptions: InAppWebViewGroupOptions(
                ios: IOSInAppWebViewOptions(
                  sharedCookiesEnabled: true,

                ),

                  crossPlatform: InAppWebViewOptions(
                    debuggingEnabled: true,
                  )
              ),

                onPrint: (InAppWebViewController controller, message) {
                },
              onConsoleMessage: (InAppWebViewController controller, message) {
              },
              onWebViewCreated: (InAppWebViewController controller) {
                webView = controller;
              },
              onLoadStart: (InAppWebViewController controller, String url) {
                setState(() {
                  this.url = url;
                });
              },
              onLoadStop: (InAppWebViewController controller, String url) async {
                setState(() {
                  this.url = url;
                });
              },
              onProgressChanged: (InAppWebViewController controller, int progress) {
                setState(() {
                  this.progress = progress / 100;
                });
              },
            )),
      ),
    );
  }
}


