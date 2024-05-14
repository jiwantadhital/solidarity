import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:solidarity/data/controller/new_friends_controller.dart';
import 'package:solidarity/data/model/new_friends/new_friends_model.dart';

part 'new_friend_list_event.dart';
part 'new_friend_list_state.dart';

class NewFriendListBloc extends Bloc<NewFriendListEvent, NewFriendListState> {
  NewFriendsController newFriendsController = NewFriendsController();
  NewFriendListBloc() : super(NewFriendListInitial()) {
    on<NewFriendsListGettingEvent>((event, emit) async{
      emit(NewFriendListLoading());
      try{
        var data =await newFriendsController.getNewFriends();
        if(data.status == "ok"){
          emit(NewFriendListLoaded(newFriendsModel: data));
        }
        else{
          emit(NewFriendListError(message: data.message.toString()));
        }
      }
      catch(e){
        emit(NewFriendListError(message: "Something went wrong"));
      }
    });
  }
}
