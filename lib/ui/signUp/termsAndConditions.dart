import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:localize_and_translate/localize_and_translate.dart';




class TermsAndConditions extends StatefulWidget {

  @override
  TermsAndConditionsState createState() => TermsAndConditionsState();
}

class TermsAndConditionsState extends State<TermsAndConditions> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  InAppWebViewController webView;
  String url = "https://dealmart.herokuapp.com/api/terms/en";
  double progress = 0;

  @override
  Widget build(BuildContext context) {
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
                  translator.translate("Terms and conditions"),
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
              Navigator.pop(context);} ,
            icon: Icon(Icons.arrow_back_ios,color: Color(0xff212221),size: 20,),
          ),
        )
        ,
        body: Container(
            child: InAppWebView(
              initialUrl: url,
              initialHeaders: {},
              initialOptions: InAppWebViewGroupOptions(

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


