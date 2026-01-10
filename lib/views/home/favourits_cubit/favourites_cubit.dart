import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fruits/core/models/product_model.dart';

class FavoritesCubit extends Cubit<List<ProductModel>> {
  final String userId; // معرف المستخدم
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  FavoritesCubit({required this.userId}) : super([]) {
    loadFavorites(); // تحميل المفضلة عند بدء التشغيل
  }

  Future<void> loadFavorites() async {
    final snapshot = await firestore
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .get();

    final favProducts = snapshot.docs.map((doc) {
      final data = doc.data();
      return ProductModel.fromJson(data);
    }).toList();

    emit(favProducts);
  }

  Future<void> toggleFavorite(ProductModel product) async {
    final favRef = firestore
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .doc(product.id);

    final isFav = state.any((p) => p.id == product.id);

    if (isFav) {
      await favRef.delete();
      emit(state.where((p) => p.id != product.id).toList());
    } else {
      await favRef.set(product.toJson());
      emit([...state, product..isFavorite = true]);
    }
  }

  bool isFavorite(ProductModel product) {
    return state.any((p) => p.id == product.id);
  }
}
