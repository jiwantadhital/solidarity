part of 'friends_bloc.dart';

sealed class FriendsEvent extends Equatable {
  const FriendsEvent();

  @override
  List<Object> get props => [];
}

class AllFriendsGettingEvent extends FriendsEvent{}

class ByCategoryFriendsGettingEvent extends FriendsEvent{
  int? id;
  ByCategoryFriendsGettingEvent({this.id});
}
