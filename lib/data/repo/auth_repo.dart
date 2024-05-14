import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:solidarity/local_database/usersimplepreferences.dart';
import 'package:solidarity/presentation/authentication/login.dart';
import 'package:solidarity/resources/constants.dart';


class AuthRepo{

Future<http.Response> postRepository(api, body, {token = true}) async {
    var res = await http
        .post(Uri.parse("${ApiClass.mainApi}$api"),
            headers: token == true?{
              "Content-Type": "application/json",
              "Authorization": "Bearer ${UserSimplePreferences.getToken()}",
            }:{
              "Content-Type": "application/json",
            },
            body: jsonEncode(body))
        .timeout(const Duration(seconds: 30));
  print(res.body);
    if (res.statusCode == 200) {
      return res;
    }
    else if(res.statusCode == 401){
       UserSimplePreferences.logout().then((value) {
      Get.offAll(()=>Login());
    });
    throw Exception(res.reasonPhrase);
    }
     else {
      throw Exception(res.reasonPhrase);
    }
  }

  Future<http.Response> postRepositoryaccept(api, body, {token = true}) async {
    var res = await http
        .post(Uri.parse("${ApiClass.mainApi}$api"),
            headers: token == true?{
              "Content-Type": "application/json",
              "Authorization": "Bearer ${UserSimplePreferences.getToken()}",
              "accept":"application/json"
            }:{
              "Content-Type": "application/json",
              "accept":"application/json"
            },
            body: jsonEncode(body))
        .timeout(const Duration(seconds: 30));
  print(res.body);
    if (res.statusCode == 200) {
      return res;
    }
    // else if(res.statusCode == 401){
    //    UserSimplePreferences.logout().then((value) {
    //   Get.offAll(()=>Login());
    // });
    // throw Exception(res.reasonPhrase);
    // }
     else {
      throw Exception(res.reasonPhrase);
    }
  }

}