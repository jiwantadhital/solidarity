part of 'accept_request_bloc.dart';

sealed class AcceptRequestState extends Equatable {
  const AcceptRequestState();
  
  @override
  List<Object> get props => [];
}

 class AcceptRequestInitial extends AcceptRequestState {}
 class AcceptRequestLoading extends AcceptRequestState {}
 class AcceptRequestLoaded extends AcceptRequestState {
  AcceptedModel acceptedModel;
  AcceptRequestLoaded({required this.acceptedModel});
 }
 class AcceptRequestError extends AcceptRequestState {
  String message;
  AcceptRequestError({required this.message});
 }

 class CancelRequestLoaded extends AcceptRequestState {
  CancelRequestModel cancelRequestModel;
  CancelRequestLoaded({required this.cancelRequestModel});
 }
