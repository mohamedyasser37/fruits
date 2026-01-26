import 'package:cloud_firestore/cloud_firestore.dart';

abstract class NotificationRepo {
  /// Get notifications titles once
  Future<List<String>> getNotificationTitles();

  /// Optional: stream for real-time updates
  Stream<List<String>> getNotificationTitlesStream();
  Future<void> deleteNotification(String title);
}
