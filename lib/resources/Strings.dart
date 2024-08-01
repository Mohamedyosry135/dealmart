import 'package:flutter/services.dart';

import 'ArabStrings.dart';
import 'EngStrings.dart';

class Strings{
  static bool english = true;
  static List<TextInputFormatter> preventedSpecialCharacters = [BlacklistingTextInputFormatter(new RegExp(r'_|[^\w\s\u0621-\u064A]+')), BlacklistingTextInputFormatter(new RegExp(r'^\s*'))];

  static setLanguage(bool english)  {
    Strings.english = english;
  }
  static String getNoInternetConnection() {
    return english ? EngStrings.NO_INTERNET : ArbStrings.NO_INTERNET;
  }

  static String getNOINTERNET_SUB_TXT() {
    return english ? EngStrings.NO_INTERNET_SUB_TXT : ArbStrings.NO_INTERNET_SUB_TXT;
  }
  static String txt_get_started() {
    return english ? EngStrings.txt_get_started : ArbStrings.txt_get_started;
  }

  static String next() {
    return english ? EngStrings.next : ArbStrings.next;
  }

  static String skip() {
    return english ? EngStrings.skip : ArbStrings.skip;
  }

  static String confirmYourNumber() {
    return english ? EngStrings.ConfirmYourNumber : ArbStrings.ConfirmYourNumber;
  }

  static String enterVerificationCode() {
    return english ? EngStrings.EnterVerificationCode : ArbStrings.EnterVerificationCode;
  }

  static String sendToThisNumber() {
    return english ? EngStrings.SendToThisNumber : ArbStrings.SendToThisNumber;
  }
  static String confirm() {
    return english ? EngStrings.confirm : ArbStrings.confirm;
  }
  static String enterMobileNumber() {
    return english
        ? EngStrings.enterMobileNumber
        : ArbStrings.enterMobileNumber;
  }

  static String txt_enter_full_name() {
    return english
        ? EngStrings.txt_enter_full_name
        : ArbStrings.txt_enter_full_name;
  }

  static String txt_error_password_length() {
    return english
        ? EngStrings.txt_error_password_length
        : ArbStrings.txt_error_password_length;
  }

  static String txt_error_confirm_passLword() {
    return english
        ? EngStrings.txt_error_confirm_passLword
        : ArbStrings.txt_error_confirm_passLword;
  }
  static String txt_valid_email() {
    return english
        ? EngStrings.txt_valid_email
        : ArbStrings.txt_valid_email;
  }

  static String txt_error_phone_number() {
    return english
        ? EngStrings.txt_error_phone_number
        : ArbStrings.txt_error_phone_number;
  }

  static String txt_error_unique_user() {
    return english
        ? EngStrings.txt_error_unique_user
        : ArbStrings.txt_error_unique_user;
  }
  static String txt_error() {
    return english
        ? EngStrings.txt_error
        : ArbStrings.txt_error;
  }

  static String gallery() {
    return english ? EngStrings.GALLERY : ArbStrings.GALLERY;
  }

  static String camera() {
    return english ? EngStrings.CAMERA : ArbStrings.CAMERA;
  }

  static String acceptTermsAndCondation() {
    return english ? EngStrings.acceptTermsAndCondation : ArbStrings.acceptTermsAndCondation;
  }


}
