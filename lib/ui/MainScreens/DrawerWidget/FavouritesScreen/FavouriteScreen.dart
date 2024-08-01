import 'dart:async';

import 'package:dealmart/base/BaseStatefullWidget.dart';
import 'package:dealmart/ui/MainScreens/CartScreen/bloc/CartBloc.dart';
import 'package:dealmart/ui/MainScreens/MainScreen.dart';
import 'package:dealmart/ui/MyFavouritesScreens/bloc/GetFavourite.dart';
import 'package:dealmart/ui/MyFavouritesScreens/model/FavouriteModel.dart';
import 'package:dealmart/utils/navigator.dart';
import 'package:dealmart/utils/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dealmart/utils/colors_file.dart' as colors;
import 'package:dealmart/utils/image_file.dart' as images;
import 'package:dealmart/utils/static_ui.dart' ;
import 'package:dealmart/utils/global_vars.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class FavouriteScreen extends BaseStatefulWidget {
  @override
  _FavouriteScreenState createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends BaseState<FavouriteScreen> {
  var name = "name";
  var details = "details details detailsdetails details details details details details detailsdetailsdetailsdetailsdetailsdetailsdetails";
  var price = "100"+" ${ GlobalVars.Currency}";
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  FavouriteModel favouriteModel;
   @override
  Widget getAppbar() {
    // TODO: implement getAppbar
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0.0,
      centerTitle: true,

      title: Center(
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                translator.translate("My"),
                style: TextStyle(
                    color: Color(0xff212221),
                    fontWeight: FontWeight.w400,
                    fontSize: 21.0
                ),
              ),
              SizedBox(width: 3.0,),
              Text(
                translator.translate("Favourites"),
                style: TextStyle(
                    color: Color(0xff212221),
                    fontWeight: FontWeight.w700,
                    fontSize: 23.0
                ),
              )
            ],
          ),
        ),
      ),
      leading: IconButton(
        onPressed: (){
          navigateAndClearStack(context,  MainScreen(position: 2,));

        },
        icon: Icon(Icons.arrow_back_ios,color: Color(0xff212221),size: 23,),
      ),
    );
  }
  List<FavouriteItem> favouriteItem = List();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(milliseconds: 200), () {
      showLoadingDialog();
      GetFavouritesBloc().getFavourites(_scaffoldKey).then((value){
        hideDialog();
        setState(() {
          GlobalVars.favIds = List();
          favouriteModel = value;
          favouriteModel.favouriteItem.forEach((element) {
            favouriteItem.add(element);

            GlobalVars.favIds.add(element.productId.toString());
          });
        });
      });

    });


  }

  Future<bool> closeApp(){
    StaticUI().closeApp(context);
  }
  @override
  Widget getBody(BuildContext context) {
    SizeConfig().init(context);
    return WillPopScope(
      onWillPop: closeApp,
      child: SafeArea(child:  SingleChildScrollView(
        child: Container(
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              favouriteItem.length == 0 || favouriteItem.isEmpty || favouriteItem.toString() == 'null'?
            StaticUI().NoDataFoundWidget():
              // Center(child: Text('No favorite added'),):
              ListView.builder(
                  primary: true,
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: favouriteItem.length,
                  itemBuilder: (buildContext, index){
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),),
                        child: ClipRRect(
                          borderRadius:BorderRadius.circular(10),
                          child: Container(
                            child: Slidable(
                              actionPane: SlidableDrawerActionPane(),

                              actionExtentRatio: 0.22,
                              child: Stack(children: [
                                Positioned(top: 0,left: 0,bottom: 0,child: Container(width: 20,color: colors.tomato,)),
                                Positioned(top: 0,right: 0,bottom: 0,child: Container(width: 20,color: colors.apple,)),

                                Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: colors.whiteColor),
                                  child: Container(
                                    padding: EdgeInsets.only(left: 15,right: 5,top: 5,bottom: 0),
                                    decoration: BoxDecoration(borderRadius:  BorderRadius.circular(10),border: Border.all(color: colors.greyBorder.withOpacity(.2)),color: colors.greyBorder.withOpacity(.5)),
                                    child: Column(
                                      children: [
                                        Container(padding: EdgeInsets.only(top: 4,right: 8),
                                          child: Align(alignment: Alignment.topRight,
                                            child: InkWell(
                                              child: favouriteItem[index].product.isFavourit == 1 ? Icon(
                                                Icons.favorite,
                                                color: colors.orangeColor,
                                                size: 25,
                                              ) : Icon(
                                                FontAwesome.heart_o,
                                                color:Color.fromRGBO(
                                                    249, 115, 2, 1),
                                                size: 25,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              flex: 2,
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  ClipRRect(  borderRadius:BorderRadius.circular(10),

                                                    child: ClipRRect(borderRadius: BorderRadius.circular(12),
                                                      child: FadeInImage.assetNetwork(fit: BoxFit.fill,
                                                        placeholder: images.car,
                                                        image: "https://dealmart.herokuapp.com/products/${favouriteItem[index].product.id}/${favouriteItem[index].product.numberPhotos}.jpg",
                                                        width: SizeConfig.safeBlockVertical * 14,
                                                        height: SizeConfig.safeBlockVertical * 13,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: Container(
                                                margin: EdgeInsets.only(left: 0,right: 8),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      favouriteItem[index].product.name,
                                                      style: TextStyle(
                                                          fontSize: 17,
                                                          fontWeight: FontWeight.w700
                                                      ),

                                                    ),
                                                    Text(
                                                      favouriteItem[index].product.description,
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.w400,
                                                          color: colors.greyColorXd.withOpacity(.7),height: 1.5
                                                      ),
                                                    ),
                                                    SizedBox(height: 6.0,),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "${favouriteItem[index].product.price}",
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight: FontWeight.w600,
                                                              color: colors.blackColor
                                                          ),
                                                        ),
                                                        SizedBox(width: 5.0,),
                                                        Text(
                                                          "${ GlobalVars.Currency}",
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight: FontWeight.w400,
                                                              color: Color(0xff676767)
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),

                                          ],),
                                        SizedBox(height:16,),




                                      ],crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.start,),),
                                )
                              ],),

                              actions: <Widget>[
                                IconSlideAction(
                                  onTap: (){
                                    showLoadingDialog();
                                    GetFavouritesBloc().removeFromFavourites(_scaffoldKey, favouriteItem[index].productId.toString()).then((value){
                                      hideDialog();
                                      setState(() {
//                                    GlobalVars.favIds.removeAt(GlobalVars.favIds.indexOf(favouriteItem[index].productId.toString()));
                                      });
                                      navigateAndClearStack(context, MainScreen(position: 1,));
                                    });
                                  },
                                  caption: 'Delete',
                                  foregroundColor: colors.whiteColor,
                                  color: colors.tomato,
                                  iconWidget: Container(padding: EdgeInsets.only(bottom: 5),child: Icon(Icons.delete_outline,color: colors.whiteColor,size: 35,)) ,
                                ),
                              ],
                            secondaryActions: <Widget>[
                              IconSlideAction(
                                onTap: favouriteItem[index].product.amount == 0.0
                                    ? null:(){
                                  showLoadingDialog();
                                  CartBloc().addToCart(_scaffoldKey,favouriteItem[index].product.id,1).then((value){
                                    hideDialog();
                                    navigateAndKeepStack(context, MainScreen(position: 3,));
                                    //   showSnack('Added successfully');
                                  });
                                },
                                caption: 'Reorder',
                                color: colors.apple,
                                foregroundColor: colors.whiteColor,
                                iconWidget: Container(padding: EdgeInsets.only(bottom: 5),child: Icon(Icons.refresh,color: colors.whiteColor,)) ,
                              ),


                            ],
                            ),
                          ),
                        ),
                      ),
                    );

                    Container(margin:  EdgeInsets.only(bottom: 30),padding: EdgeInsets.all(16.0) ,decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),border: Border.all(color: colors.greyBorder)),child: Column(children: [

                      Row(mainAxisAlignment: MainAxisAlignment.start,children: [
                        Image.asset(images.home,width: SizeConfig.safeBlockVertical*11,height:SizeConfig.safeBlockVertical*11 ,),
                        Flexible(
                          child: Container(height:SizeConfig.safeBlockVertical*11 ,
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                              Container(
                                child: Align(alignment: Alignment.topRight,child: InkWell(child: Icon(Icons.clear,color: colors.blackColor,),onTap: (){
                                  //clear item action
                                },),),
                              ),
                              Text(name,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),maxLines: 1,),
                              Text(details,style: TextStyle(fontSize: 13,fontWeight: FontWeight.normal,color: colors.brownishGrey),maxLines: 1,),
                              Text(name,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w300,color: colors.blackColor),maxLines: 1,)
                            ],),
                          ),
                        )
                      ],),
                      Row(mainAxisAlignment: MainAxisAlignment.start,children: [
                        GestureDetector(onTap: (){},child: Container(padding: EdgeInsets.all(4),child:Image.asset(images.products) ,width: 29,height: 29,decoration: BoxDecoration(borderRadius: BorderRadius.circular(29),color: colors.brownishGrey2,),))
                        ,SizedBox(width: 4,),GestureDetector(onTap: (){},child: Container(padding: EdgeInsets.all(4),child:Center(child: Text("1",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),)) ,width: 29,height: 29,decoration: BoxDecoration(borderRadius: BorderRadius.circular(29),),))
                        ,SizedBox(width: 4,),GestureDetector(onTap: (){},child: Container(padding: EdgeInsets.all(4),child:Image.asset(images.products) ,width: 29,height: 29,decoration: BoxDecoration(borderRadius: BorderRadius.circular(29),color: colors.brownishGrey2,),))


                      ],),



                    ],crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.start,),);
                  }),


        ],) ,padding: EdgeInsets.only(left: 16,right: 16,top: 30,bottom: 30),),
      ),),
    );
  }
}
