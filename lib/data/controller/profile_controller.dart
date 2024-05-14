import 'dart:convert';

import 'package:solidarity/data/model/profile/network_model.dart';
import 'package:solidarity/data/model/profile/profile_friends_model.dart';
import 'package:solidarity/data/model/profile/profile_model.dart';
import 'package:solidarity/data/repo/get_repo.dart';
import 'package:solidarity/resources/constants.dart';

class ProfileCOntroller{
GetRepo getRepo = GetRepo();


  Future<CategoryModel> getCategory() async{
    var response = await getRepo.getRepository("${ApiClass.networkCategory}");
    var data = jsonDecode(response.body);
    return CategoryModel.fromJson(data);
  }

//friends
 Future<CategoryModel> getFriends() async{
    var response = await getRepo.getRepository("${ApiClass.friends}");
    var data = jsonDecode(response.body);
    return CategoryModel.fromJson(data);  
  }

  //profile
  Future<ProfileModel> getProfile(id) async{
    var response = await getRepo.getRepository("${ApiClass.profile}/$id");
    var data = jsonDecode(response.body);
    return ProfileModel.fromJson(data);  
  }

  //profile friends
  Future<ProfileFriendsModel> getAllFriends({int? id}) async{
    var response = id == null? await getRepo.getRepository("${ApiClass.profileFriends}"):
    await getRepo.getRepository("${ApiClass.profileFriends}/$id");
    var data = jsonDecode(response.body);
    return ProfileFriendsModel.fromJson(data);  
  }
}