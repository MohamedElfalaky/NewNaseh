// ignore_for_file: file_names
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static SharedPreferences? sharedPrefs;

  Future<void> init() async {
    // SharedPreferences.setMockInitialValues({});
    sharedPrefs = await SharedPreferences.getInstance();
  }

  String get fCMToken => sharedPrefs!.getString(fCMKey) ?? "";

  int get cartAmoun => sharedPrefs!.getInt(cartAmount) ?? 0;

  bool getIsUnBoarded() {
    return sharedPrefs!.getBool(keyUnBoarded) ?? false;
  }

  bool getPickDialogHasBeenShown() {
    return sharedPrefs!.getBool(keyShowPickDialog) ?? false;
  }

  bool getIsSignedIn() {
    return sharedPrefs!.getBool(keySignedIn) ?? false;
  }

  String getUserName() {
    return sharedPrefs!.getString(keyUserName) ?? "";
  }

  String getUserPhoto() {
    return sharedPrefs!.getString(keyUserPhoto) ?? "";
  }

  setIsUnBoarded(bool value) {
    sharedPrefs!.setBool(keyUnBoarded, value);
  }

  setPickDialogHasBeenShown(bool value) {
    sharedPrefs!.setBool(keyShowPickDialog, value);
  }

  setUserName(String value) {
    sharedPrefs!.setString(keyUserName, value);
  }

  setUserPhoto(String value) {
    sharedPrefs!.setString(keyUserPhoto, value);
  }

  setIsSignedIn(bool value) {
    sharedPrefs!.setBool(keySignedIn, value);
  }

  String getToken() {
    return sharedPrefs!.getString(keyToken) ?? '';
  }

  setToken(String value) {
    sharedPrefs!.setString(keyToken, value);
  }

  int? getReceiveMethod() {
    return sharedPrefs!.getInt(receiveMethodKey) ?? null;
  }

  setReceiveMethod(int value) {
    sharedPrefs!.setInt(receiveMethodKey, value);
  }

  setAmount(int value) {
    sharedPrefs!.setInt(cartAmount, value);
  }

  setFCM(String value) {
    sharedPrefs!.setString(fCMKey, value);
  }

  void removeToken() {
    sharedPrefs!.remove(keyToken);
  }

  void removeAmount() {
    sharedPrefs!.remove(cartAmount);
  }

  String getLanguage() {
    return sharedPrefs!.getString(langCode) ?? '';
  }

  setLanguage(String value) {
    sharedPrefs!.setString(langCode, value);
  }

  setIsCurrentAddress(bool value) {
    sharedPrefs!.setBool(currentAddress, value);
  }

  bool getCurrentAddress() {
    return sharedPrefs!.getBool(currentAddress) ?? true;
  }

  setId(int value) {
    sharedPrefs!.setInt(idKey, value);
  }

  getId() {
    return sharedPrefs!.getInt(idKey);
  }

}

final sharedPrefs = SharedPrefs();

// constants/strings.dart
String keyToken = "key_token";
String fCMKey = "Fcm_key";
String pickupMethod = "pickupMethod_key";
String keySignedIn = "signed_in";
String keyUnBoarded = "key_unBoarded";
String keyShowPickDialog = "key_show_pick_dialog";
String keyUserName = "key_user_name";
String cartAmount = "cartAmount";
String keyUserPhoto = "key_user_photo";
const String langCode = 'languageCode';
String currentAddress = 'currentAddress';
String receiveMethodKey = 'receive_method_key';
String idKey = "idKey";

// String keyUserId = "key_user_id";
