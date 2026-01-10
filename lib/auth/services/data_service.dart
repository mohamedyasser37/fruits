abstract class DataService {
  Future<void> addData({
    required String collectionName,
    required Map<String, dynamic> data,
    String? docId,
  });

  Future<dynamic> getData({
    required String collectionName,
    String? docId,
    Map<String, dynamic>? query, // أضف هذا
  });

  Future<bool> checkIfUserExists({
    required String collectionName,
    required String docId,
  });
}
