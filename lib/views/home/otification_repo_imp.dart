import 'package:cloud_firestore/cloud_firestore.dart';
import 'notification_repo.dart';

class NotificationRepoImpl implements NotificationRepo {
  final FirebaseFirestore firestore;

  NotificationRepoImpl(this.firestore);

  @override
  Future<List<String>> getNotificationTitles() async {
    final snapshot = await firestore.collection('notifications').get();
    return snapshot.docs
        .map((doc) => doc.data()['title'] as String)
        .toList();
  }

  @override
  Stream<List<String>> getNotificationTitlesStream() {
    return firestore.collection('notifications').snapshots().map(
          (snapshot) => snapshot.docs
          .map((doc) => doc.data()['title'] as String)
          .toList(),
    );
  }
}
