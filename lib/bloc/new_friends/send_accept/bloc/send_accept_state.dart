part of 'send_accept_bloc.dart';

sealed class SendAcceptState extends Equatable {
  const SendAcceptState();
  
  @override
  List<Object> get props => [];
}

class SendAcceptInitial extends SendAcceptState {}
class SendAcceptLoading extends SendAcceptState {}
class SendAcceptLoaded extends SendAcceptState {}
class SendCancelLoaded extends SendAcceptState {}

class SendAcceptError extends SendAcceptState {
  String message;
  SendAcceptError({required this.message});
}

