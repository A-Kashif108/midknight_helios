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

  List<String> get services => _sharedPrefs?.getStringList(keyServices) ?? [];

  set id(String value) {
    _sharedPrefs?.setString(keyId, value);
  }

  set services(List<String> str) {
    _sharedPrefs?.setStringList(keyServices, str);
  }

  set location(String value) {
    _sharedPrefs?.setString(keyLocation, value);
  }
}

final localStorage = LocalStorage();
// constants/strings.dart
const String keyUsername = "name";
const String keyId = "id";
const String keyServices = "_services";
const String keyLocation = "_location";