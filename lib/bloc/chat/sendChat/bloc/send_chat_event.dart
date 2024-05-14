part of 'send_chat_bloc.dart';

sealed class SendChatEvent extends Equatable {
  const SendChatEvent();

  @override
  List<Object> get props => [];
}

class SendingMessageEvent extends SendChatEvent{
  String message;
  int id;
  SendingMessageEvent({required this.message,required this.id});
   @override
  List<Object> get props => [message,id];
}