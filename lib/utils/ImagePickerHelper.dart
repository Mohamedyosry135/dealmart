import 'dart:convert';
import 'dart:io';


import 'package:dealmart/resources/AppColors.dart';
import 'package:dealmart/resources/Strings.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:async';

import 'SneakBarHelper.dart';

/*
* class for fetching image from device
* */

class ImagePickerHelper {
  //MARK:- Custom Dialogue Alert
  Future<File> pickImage(BuildContext context, Function onFinish ) async {
    SneakbarHelper(context)
      ..setBackgroundColor(Colors.black26)
      ..setDuration(4)
      ..buildCustomBody(_getDialog(context, onFinish))
      ..show();
  }



  Widget _getDialog(BuildContext context, Function onFinish ) {
    return Container(
        height: 30,
        width: MediaQuery.of(context).size.width,
        child:Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            InkWell(
              onTap: (){
                _pick(ImageSource.gallery, onFinish );
              },
              child: Row(
                children: <Widget>[
                  Icon(Icons.photo_album,color: PRIMARY_COLOR,),
                  SizedBox(width: 10,),
                  Text(Strings.gallery(),style: TextStyle(color: WHITE,fontSize: 15,fontWeight: FontWeight.bold),),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 6),
              color: PRIMARY_COLOR,height: 1,),
            InkWell(
              onTap: (){
                _pick(ImageSource.camera, onFinish);
              },
              child: Row(
                children: <Widget>[
                  Icon(Icons.camera_alt,color: PRIMARY_COLOR,),
                  SizedBox(width: 10,),
                  Text(Strings.camera(),style: TextStyle(color: WHITE,fontSize: 15,fontWeight: FontWeight.bold),),
                ],
              ),
            )
          ],
        )

    );
  }

  //MARK:- Uploading image from
  void _pick(ImageSource source, Function onFinish ) async {
    var image = await ImagePicker.pickImage(source: source);
    onFinish(image);

  }


}

