part of 'new_friend_list_bloc.dart';

sealed class NewFriendListState extends Equatable {
  const NewFriendListState();
  
  @override
  List<Object> get props => [];
}

 class NewFriendListInitial extends NewFriendListState {}
 class NewFriendListLoading extends NewFriendListState {}
 class NewFriendListLoaded extends NewFriendListState {
  NewFriendsModel newFriendsModel;
  NewFriendListLoaded({required this.newFriendsModel});
 }
 class NewFriendListError extends NewFriendListState {
  String message;
  NewFriendListError({required this.message});
 }

