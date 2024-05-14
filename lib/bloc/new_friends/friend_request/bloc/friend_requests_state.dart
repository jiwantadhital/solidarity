part of 'friend_requests_bloc.dart';

sealed class FriendRequestsState extends Equatable {
  const FriendRequestsState();
  
  @override
  List<Object> get props => [];
}

 class FriendRequestsInitial extends FriendRequestsState {}
 class FriendRequestsLoading extends FriendRequestsState {}
 class FriendRequestsLoaded extends FriendRequestsState {
  FriendRequestsModel friendRequestsModel;
  FriendRequestsLoaded({required this.friendRequestsModel});
 }
 class FriendRequestsError extends FriendRequestsState {
  String message;
  FriendRequestsError({required this.message});
 }

