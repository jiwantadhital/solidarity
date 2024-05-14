import 'dart:convert';

import 'package:solidarity/data/model/friend_requests/friend_requests_model.dart';
import 'package:solidarity/data/model/new_friends/accept_request_model.dart';
import 'package:solidarity/data/model/new_friends/cancel_request_model.dart';
import 'package:solidarity/data/model/new_friends/new_friends_model.dart';
import 'package:solidarity/data/model/new_friends/request_sent_model.dart';
import 'package:solidarity/data/model/profile/profile_friends_model.dart';
import 'package:solidarity/data/repo/auth_repo.dart';
import 'package:solidarity/data/repo/get_repo.dart';
import 'package:solidarity/local_database/usersimplepreferences.dart';
import 'package:solidarity/resources/constants.dart';

class NewFriendsController{
GetRepo getRepo = GetRepo();
AuthRepo postRepo = AuthRepo();

List<NewData> friends = [];
  Future<NewFriendsModel> getNewFriends() async{
    var response = await getRepo.getRepository("${ApiClass.newFriends}");
    var data = jsonDecode(response.body);
    friends.clear();
    friends.addAll(NewFriendsModel.fromJson(data).data!.toList());
    return NewFriendsModel.fromJson(data);  
  }


  //sending request
  Future<RequestSentModel> sendingRequest({
    required String sentFrom,
    required String sentTo,
  }) async {
    Map body;

    body = {
      "sent_from": sentFrom,
      "sent_to": sentTo,
    };
  
    var response =
        await postRepo.postRepository(ApiClass.sendRequest, body,token: true);
    var data = jsonDecode(response.body);
    return RequestSentModel.fromJson(data);
  }


  //cancel request
   Future<CancelRequestModel> cancelRequest(id) async{
    var response = await getRepo.getRepository("${ApiClass.cancelRequest}/$id");
    var data = jsonDecode(response.body);
    print(response.body);
    return CancelRequestModel.fromJson(data);  
  }


//friend requests
  Future<FriendRequestsModel> getFriendRequests() async{
    var response = await getRepo.getRepository("${ApiClass.friendRequestList}/${UserSimplePreferences.getId()}");
    var data = jsonDecode(response.body);
    return FriendRequestsModel.fromJson(data);  
  }


//accept request
 //sending request
  Future<AcceptedModel> acceptRequest({
    required String requestId,
    required String networkId,
  }) async {
    Map body;

    body = {
      "request_id": requestId,
      "network_category": networkId,
    };
  
    var response =
        await postRepo.postRepositoryaccept(ApiClass.acceptRequest, body,token: true);
    var data = jsonDecode(response.body);
    print(response.body);
    return AcceptedModel.fromJson(data);
  }
}