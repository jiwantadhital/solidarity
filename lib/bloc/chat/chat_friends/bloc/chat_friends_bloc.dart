import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:solidarity/data/controller/chat_controller.dart';
import 'package:solidarity/data/model/chat/chat_friends_model.dart';

part 'chat_friends_event.dart';
part 'chat_friends_state.dart';

class ChatFriendsBloc extends Bloc<ChatFriendsEvent, ChatFriendsState> {
  ChatController chatController = ChatController();
  ChatFriendsBloc() : super(ChatFriendsInitial()) {
    on<ChatFriendGettingEvent>((event, emit) async{
      emit(ChatFriendsLoading());
      try{
        var data =await chatController.getChatFriends();
        if(data.status == "success"){
          emit(ChatFriendsLoaded(chatFriendModel: data));
        }
        else{
          emit(ChatFriendsError(message: "Something went wrong"));
        }
      }
      catch(e){
          emit(ChatFriendsError(message: "Something went wrong"));
      }
    });
  }
}
