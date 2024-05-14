import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:solidarity/data/controller/chat_controller.dart';
import 'package:solidarity/data/model/chat/chat_model.dart';

part 'chat_history_event.dart';
part 'chat_history_state.dart';

class ChatHistoryBloc extends Bloc<ChatHistoryEvent, ChatHistoryState> {
  ChatController chatController = ChatController();
  ChatHistoryBloc() : super(ChatHistoryInitial()) {
    on<ChatGettingEvent>((event, emit)async {
      emit(ChatHistoryLoading());
      try{
        var data = await chatController.getCHats(event.id);
        if(data.status == "success"){
          emit(ChatHistoryLoaded(chatModel: data));
        }
        else{
          emit(ChatHistoryError(message: "Something went wrong"));
        }
      }
      catch(e){
          emit(ChatHistoryError(message: "Something went wrong"));

      }
    });
  }
}
