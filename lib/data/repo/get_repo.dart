import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:solidarity/local_database/usersimplepreferences.dart';
import 'package:solidarity/presentation/authentication/login.dart';
import 'package:solidarity/resources/constants.dart';


class GetRepo{
  Future<http.Response> getRepository(api) async{
  var response = await http.get(Uri.parse("${ApiClass.mainApi}$api"),headers: {
    "Authorization" : "Bearer ${UserSimplePreferences.getToken()}",
    "accept" : "application/json"
  },
  );
  if(response.statusCode==200){
    return response;
  }
  else if(response.statusCode == 404){
    return response;
  }
  else if(response.statusCode == 401){
    UserSimplePreferences.logout().then((value) {
      Get.offAll(()=>Login());
    });
    throw Exception(response.reasonPhrase);
  }
  else{
    
    throw Exception(response.reasonPhrase);
  }
}
}