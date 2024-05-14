part of 'chat_history_bloc.dart';

sealed class ChatHistoryEvent extends Equatable {
  const ChatHistoryEvent();

  @override
  List<Object> get props => [];
}


class ChatGettingEvent extends ChatHistoryEvent{
  int id;
  ChatGettingEvent({required this.id});
  @override
  List<Object> get props => [id];
}