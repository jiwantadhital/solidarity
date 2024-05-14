part of 'chat_friends_bloc.dart';

sealed class ChatFriendsEvent extends Equatable {
  const ChatFriendsEvent();

  @override
  List<Object> get props => [];
}

class ChatFriendGettingEvent extends ChatFriendsEvent{}