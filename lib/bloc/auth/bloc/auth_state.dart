part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();
  
  @override
  List<Object> get props => [];
}


final class AuthInitial extends AuthState {}
final class AuthLoginLoading extends AuthState {}
final class AuthLoginLoaded extends AuthState {
  LoginModel loginModel;
  AuthLoginLoaded({required this.loginModel});
}
final class AuthLoginError extends AuthState {
  String message;
  AuthLoginError({required this.message});

  @override
  List<Object> get props => [message];
}


final class AuthReggisterLoading extends AuthState {}
final class AuthregisterLoaded extends AuthState {
  RegisterModel registerModel;
  AuthregisterLoaded({required this.registerModel});
}
final class AuthRegisterError extends AuthState {
  String message;
  AuthRegisterError({required this.message});

  @override
  List<Object> get props => [message];
}


// edit
final class ProfileEditing extends AuthState {}
final class ProfileEdited extends AuthState {
  EditProfileModel editProfileModel;
  ProfileEdited({required this.editProfileModel});
}
final class EditError extends AuthState {
  String message;
  EditError({required this.message});

  @override
  List<Object> get props => [message];
}

