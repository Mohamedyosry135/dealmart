
import 'package:dealmart/resources/AppColors.dart';
import 'package:dealmart/resources/AppColors.dart';
import 'package:dealmart/ui/MainScreens/CartScreen/WebviewScreen.dart';
import 'package:dealmart/ui/MainScreens/DrawerWidget/MyAddress/MyAddress.dart';
import 'package:dealmart/ui/MainScreens/DrawerWidget/MyAddress/address_details.dart';
import 'package:dealmart/ui/MainScreens/DrawerWidget/WalletScreen/WalletScreen.dart';
import 'package:dealmart/ui/MainScreens/MainScreen.dart';
 import 'package:dealmart/ui/WelcomeScreen/WelcomeScreen.dart';
import 'package:dealmart/ui/WinnersScreen/WinnersScreen.dart';
 import 'package:dealmart/ui/signUp/RegistScreen.dart';
import 'package:dealmart/ui/signUp/termsAndConditions.dart';
import 'package:dealmart/ui/sign_in/SignIn.dart';
import 'package:dealmart/ui/splash/SplashScreen.dart';
import 'package:dealmart/utils/shared_utils.dart';
import 'package:dealmart/utils/shared_utils.dart';
import 'package:dealmart/utils/shared_utils.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import 'ui/signUp/VerificationCodeScreen.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  getRememberMe().then((value) async{
    await getUserToken();
    await translator.init(
      localeDefault: LocalizationDefaultType.device,
      languagesList: <String>['ar', 'en'],
      assetsDirectory: 'assets/langs/',
      //  apiKeyGoogle: '<Key>', // NOT YET TESTED
    );
    runApp(LocalizedApp(child: MyApp()));
  });

}
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState(){
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    WidgetsFlutterBinding.ensureInitialized();
    final FirebaseDatabase database = FirebaseDatabase(app: FirebaseApp.instance,);

    database.reference().onValue.listen((event) {
      print(event.snapshot.value);
      if (event.snapshot.value["enable"] == false){
        SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      }
    });
  }

      @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
        key: _scaffoldKey,
        debugShowCheckedModeBanner: false,

        localizationsDelegates: [

          GlobalMaterialLocalizations.delegate,

          GlobalWidgetsLocalizations.delegate,

          GlobalCupertinoLocalizations.delegate,

          DefaultCupertinoLocalizations.delegate,

        ],

        locale: translator.locale,
        supportedLocales: translator.locals(),

        routes: <String, WidgetBuilder>{
          '/sign_in': (BuildContext context) => SignIn(),
        },
        theme: ThemeData(
          primaryColor: PRIMARY_COLOR,
          fontFamily: 'PoppinsRegular',
        ),
 //        home:SignIn()
//        home:RegistScreen()
//        home:RegistScreen()
       // home:VerificationCodeScreen()
//        home:WinnersScreen()
//        home:WelcomeScreen()
//         home:WalletScreen()
//         home:URLWebView(cowpay_url: "http://dealmart.herokuapp.com/api/otp/229095",cowpay_reference_id: "3",)
        home:SplashScreen()
//         home:AddressDetails(address: "King Abdullah St, 123, jeddah ",lat: "35.33445",lng: "32.55555",)
//        home:MyFavouritesScreen()
//        home: MainScreen(position: 2,)
//        home: SplashScreen()
      //  home: Test()
    );
  }


}

