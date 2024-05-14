part of 'chat_history_bloc.dart';

sealed class ChatHistoryState extends Equatable {
  const ChatHistoryState();
  
  @override
  List<Object> get props => [];
}

final class ChatHistoryInitial extends ChatHistoryState {}

final class ChatHistoryLoading extends ChatHistoryState {}
final class ChatHistoryLoaded extends ChatHistoryState {
  ChatModel chatModel;
  ChatHistoryLoaded({required this.chatModel});
}
final class ChatHistoryError extends ChatHistoryState {
  String message;
  ChatHistoryError({required this.message});
}
