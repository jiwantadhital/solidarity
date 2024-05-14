import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:solidarity/data/controller/new_friends_controller.dart';
import 'package:solidarity/data/model/friend_requests/friend_requests_model.dart';

part 'friend_requests_event.dart';
part 'friend_requests_state.dart';

class FriendRequestsBloc extends Bloc<FriendRequestsEvent, FriendRequestsState> {
  NewFriendsController newFriendsController = NewFriendsController();
  FriendRequestsBloc() : super(FriendRequestsInitial()) {
    on<FriendRequestGettingEvent>((event, emit) async{
      emit(FriendRequestsLoading());
      try{
        var data = await newFriendsController.getFriendRequests();
        if(data.status == "ok"){
          emit(FriendRequestsLoaded(friendRequestsModel: data));
        }
        else{
          emit(FriendRequestsError(message: data.message.toString()));
        }
      }
      catch(e){
          emit(FriendRequestsError(message: e.toString()));

      }
    });
  }
}
