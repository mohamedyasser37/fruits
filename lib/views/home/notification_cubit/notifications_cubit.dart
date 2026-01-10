import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:fruits/views/home/notification_repo.dart';
import 'package:flutter/foundation.dart';

part 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  final NotificationRepo repo;
  StreamSubscription? _sub;

  NotificationsCubit(this.repo) : super(NotificationsInitial()) {
    fetchNotifications();
  }

  void fetchNotifications() {
    emit(NotificationsLoading());
    _sub?.cancel();
    _sub = repo.getNotificationTitlesStream().listen(
          (titles) {
        emit(NotificationsLoaded(titles: titles));
      },
      onError: (error) => emit(NotificationsError(message: error.toString())),
    );
  }

  @override
  Future<void> close() {
    _sub?.cancel();
    return super.close();
  }
}
