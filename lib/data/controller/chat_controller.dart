import 'dart:convert';

import 'package:solidarity/data/model/chat/chat_friends_model.dart';
import 'package:solidarity/data/model/chat/chat_model.dart';
import 'package:solidarity/data/repo/auth_repo.dart';
import 'package:solidarity/data/repo/get_repo.dart';
import 'package:solidarity/resources/constants.dart';

class ChatController{

GetRepo getRepo = GetRepo();
AuthRepo authRepo = AuthRepo();


//sendMessage
  Future<ChatModel> sendMessage({
    required String message,
    required int sendTo,
  }) async {
    Map body;

    body = {
      "message": message,
      "send_to": sendTo,
      "type": "chat",
    };
  
    var response =
        await authRepo.postRepository(ApiClass.sendChat, body,token: true);
        print(response.body);
    var data = jsonDecode(response.body);
    return ChatModel.fromJson(data);
  }



//chat

 Future<ChatModel> getCHats(id) async{
    var response = await getRepo.getRepository("${ApiClass.chat}/$id");
    var data = jsonDecode(response.body);
    return ChatModel.fromJson(data);  
  }

List<Dataum> friends = [];
  Future<ChatFriendModel> getChatFriends() async{
    var response = await getRepo.getRepository("${ApiClass.chatFriend}");
    var data = jsonDecode(response.body);
    friends.clear();
    friends.addAll(ChatFriendModel.fromJson(data).data!.toList());
    return ChatFriendModel.fromJson(data);  
  }


}