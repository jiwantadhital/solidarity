part of 'profile_bloc.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();
  
  @override
  List<Object> get props => [];
}

final class ProfileInitial extends ProfileState {}
final class ProfileLoading extends ProfileState {}
final class ProfileLoaded extends ProfileState {
  ProfileModel profileModel;
  ProfileLoaded({required this.profileModel});
}
final class ProfileError extends ProfileState {
  String message;
  ProfileError({required this.message});
}

