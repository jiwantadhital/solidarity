part of 'send_accept_bloc.dart';

sealed class SendAcceptEvent extends Equatable {
  const SendAcceptEvent();

  @override
  List<Object> get props => [];
}


class SendingRequestEvent extends SendAcceptEvent{
  String sendFrom;
  String sendTo;
  SendingRequestEvent({required this.sendFrom,required this.sendTo});
  @override
  List<Object> get props => [sendFrom,sendTo];
}

class CancelingRequest extends SendAcceptEvent{
  int id;
  CancelingRequest({required this.id});
}