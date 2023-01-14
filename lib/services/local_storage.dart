import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static SharedPreferences? _sharedPrefs;

  init() async {
    _sharedPrefs ??= await SharedPreferences.getInstance();
  }

  String get username => _sharedPrefs?.getString(keyUsername) ?? "";

  set username(String value) {
    _sharedPrefs?.setString(keyUsername, value);
  }

  String get id => _sharedPrefs?.getString(keyId) ?? "";

  String get location => _sharedPrefs?.getString(keyLocation) ?? "";

  set id(String value) {
    _sharedPrefs?.setString(keyId, value);
  }

  set location(String value) {
    _sharedPrefs?.setString(keyLocation, value);
  }

  bool get isLanding => _sharedPrefs?.getBool(keyLanding) ?? false;

  set isLanding(bool value) {
    _sharedPrefs?.setBool(keyLanding, value);
  }
}

final localStorage = LocalStorage();
// constants/strings.dart
const String keyUsername = "name";
const String keyId = "id";
const String keyLocation = "_location";
const String keyLanding = "_landing";