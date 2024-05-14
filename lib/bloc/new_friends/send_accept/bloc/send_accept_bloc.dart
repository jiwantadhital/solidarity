import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:solidarity/data/controller/new_friends_controller.dart';

part 'send_accept_event.dart';
part 'send_accept_state.dart';

class SendAcceptBloc extends Bloc<SendAcceptEvent, SendAcceptState> {
  NewFriendsController newFriendsController = NewFriendsController();
  SendAcceptBloc() : super(SendAcceptInitial()) {
    on<SendingRequestEvent>((event, emit) async{
      emit(SendAcceptLoading());
      try{
        var data =await newFriendsController.sendingRequest(sentFrom: event.sendFrom, sentTo: event.sendTo);
        if(data.status == "ok"){
          emit(SendAcceptLoaded());
        }
        else{
          emit(SendAcceptError(message: data.message.toString()));
        }
      }
      catch(e){
        emit(SendAcceptError(message: e.toString()));
      }
    });

   
  }
}
