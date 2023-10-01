part of 'request_list_bloc.dart';

abstract class RequestListEvent extends Equatable {
  const RequestListEvent();

  @override
  List<Object> get props => [];
}
class CallRequestList extends RequestListEvent{
  final String userId;
  const CallRequestList(this.userId);
  @override
  List<Object> get props => [userId];
}