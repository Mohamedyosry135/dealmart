import 'package:dealmart/ui/MainScreens/DrawerWidget/MyAddress/model/Address_model.dart';
import 'package:dealmart/ui/MainScreens/ProfileScreen/model/EditProfileResponse.dart';
import 'package:dealmart/ui/MainScreens/model/userModel.dart';

class GlobalVars {
  static User userData = null;
  static List<String> favIds = List();
  static String cartLength = "0";
  static String Country = "+20";
  static String recharge_fees_amount = "0";
  static String order_fees_amount = "0";
  static String country_id = "1";
   static String Currency = "${ GlobalVars.Currency}";
  static Adress defaultAddress = Adress();
}