part of 'friends_bloc.dart';

sealed class FriendsState extends Equatable {
  const FriendsState();
  
  @override
  List<Object> get props => [];
}

class FriendsInitial extends FriendsState {}
class FriendsLoading extends FriendsState {}
class FriendsLoaded extends FriendsState {
  ProfileFriendsModel profileFriendsModel;
  FriendsLoaded({required this.profileFriendsModel});
}
class Friendserror extends FriendsState {
  String message;
  Friendserror({required this.message});
}

