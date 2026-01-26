import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits/core/entities/review_entity.dart';
import 'package:fruits/repos/product_repo.dart'; // تأكد من مسار الـ Repo
part 'review_state.dart';

class ReviewCubit extends Cubit<ReviewState> {
  final ProductRepo productRepo;
  ReviewCubit(this.productRepo) : super(ReviewInitial());

  Future<void> addReview({required String productId, required ReviewEntity review}) async {
    emit(AddReviewLoading());
    final result = await productRepo.addReview(productId: productId, review: review);

    result.fold(
          (failure) => emit(AddReviewFailure(failure.message)),
          (success) => emit(AddReviewSuccess()),
    );
  }
}