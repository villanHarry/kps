import 'dart:convert';
import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {
  static SharedPreference? _sharedPreferenceHelper;
  static SharedPreferences? _sharedPreferences;
  SharedPreference._createInstance();
  factory SharedPreference() {
    // factory with constructor, return some value
    _sharedPreferenceHelper ??= SharedPreference._createInstance();
    return _sharedPreferenceHelper!;
  }
  Future<SharedPreferences> get sharedPreference async {
    _sharedPreferences ??= await SharedPreferences.getInstance();
    return _sharedPreferences!;
  }

  //------------------- clear --------------------//
  void clear() {
    _sharedPreferences!.clear();
  }

  //------------------- user --------------------//
  Future<void> setUser({Map<String, dynamic>? user}) async {
    await _sharedPreferences?.setString("user", json.encode(user));
  }

  Map<String, dynamic>? getUser() {
    String? val = _sharedPreferences?.getString("user");
    if (val != null) {
      return json.decode(val);
    } else {
      return null;
    }
  }

  //------------------- tutorial --------------------//
  bool? getTutorial() {
    return _sharedPreferences?.getBool("tutorial");
  }

  Future<void> setTutorial() async {
    try {
      await _sharedPreferences?.setBool("tutorial", true);
    } catch (e) {
      log("SET TUTORIAL ERROR: ${e.toString()}");
    }
  }
}
