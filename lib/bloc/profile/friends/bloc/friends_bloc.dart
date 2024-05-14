import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:solidarity/data/controller/profile_controller.dart';
import 'package:solidarity/data/model/profile/profile_friends_model.dart';

part 'friends_event.dart';
part 'friends_state.dart';

class FriendsBloc extends Bloc<FriendsEvent, FriendsState> {
  ProfileCOntroller profileCOntroller = ProfileCOntroller();
  FriendsBloc() : super(FriendsInitial()) {
    on<ByCategoryFriendsGettingEvent>((event, emit) async{
      emit(FriendsLoading());
       try{
         var data =await profileCOntroller.getAllFriends(id: event.id);
        if(data.status == "success"){
          emit(FriendsLoaded(profileFriendsModel: data));
        }
        else{
          emit(Friendserror(message: "Something went wrong"));
        }
       }
       catch(e){
        emit(Friendserror(message: "Something went wrong"));
       }
    });
  }
}
