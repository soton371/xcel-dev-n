part of 'user_list_bloc.dart';

abstract class UserListState extends Equatable {
  const UserListState();
  
  @override
  List<Object> get props => [];
}

class UserListInitial extends UserListState {}
class UserListDone extends UserListState {
  final List<UserListModel> userList;
  const UserListDone(this.userList);
  @override
  List<Object> get props => [userList];
}

class UserListFailed extends UserListState {
}
