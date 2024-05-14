part of 'send_chat_bloc.dart';

sealed class SendChatState extends Equatable {
  const SendChatState();
  
  @override
  List<Object> get props => [];
}

final class SendChatInitial extends SendChatState {}
final class SendChatLoading extends SendChatState {}
final class SendChatloaded extends SendChatState {
  ChatModel chatModel;
  SendChatloaded({required this.chatModel});
  @override
  List<Object> get props => [chatModel];
}
final class SendChatError extends SendChatState {
  String message;
  SendChatError({required this.message});
}

