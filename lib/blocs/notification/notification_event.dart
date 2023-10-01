part of 'notification_bloc.dart';

sealed class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object> get props => [];
}

class CallNotificationEvent extends NotificationEvent {}
class NotificationClearEvent extends NotificationEvent {}
