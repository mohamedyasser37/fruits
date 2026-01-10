part of 'notifications_cubit.dart';

@immutable
@immutable
sealed class NotificationsState {}

class NotificationsInitial extends NotificationsState {}

class NotificationsLoading extends NotificationsState {}

class NotificationsLoaded extends NotificationsState {
  final List<String> titles;
  NotificationsLoaded({required this.titles});
}

class NotificationsError extends NotificationsState {
  final String message;
  NotificationsError({required this.message});
}
