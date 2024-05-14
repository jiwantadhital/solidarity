part of 'new_friend_list_bloc.dart';

sealed class NewFriendListEvent extends Equatable {
  const NewFriendListEvent();

  @override
  List<Object> get props => [];
}

class NewFriendsListGettingEvent extends NewFriendListEvent{}