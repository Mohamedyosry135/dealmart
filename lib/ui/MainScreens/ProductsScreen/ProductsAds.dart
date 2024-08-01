import 'package:better_player/better_player.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dealmart/resources/AppColors.dart';
import 'package:dealmart/ui/MainScreens/ProductsScreen/bloc/ProductBloc.dart';
import 'package:dealmart/ui/MainScreens/ProductsScreen/model/SliderModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:localize_and_translate/localize_and_translate.dart';


class ProductsAds extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new ProductsAdsState();
  }
}

class ProductsAdsState extends State<ProductsAds> {

  SliderModel sliderModel;
  List<Result> map<Result>(List list, Function handler) {
    List<Result> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }

    return result;
  }
  int _current = 0;

  List<String> ads = List();
String videoUrl="https://dealmart.herokuapp.com/";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ProductBloc().getSilderData().then((value) {
setState(() {
  sliderModel=value;
  // ads.add("https://dealmart.herokuapp.com/slider/video1.mp4");
  // ads.add("https://dealmart.herokuapp.com/slider/video2.mp4");
  // ads.add("https://dealmart.herokuapp.com/slider/video3.mp4");

  ads.add(videoUrl+sliderModel.success.fileLink1);
  ads.add(videoUrl+sliderModel.success.fileLink2);
  ads.add(videoUrl+sliderModel.success.fileLink3);
});
    });



    // ads.add('https://media.istockphoto.com/photos/car-on-asphalt-road-in-summer-picture-id932645662');
    // ads.add('https://media.istockphoto.com/photos/suv-parked-on-the-road-near-forest-at-sunrise-picture-id1049724904');
    // ads.add('https://media.istockphoto.com/photos/modern-black-metallic-sedan-car-in-spotlight-banner-picture-id921871456');
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height/2,
            width: MediaQuery.of(context).size.width,
            child:Column(
            children: <Widget>[
              ads.length==0?Container():   CarouselSlider(
                  height: MediaQuery.of(context).size.height/2,
                  items: map<Widget>(ads, (index, i) {
                    if(  ads[index].toString().contains('mp4')){
                      return BetterPlayer.network(
                        ads[index], betterPlayerConfiguration: BetterPlayerConfiguration(
                        aspectRatio: 4 / 6,
                      ),

                      );
                    }
                    else {
                                          return Container(
                      child: FadeInImage.assetNetwork(
                          placeholder: 'images/ads.png',
                          image: ads[index],
                        fit: BoxFit.fill,
//                        height: ,
                      ),

                    );
                    }



                  }),
                  // autoPlay: true,
                  viewportFraction: 1.0,
                  aspectRatio: 2.0,
                  onPageChanged: (index) {
                    setState(() {
                      _current = index;
                    });

                  }
              ),
            ],
          )
        ),
        Positioned(
          bottom: 20,
          left: 10,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(translator.translate('New Shopping'),style: TextStyle(color: WHITE,fontSize: 20,fontWeight: FontWeight.normal),),
              Text(translator.translate('Experience!'),style: TextStyle(color: WHITE,fontSize: 30,fontWeight: FontWeight.bold),),

              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 10,bottom: 20),
                    padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                      decoration: BoxDecoration(
                        color: PRIMARY_COLOR,
                        borderRadius: BorderRadius.all(Radius.circular(25))
                      ),
                      child: Center(
                          child:
                          Text(translator.translate('Shop & Win!'),style: TextStyle(color: WHITE,fontSize: 16,fontWeight: FontWeight.normal),))),
                  SizedBox(width: 50,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:
                    ads.map((url) {
                      int index = ads.indexOf(url);
                      return Container(
                        width: 14.0,
                        height: 14.0,
                        margin: EdgeInsets.only(top: 10, left: 4.0,right: 4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Color(0xff9b9b9b)),
                          color: _current == index
                              ? Color(0xffffffff)
                              : Color(0xff9b9b9b),
                        ),
                      );
                    }).toList(),

                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

  }
}
