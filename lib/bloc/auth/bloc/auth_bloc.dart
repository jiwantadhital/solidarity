import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:solidarity/data/controller/auth_controller.dart';
import 'package:solidarity/data/model/login_model.dart';
import 'package:solidarity/data/model/register_model.dart';
import 'package:solidarity/local_database/usersimplepreferences.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthController authController = AuthController();
  AuthBloc() : super(AuthInitial()) {
    on<AuthLoginEvent>((event, emit) async{
      emit(AuthLoginLoading());
      try{
        var data = await authController.login(email: event.email, password: event.password);
        if(data.status == "ok"){
          UserSimplePreferences.setToken(data.token??"");
          UserSimplePreferences.setId(data.data!.id!);
          if(UserSimplePreferences.getRemember() == true){
            UserSimplePreferences.setEmailPassword(event.email, event.password);
          }

          emit(AuthLoginLoaded(loginModel: data));
        }
        else{
          emit(AuthLoginError(message: data.message.toString()));
        }
      }
      catch(e){
        emit(AuthLoginError(message: e.toString()));
      }
    });

    //register
    on<AuthRegisterEvent>((event, emit) async{
      emit(AuthReggisterLoading());
      try{
        var data = await authController.register(imagePath: event.imagePath,
         first_name: event.first_name,
        last_name: event.last_name,
         phone: event.phone, email: event.email,
          password: event.password, address: event.address, dob: event.dob, occupation: event.occupation,
           bio: event.bio, gender: event.gender);
        if(data.status == "ok"){
          emit(AuthregisterLoaded(registerModel: data));
        }
        else{
          emit(AuthRegisterError(message: data.message.toString()));
        }
      }
      catch(e){
        emit(AuthRegisterError(message: e.toString()));
      }
    });

    //edit
     on<ProfileEditingEvent>((event, emit) async{
      emit(ProfileEditing());
      try{
        var data = await authController.editProfile(
          first_name: event.first_name,last_name: event.last_name,dob: event.dob,email: event.email,
          address: event.address,gender: event.gender
        );
        if(data.message == "User data updated successfully"){
          emit(ProfileEdited(editProfileModel: data));
        }
        else{
          emit(EditError(message: data.message.toString()));
        }
      }
      catch(e){
        emit(EditError(message: e.toString()));
      }
    });
  }
}
