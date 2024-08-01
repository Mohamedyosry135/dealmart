import 'package:dealmart/ui/GeneralModels/GeneralAPi.dart';
import 'package:dealmart/ui/MainScreens/ProductsScreen/model/TodayWinnerModel.dart';
import 'package:dealmart/ui/Notifications/NotificationModel.dart';
import 'package:dealmart/utils/size_config.dart';
import 'package:dealmart/utils/static_ui.dart';
import 'package:flutter/material.dart';
import 'package:dealmart/utils/image_file.dart' as image_file;
import 'package:dealmart/utils/colors_file.dart' as colorsValues;
import 'package:localize_and_translate/localize_and_translate.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  NotificationModel notificationModel;
  List<NotificationItem> notificationsList;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNotifications();
  }

  getNotifications() {
    GeneralApi(context).getNotifications(_scaffoldKey).then((value) {
      notificationModel = value;
      notificationsList = List();

      notificationModel.success.data.forEach((element) {
        setState(() {
          notificationsList.add(element);
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        title: Center(
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(right: 20),
            child: Text(
            translator.translate("Notifications"),
             style: TextStyle(
                 color: Color(0xff212221),
                 fontWeight: FontWeight.w800,
                 fontSize: 25.0
             ),
                ),
          ),
        ),
        leading: IconButton(
          onPressed: (){
 Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios,color: Color(0xff212221),size: 23,),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 10, right: 10),
          width: SizeConfig.safeBlockHorizontal * 100,
          height: SizeConfig.safeBlockVertical * 90,
          child: notificationsList == null
              ? StaticUI().progressIndicatorWidget()
              : notificationsList.length == 0
                  ? StaticUI().NoDataFoundWidget()
                  : ListView.builder(
                      itemCount: notificationsList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          width: SizeConfig.safeBlockHorizontal * 100,
                           child: Column(
                            children: [
                              SizedBox(height: 30,),

                              ListTile(
                                leading: Container(
                                  decoration: BoxDecoration(                              color: colorsValues.whiteSix,
                                      borderRadius: BorderRadius.circular(15)),
                                    width: 78,
                                    height: 69,
                                    child: Center(child: Image.network("https://www.pngitem.com/pimgs/m/586-5869857_topic-push-notification-icon-push-notification-logo-png.png"))),
                                title: Container(
                                  width: SizeConfig.safeBlockHorizontal*80,
                                   child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        notificationsList[index].title ?? "",
                                        style: TextStyle(
                                            fontSize: 17,
                                            color: colorsValues.brownishGrey4),
                                      ),
                                      Text(
                                          GeneralApi(context). getDiffrenceTime(notificationsList[index].createdAt)
                                        ?? "",
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: colorsValues.pinkishGreyTwo),
                                      ),
                                    ],
                                  ),
                                ),
                                subtitle: Container(
                                  width: SizeConfig.safeBlockHorizontal * 80,
                                   child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 6,
                                      ),
                                      Text(
                                        notificationsList[index].body ?? "",
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: colorsValues.pinkishGrey),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        notificationsList[index].title ?? "",
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: colorsValues.oceanBlue),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 30,),
Container(width: SizeConfig.safeBlockHorizontal*90,height: 1,color: colorsValues.whiteSeven,)
                            ],
                          ),
                        );
                      }),
        ),
      ),
    );
  }
}
