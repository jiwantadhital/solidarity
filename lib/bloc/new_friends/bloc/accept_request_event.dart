part of 'accept_request_bloc.dart';

sealed class AcceptRequestEvent extends Equatable {
  const AcceptRequestEvent();

  @override
  List<Object> get props => [];
}

class AcceptingRequestEvent extends AcceptRequestEvent{
  String requestId;
  String networkId;
  AcceptingRequestEvent({required this.networkId, required this.requestId});
  @override
  List<Object> get props => [networkId,requestId];
}

class CancelingRequest extends AcceptRequestEvent{
  int id;
  CancelingRequest({required this.id});
  @override
  List<Object> get props => [id];
}