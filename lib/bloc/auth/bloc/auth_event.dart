part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthLoginEvent extends AuthEvent{
String email;
String password;
AuthLoginEvent({required this.email,required this.password});

  @override
  List<Object> get props => [email,password];
}


class AuthRegisterEvent extends AuthEvent{
   String imagePath;
     String first_name;
     String last_name;
     String phone;
     String email;
     String password;
     String address;
     String dob;
     String occupation;
     String bio;
     String gender;
     AuthRegisterEvent({
      required this.imagePath,
    required this.first_name,
    required this.last_name,
    required this.phone,
    required this.email,
    required this.password,
    required this.address,
    required this.dob,
    required this.occupation,
    required this.bio,
    required this.gender,
     });
       @override
  List<Object> get props => [imagePath,first_name,last_name,phone,email,password,address,dob,occupation,bio,gender];
}


class ProfileEditingEvent extends AuthEvent{
 String first_name;
     String last_name;
      String email;
     String address;
      String dob;
     String gender;
  ProfileEditingEvent({
    required this.first_name,
     required this.last_name,
      required this.email,
     required this.address,
      required this.dob,
     required this.gender
  });
@override
  List<Object> get props => [first_name,last_name,email,address,dob,gender];
}