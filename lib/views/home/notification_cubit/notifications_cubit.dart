import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:fruits/helper/shared_prefrence.dart';
import 'package:fruits/views/home/notification_repo.dart';
import 'package:flutter/foundation.dart';

part 'notifications_state.dart';
class NotificationsCubit extends Cubit<NotificationsState> {
  final NotificationRepo repo;
  StreamSubscription? _sub;
  int unreadCount = 0;
  int totalNotifications = 0;

  NotificationsCubit(this.repo) : super(NotificationsInitial());

  void fetchNotifications() {
    emit(NotificationsLoading());
    _sub?.cancel();
    _sub = repo.getNotificationTitlesStream().listen(
          (titles) {
        totalNotifications = titles.length;
        int lastSeenCount = Prefs.getInt('last_seen_notifications_count');
        unreadCount = totalNotifications - lastSeenCount;
        if (unreadCount < 0) unreadCount = 0;

        emit(NotificationsLoaded(titles: titles));
      },
      onError: (error) => emit(NotificationsError(message: error.toString())),
    );
  }

  // ميثود الحذف
  Future<void> deleteNotification(int index) async {
    if (state is NotificationsLoaded) {
      final titles = (state as NotificationsLoaded).titles;
      String titleToDelete = titles[index];

      // حذف من فيربيز
      await repo.deleteNotification(titleToDelete);

      // تحديث العداد محلياً فوراً لضمان دقة الـ Badge
      totalNotifications = titles.length - 1;
      Prefs.setInt('last_seen_notifications_count', totalNotifications);
      unreadCount = 0; // تصفير العداد لأننا بالفعل داخل الصفحة ونشاهد القائمة
    }
  }

  void clearBadge() {
    unreadCount = 0;
    Prefs.setInt('last_seen_notifications_count', totalNotifications);
    if (state is NotificationsLoaded) {
      emit(NotificationsLoaded(titles: (state as NotificationsLoaded).titles));
    }
  }

  @override
  Future<void> close() {
    _sub?.cancel();
    return super.close();
  }
}
