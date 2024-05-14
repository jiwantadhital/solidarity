part of 'chat_friends_bloc.dart';

sealed class ChatFriendsState extends Equatable {
  const ChatFriendsState();
  
  @override
  List<Object> get props => [];
}

class ChatFriendsInitial extends ChatFriendsState {}
class ChatFriendsLoading extends ChatFriendsState {}
class ChatFriendsLoaded extends ChatFriendsState {
  ChatFriendModel chatFriendModel;
  ChatFriendsLoaded({required this.chatFriendModel});
}
class ChatFriendsError extends ChatFriendsState {
  String message;
  ChatFriendsError({required this.message});
}

