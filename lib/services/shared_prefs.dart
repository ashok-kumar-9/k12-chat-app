import 'package:shared_preferences/shared_preferences.dart';

class PrefsConstants {
  static const String isLoggedIn = 'isLoggedIn';
  static const String isOnBoardingDone = 'isOnBoardingDone';
  static const String email = 'email';
}

class SharedPrefs {
  static late SharedPreferences _sharedPrefs;

  factory SharedPrefs() => SharedPrefs._internal();

  SharedPrefs._internal();

  Future<void> init() async {
    _sharedPrefs = await SharedPreferences.getInstance();
  }

  void clearSharedPrefs() {
    _sharedPrefs.clear();
  }

  bool get isLoggedIn =>
      _sharedPrefs.getBool(PrefsConstants.isLoggedIn) ?? false;

  set isLoggedIn(bool value) =>
      _sharedPrefs.setBool(PrefsConstants.isLoggedIn, value);

  bool get isOnBoardingDone =>
      _sharedPrefs.getBool(PrefsConstants.isOnBoardingDone) ?? false;

  set isOnBoardingDone(bool value) =>
      _sharedPrefs.setBool(PrefsConstants.isOnBoardingDone, value);

  String get email => _sharedPrefs.getString(PrefsConstants.email) ?? "";

  set email(String value) =>
      _sharedPrefs.setString(PrefsConstants.email, value);
}
