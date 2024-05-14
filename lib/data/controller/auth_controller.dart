import 'dart:convert';

import 'package:solidarity/data/model/login_model.dart';
import 'package:solidarity/data/model/register_model.dart';
import 'package:solidarity/data/repo/auth_repo.dart';
import 'package:solidarity/data/repo/get_repo.dart';
import 'package:solidarity/local_database/usersimplepreferences.dart';
import 'package:solidarity/resources/constants.dart';
import 'package:http/http.dart' as http;
import 'package:solidarity/resources/device_details.dart';

class AuthController{
AuthRepo authRepo = AuthRepo();
GetRepo getRepo = GetRepo();

  Future<LoginModel> login({
    required String email,
    required String password,
  }) async {
    DeviceInformation deviceInfo = await DeviceDetails.getAppDetails();
    String imei = deviceInfo.id;
    Map body;

    body = {
      "email": email,
      "device_key": UserSimplePreferences.getFid().toString(),
      "password": password,
    };
  
    var response =
        await authRepo.postRepositoryaccept(ApiClass.login, body,token: false);
        print(response.body);
    var data = jsonDecode(response.body);
    return LoginModel.fromJson(data);
  }


  //register
  Future<RegisterModel> register({
    required String imagePath,
    required String first_name,
    required String last_name,
    required String phone,
    required String email,
    required String password,
    required String address,
    required String dob,
    required String occupation,
    required String bio,
    required String gender,


  }) async {
    DeviceInformation deviceInfo = await DeviceDetails.getAppDetails();
    String imei = deviceInfo.id;
    var request = http.MultipartRequest(
        'POST', Uri.parse("${ApiClass.mainApi}${ApiClass.register}"));
    request.headers.addAll({
      "Content-Type": "multipart/form-data"
    });
    request.fields['first_name'] = first_name.toString();
    request.fields['last_name'] = last_name.toString();
    request.fields['phone'] = phone.toString();
    request.fields['email'] = email.toString();
    request.fields['password'] = password.toString();
    request.fields['address'] = address.toString();
    request.fields['dob'] = dob.toString();
    request.fields['occupation'] = occupation.toString();
    request.fields['bio_description'] = bio.toString();
    request.fields['gender'] = gender.toString();
    request.fields['device_key'] = UserSimplePreferences.getFid().toString();
  


    http.MultipartFile multipartFile =
        await http.MultipartFile.fromPath('image_url', imagePath);
    request.files.add(multipartFile);

    var response = await request.send();
    var res = await http.Response.fromStream(response).timeout(
      const Duration(seconds: 30),
    );
    if (res.statusCode == 200 || res.statusCode == 201) {
      var data = jsonDecode(res.body);
      return RegisterModel.fromJson(data);
    } else {
      throw Exception(res.reasonPhrase);
    }
  }


  //edit profile
  
  Future<EditProfileModel> editProfile({
    required String first_name,
    required String last_name,
     required String email,
    required String address,
     required String dob,
    required String gender,
  }) async {
    DeviceInformation deviceInfo = await DeviceDetails.getAppDetails();
    String imei = deviceInfo.id;
    Map body;

    body = {
      "first_name": first_name,
      "last_name": last_name,
      "email": email,
      "address": address,
      "dob": dob,
      "gender": gender
    };
  
    var response =
        await authRepo.postRepositoryaccept("${ApiClass.editProfile}/${UserSimplePreferences.getId()}", body);
    var data = jsonDecode(response.body);
    return EditProfileModel.fromJson(data);
  }



  //profile
  Future<bool> getCall(id) async{
  var response = await http.get(Uri.parse("${ApiClass.mainApi}${ApiClass.callApi}/$id"),headers: {
    "Authorization" : "Bearer ${UserSimplePreferences.getToken()}",
    "accept" : "application/json"
  },
  );
  if(response.statusCode==200){
    return true;
  }
  else if(response.statusCode == 404){
    return false;
  }
  
  else{
    return false;
  }
}
}


class EditProfileModel {
  String? message;

  EditProfileModel({this.message});

  EditProfileModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    return data;
  }
}
