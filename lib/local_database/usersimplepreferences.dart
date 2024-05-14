import 'dart:math';

import 'package:shared_preferences/shared_preferences.dart';

class UserSimplePreferences {
  static SharedPreferences? _preferences;

static Future init() async =>
      _preferences = await SharedPreferences.getInstance();



  static const _accessToken = 'accessToken';
  static const _id = 'id';
  static const _email = 'email';
  static const _fId = 'fid';
  static const _password = 'password';
  static const _rememberMe = 'rememberMe';



 


  

  static Future setToken(String token) async {
    await _preferences?.setString(_accessToken, token);
  }
  static Future setEmailPassword(String email,String password) async {
    await _preferences?.setString(_email, email);
    await _preferences?.setString(_password, password);

  }
  static Future setfId(String fId) async {
    await _preferences?.setString(_fId, fId);

  }
  static Future setRemember(bool remember) async {
    await _preferences?.setBool(_rememberMe, remember);
  }
  static Future setId(int id) async {
    await _preferences?.setInt(_id, id);
  }

  

  

  static String? getToken() => _preferences?.getString(_accessToken);
  static int? getId() => _preferences?.getInt(_id);
  static String? getEmail() => _preferences?.getString(_email);
  static String? getFid() => _preferences?.getString(_fId);

  static String? getPassword() => _preferences?.getString(_password);
  static bool? getRemember() => _preferences?.getBool(_rememberMe);


  

  
//is loggedIn
static userLoggedIn(){
    return _preferences?.containsKey(_accessToken);
  }
  static Future logout() async {
    await _preferences?.remove(_accessToken);
    await _preferences?.remove(_id);
    

  }
}
