import 'package:cloud_firestore/cloud_firestore.dart';
import 'notification_repo.dart';

class NotificationRepoImpl implements NotificationRepo {
  final FirebaseFirestore firestore;

  NotificationRepoImpl(this.firestore);



  @override
  Stream<List<String>> getNotificationTitlesStream() {
    return firestore
        .collection('notifications')
        .orderBy('createdAt', descending: true) // الترتيب من الأحدث للأقدم
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
          .map((doc) => doc.data()['title'] as String)
          .toList(),
    );
  }

  @override
  Future<List<String>> getNotificationTitles() async {
    final snapshot = await firestore
        .collection('notifications')
        .orderBy('createdAt', descending: true) // الترتيب هنا أيضاً
        .get();

    return snapshot.docs
        .map((doc) => doc.data()['title'] as String)
        .toList();
  }

  @override
  Future<void> deleteNotification(String title) async {
    var snapshot = await firestore
        .collection('notifications')
        .where('title', isEqualTo: title)
        .get();

    for (var doc in snapshot.docs) {
      await doc.reference.delete();
    }
  }


}
