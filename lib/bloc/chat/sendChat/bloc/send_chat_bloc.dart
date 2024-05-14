import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:solidarity/data/controller/chat_controller.dart';
import 'package:solidarity/data/model/chat/chat_model.dart';

part 'send_chat_event.dart';
part 'send_chat_state.dart';

class SendChatBloc extends Bloc<SendChatEvent, SendChatState> {
  ChatController chatController = ChatController();
  SendChatBloc() : super(SendChatInitial()) {
    on<SendingMessageEvent>((event, emit) async{
     emit(SendChatLoading());
     try{
      var data = await chatController.sendMessage(message: event.message, sendTo: event.id);
      if(data.status == "success"){
        emit(SendChatloaded(chatModel: data));

      }
      else{
        emit(SendChatError(message: "something went wrong"));
      }
     }
     catch(e){
        emit(SendChatError(message: "something went wrong"));
     }
    });
  }
}
