part of 'request_list_bloc.dart';

abstract class RequestListState extends Equatable {
  const RequestListState();
  
  @override
  List<Object> get props => [];
}

class RequestListInitial extends RequestListState {}

class RequestListDone extends RequestListState {
  final List<PRetrnmsg1> requestLists;
  const RequestListDone(this.requestLists);
  @override
  List<Object> get props => [requestLists];
}

class RequestListFailed extends RequestListState {
  final String msg;
  const RequestListFailed(this.msg);
  @override
  List<Object> get props => [msg];
}
