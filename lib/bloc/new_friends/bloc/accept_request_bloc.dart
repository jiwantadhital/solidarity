import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:solidarity/data/controller/new_friends_controller.dart';
import 'package:solidarity/data/model/new_friends/accept_request_model.dart';
import 'package:solidarity/data/model/new_friends/cancel_request_model.dart';

part 'accept_request_event.dart';
part 'accept_request_state.dart';

class AcceptRequestBloc extends Bloc<AcceptRequestEvent, AcceptRequestState> {
  NewFriendsController newFriendsController = NewFriendsController();
  AcceptRequestBloc() : super(AcceptRequestInitial()) {
    on<AcceptingRequestEvent>((event, emit) async{
      emit(AcceptRequestLoading());
      try{
        var data = await newFriendsController.acceptRequest(requestId: event.requestId, networkId: event.networkId);
          if(data.status == 'ok'){
            emit(AcceptRequestLoaded(acceptedModel: data));
          }
          else{
            emit(AcceptRequestError(message: data.message.toString()));
          }
      }
      catch(e){
                    emit(AcceptRequestError(message: e.toString()));

      }
    });


    //cancel request
    on<CancelingRequest>((event, emit) async{
      emit(AcceptRequestLoading());
      try{
        var data = await newFriendsController.cancelRequest(event.id);
          if(data.status == 'ok'){
            emit(CancelRequestLoaded(cancelRequestModel: data));
          }
          else{
            emit(AcceptRequestError(message: data.message.toString()));
          }
      }
      catch(e){
        emit(AcceptRequestError(message: e.toString()));

      }
    });
  }
}
