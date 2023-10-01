part of 'notification_bloc.dart';

sealed class NotificationState extends Equatable {
  const NotificationState();
  
  @override
  List<Object> get props => [];
}

final class NotificationInitial extends NotificationState {}

final class NotificationCountState extends NotificationState {
  const NotificationCountState({required this.newNotificationCount, required this.notificationList});
  final String newNotificationCount;
  final List<NotificationModel> notificationList;

  @override
  List<Object> get props => [newNotificationCount, notificationList];
}
