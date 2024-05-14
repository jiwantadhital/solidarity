import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:solidarity/data/controller/profile_controller.dart';
import 'package:solidarity/data/model/profile/profile_model.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileCOntroller profileCOntroller = ProfileCOntroller();
  ProfileBloc() : super(ProfileInitial()) {
    on<ProfileGettingEvent>((event, emit) async{
     emit(ProfileLoading());
     try{
        var data = await profileCOntroller.getProfile(event.id);
        if(data.status == "ok"){
          emit(ProfileLoaded(profileModel: data));
        }
        else{
          emit(ProfileError(message: data.message.toString()));
        }
     }
     catch(e){
          emit(ProfileError(message: "Something went wrong"));

     }
    });
  }
}
