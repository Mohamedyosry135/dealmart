import 'package:dealmart/api/AppConfig.dart';
import 'package:dealmart/loading/LoadingDialog.dart';
import 'package:dealmart/resources/AppColors.dart';
import 'package:dealmart/resources/Strings.dart';
import 'package:dealmart/utils/LayoutUtils.dart';
import 'package:dealmart/utils/global_vars.dart';
import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';


final RouteObserver<PageRoute> routeObserver = new RouteObserver<PageRoute>();

abstract class BaseStatefulWidget extends StatefulWidget {

}

abstract class BaseState<T extends BaseStatefulWidget> extends State<T>
    with RouteAware {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool resizeToAvoidBottomPadding ;
  BaseState({this.resizeToAvoidBottomPadding = true});

  @override
  void initState() {
    super.initState();


  }
  @override
  Widget build(BuildContext context) {
    print("defaultAddressdefaultAddress ${GlobalVars.defaultAddress.address}");

    return LayoutUtils.wrapWithtinLayoutDirection(
        Scaffold(
      resizeToAvoidBottomPadding: resizeToAvoidBottomPadding,
        backgroundColor: getBackGround(),
        key: getScreenKey,
        appBar: getAppbar(),
        drawer: getDrawer(),
        floatingActionButtonLocation: floatingActionButtonLocation(),
        floatingActionButton: floatingActionButton(),
        body: StreamBuilder<ConnectivityResult>(
            stream: Connectivity().onConnectivityChanged,
            initialData: AppConfig.shared.getConnectionStatus(),
            builder: (BuildContext context,
                AsyncSnapshot<ConnectivityResult> snapshot) {
              AppConfig.shared.setConnection(snapshot.data);
              if (snapshot.data == ConnectivityResult.none) {
               // return getNotConnectedBody();
                return GestureDetector(
                    onTap: (){
                      FocusScope.of(context).requestFocus(new FocusNode());
                    },
                    child: getBody(context));
              } else {
                return GestureDetector(
                    onTap: (){
                      FocusScope.of(context).requestFocus(new FocusNode());
                    },
                    child: getBody(context));
              }
            }),
      bottomNavigationBar: getBottomNaviagationBar(),

    ));
  }

  void openDrawer(){
    _scaffoldKey.currentState.openDrawer();
  }

  Widget getDrawer(){
    return null;
  }
  Widget floatingActionButton(){
    return null;
  }

  FloatingActionButtonLocation floatingActionButtonLocation(){
    return null;
  }

  Widget getBottomNaviagationBar(){
    return null;
  }

  Widget getAppbar();

  Color getBackGround() {
    return WHITE;
  }

  get getScreenKey {
    return _scaffoldKey;
  }

  Widget getBody(BuildContext context);

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  getNotConnectedBody() {
    return Center(
        child: Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.3,
      padding: EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(Strings.getNoInternetConnection(),
              style: TextStyle(
                  color: PRIMARY_COLOR,
                  fontSize: 18,
                  fontWeight: FontWeight.w500)),
          Container(
            height: 20.0,
          ),
          Text(Strings.getNOINTERNET_SUB_TXT(),
              overflow: TextOverflow.clip,
              textAlign: TextAlign.center,
              maxLines: 3,
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                  fontWeight: FontWeight.w500))
        ],
      ),
    ));
  }

  LoadingDialog loadingDialog;

  void hideDialog() {
    if (loadingDialog != null && loadingDialog.isShowing()) {
      Navigator.of(context).pop();
      loadingDialog = null;
    }
  }

  void showLoadingDialog() async {
    if(loadingDialog == null)
      loadingDialog = LoadingDialog();
    await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => loadingDialog);
  }

  void showSnack(String msg,{Widget content}) async {
    await hideDialog();
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: content==null?Text(msg):content));
  }
  void hideSnack() async {
    _scaffoldKey.currentState.hideCurrentSnackBar();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context));
  }
  @override
  void didUpdateWidget(T oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  // Called when the top route has been popped off, and the current route shows up.
  void didPopNext() {
    debugPrint("didPopNext $runtimeType");
    setState(() {});
  }

}
