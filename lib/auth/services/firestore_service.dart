import 'package:cloud_firestore/cloud_firestore.dart';
import 'data_service.dart';


class FireStoreService implements DataService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Future<void> addData({
    required String collectionName,
    required Map<String, dynamic> data,
    String? docId,
  }) async {
    if (docId != null) {
      await firestore.collection(collectionName).doc(docId).set(data);
    } else {
      await firestore.collection(collectionName).add(data);
    }
  }

  @override
  Future<dynamic> getData({
    required String collectionName,
    String? docId,
    Map<String, dynamic>? query,
  }) async {
    if (docId != null) {
      var docSnap = await firestore.collection(collectionName).doc(docId).get();
      if (!docSnap.exists) return null;
      return {
        ...docSnap.data()!,
        'id': docSnap.id,
      };
    } else {
      Query<Map<String, dynamic>> collection = firestore.collection(collectionName);

      if (query != null) {
        if (query['orderBy'] != null) {
          collection = collection.orderBy(
            query['orderBy'],
            descending: query['descending'] ?? false,
          );
        }
        if (query['limit'] != null) {
          collection = collection.limit(query['limit']);
        }
      }

      var result = await collection.get();

      return result.docs.map((doc) {
        final data = doc.data();
        return {
          ...data,
          'id': doc.id,
        };
      }).toList();
    }
  }

  @override
  Future<bool> checkIfUserExists({
    required String collectionName,
    required String docId,
  }) async {
    var docSnap = await firestore.collection(collectionName).doc(docId).get();
    return docSnap.exists;
  }
}


// class FireStoreService implements DataService {
//   FirebaseFirestore firestore = FirebaseFirestore.instance;
//
//   @override
//   Future<void> addData({
//     required String collectionName,
//     required Map<String, dynamic> data,
//     String? docId,
//   }) async {
//     if (docId != null) {
//       await firestore.collection(collectionName).doc(docId).set(data);
//     } else {
//       await firestore.collection(collectionName).add(data);
//     }
//   }
//
//   @override
//   Future<dynamic> getData({
//     required String collectionName,
//     String? docId,
//     Map<String, dynamic>? query,
//   }) async {
//     if (docId != null) {
//       var data = await firestore.collection(collectionName).doc(docId).get();
//       return data.data();
//     } else {
//       Query<Map<String, dynamic>> collection = firestore.collection(collectionName);
//
//       if (query != null) {
//         if (query['orderBy'] != null) {
//           collection = collection.orderBy(query['orderBy'], descending: query['descending'] ?? false);
//         }
//         if (query['limit'] != null) {
//           collection = collection.limit(query['limit']);
//         }
//       }
//
//       var result = await collection.get();
//       return result.docs.map((e) => e.data()).toList();
//     }
//   }
//
//
//   @override
//   Future<bool> checkIfUserExists({
//     required String collectionName,
//     required String docId,
//   }) async {
//     var data = await firestore.collection(collectionName).doc(docId).get();
//     return data.exists;
//   }
// }
