import 'package:dealmart/utils/global_vars.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// all  shared preferences keys (string)
String languageCodeKey = 'languageCode';
String countryCodeKey = 'countryCode';
String branchIDKey = 'branchId';
String userNameKey = 'userName';
String userIDKey = 'userId';
String userTokenKey = 'userToken';
String userCurrency = 'currency';
String userRECHARGEFeesAmount = 'RECHARGEFeesAmount';
String userORDERFeesAmount = 'ORDERFeesAmount';
String userCountryId = 'CountryId';
String isRememberPreference = 'isRememberPreference';
String cartLengthKey = 'cartLength';
String userToken;
String UserCurrency;
String RECHARGEFeesAmount;
String ORDERFeesAmount;
String CountryId;
String rechargeFeesAmount;
String orderFeesAmount;
String COUNTRYID;
String User;
// get device locale
getLanguageCode(BuildContext context) {
  return Localizations.localeOf(context).languageCode;
}

// save user preferred locale
setLocale(BuildContext context,
    {String preferredLanguageCode, String countryCode}) async {
  // step one, save the chosen locale
  var prefs = await SharedPreferences.getInstance();
  await prefs.setString(languageCodeKey, preferredLanguageCode);
  await prefs.setString(countryCodeKey, countryCode);
  // step two, rebuild the whole app, with the new locale
//  MyApp.setLocale(context, Locale(preferredLanguageCode, countryCode));
}

// save branch id
void saveAndUpdateBranchID(BuildContext context, {String branchID}) async {
  var prefs = await SharedPreferences.getInstance();
  await prefs.remove(branchIDKey);
  await prefs.setString(branchIDKey, branchID);
}

void removeKeyFromShared(BuildContext context,{String key}) async{
  var prefs = await SharedPreferences.getInstance();
  await prefs.remove('key');
}

// save user id
void saveAndUpdateUserID(BuildContext context, {String userID}) async {
  var prefs = await SharedPreferences.getInstance();
  await prefs.remove(userIDKey);
  await prefs.setString(userIDKey, userID);
}

// save user name
void saveAndUpdateUserName(BuildContext context, {String userName}) async {
  var prefs = await SharedPreferences.getInstance();
  await prefs.remove(userNameKey);
  await prefs.setString(userNameKey, userName);
}



//====================================================================
Future getUserToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userToken = prefs.getString(userTokenKey);
  if (userToken == null) setUserToken('');
}
Future getUserCurrency() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  UserCurrency = prefs.getString(userCurrency);


    RECHARGEFeesAmount=prefs.getString(userRECHARGEFeesAmount);
    ORDERFeesAmount=prefs.getString(userORDERFeesAmount);
    CountryId=prefs.getString(userCountryId);

  GlobalVars.recharge_fees_amount =RECHARGEFeesAmount;
  GlobalVars.order_fees_amount = ORDERFeesAmount;
  GlobalVars.country_id =CountryId;
  GlobalVars.Currency=UserCurrency;

print("order_fees_amount ${GlobalVars.order_fees_amount}");
print("recharge_fees_amount ${GlobalVars.recharge_fees_amount}");
print("recharge_fees_Currencya ${GlobalVars.Currency}");
print("recharge_fees_country_id ${GlobalVars.country_id}");



  if (UserCurrency == null) setUserToken('');
}
Future setUserToken(String token) async {
  userToken = token;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString(userTokenKey, userToken);
}
Future setUserCurrency(String currency,recharge_fees_amount,order_fees_amount,country_id) async {
    // rechargeFeesAmount=recharge_fees_amount;
    // orderFeesAmount=order_fees_amount;

  UserCurrency=currency;

      RECHARGEFeesAmount=recharge_fees_amount;
      ORDERFeesAmount=order_fees_amount;
      CountryId=country_id;

  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString(userCurrency, currency);
  // await prefs.setString(userCurrency, currency);
  await prefs.setString(userRECHARGEFeesAmount,RECHARGEFeesAmount );
  await prefs.setString(userORDERFeesAmount, ORDERFeesAmount);
  await prefs.setString(userCountryId,CountryId );
    // getUserCurrency();
}
//====================================================================
 bool remember = false;
 Future setRememberMe(bool rememb) async {
remember = rememb;
SharedPreferences prefs = await SharedPreferences.getInstance();
await prefs.setBool(isRememberPreference, rememb);
}

 Future getRememberMe() async {
SharedPreferences prefs = await SharedPreferences.getInstance();
remember = prefs.getBool(isRememberPreference);
if (remember == null) {
  setRememberMe(false);
}
else {
  getUserCurrency();
}
}

//======================================================================
String cartLength = "";
Future setCartLength(String length) async {
  print("cartLength ${length}");
  cartLength = length;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString(cartLengthKey, length);
}

Future<String> getCartLength() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  cartLength = prefs.getString(cartLengthKey);
  print("cartLength1 ${cartLength}");
  if (cartLength == null) setCartLength("0");
  return cartLength;

}