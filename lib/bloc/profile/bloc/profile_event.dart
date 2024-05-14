part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class ProfileGettingEvent extends ProfileEvent{
  int id;
  ProfileGettingEvent({required this.id});
  @override
  List<Object> get props => [id];
}