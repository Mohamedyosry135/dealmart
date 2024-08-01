import 'dart:convert';

import 'package:dealmart/api/remote/API_PATHS.dart';
import 'package:dealmart/ui/MainScreens/MainScreen.dart';
import 'package:dealmart/utils/shared_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart'as http;
import 'package:dealmart/utils/navigator.dart';
import 'package:toast/toast.dart';

class AuthService{
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final facebookLogin = FacebookLogin();
  BuildContext context;
  Observable<FirebaseUser> user;
  Observable<Map<String,dynamic>> profile;
  PublishSubject loading = PublishSubject();
  Map userProfile;
  AuthService(this.context);


  Future<String> googleSignIn()async{
    loading.add(true);

    GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    if  (googleUser == null) {
      return "you canceled operation";
    }
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    AuthResult authResult = await _auth.signInWithCredential(credential);
//    updateUserData(user);
    FirebaseUser _user;
    _user = authResult.user;
    print("Sign in" + _user.displayName);
    print("Sign in" + _user.uid);
    if(_user.uid != null){
      return loginApi(_user.displayName,_user.email,_user.uid);
    }
    print("User Name: ${_user.displayName}");
    print("User Email ${_user.email}");

  }

  Future<String> facebookSignIn()async{
    final result = await facebookLogin.logIn(['email']);
//    print('canceaaal ${result.accessToken.token}');
//    print("NULLLL  ${result.accessToken.token.toString() == 'null'}");
    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final token = result.accessToken.token;

        final graphResponse = await http.get('https://graph.facebook.com/v2.12/me?fields=name,picture,email&access_token=${token}');
        final profile = json.decode(graphResponse.body);
        print(profile);
        print(result.accessToken.token);
          userProfile = profile;
          print(userProfile['name']);
          return loginApi(userProfile['name'], userProfile['email'], userProfile['id']);
          break;
      case FacebookLoginStatus.cancelledByUser:
        print('cancel ${result.status}');
        print('cancel ${result.errorMessage}');
        return result.errorMessage ;

        break;
      case FacebookLoginStatus.error:
        print('error ${result.status}');
        print('error ${result.errorMessage}');
        return result.errorMessage ;

        break;
    }

  }

  void signOut(){
    _auth.signOut();
  }

  Future<String> loginApi(String username,String email,String socialId)async{
    print("username ${username}");
    print("email ${email}");
    print("socialId ${socialId}");
    var response = await http.post(
      "https://dealmart.herokuapp.com${SOCIALAPI}",
      body: {
        "username" : username,
        "email" : email,
        "social_id" : socialId
      }
    );
    var body = json.decode(response.body);
    print("body ${body}");
    if(response.statusCode == 200){
      setRememberMe(true);
//      print("Token ${body['success']['token']}");
      if(body['success']==null){
        setUserToken(body['token']);
        return "200";
      }else  {
        setUserToken(body['success']['token']);
        return "200";
      }

    }else{
      FacebookLogin().logOut();
      GoogleSignIn().disconnect();
      FirebaseAuth.instance.signOut();
      Toast.show(body['error'], context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM,backgroundColor: Colors.red);
      return body['error'];
    }
  }
}
//final AuthService authService;