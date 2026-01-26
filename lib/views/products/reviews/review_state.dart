part of 'review_cubit.dart';

abstract class ReviewState {}
class ReviewInitial extends ReviewState {}
class AddReviewLoading extends ReviewState {}
class AddReviewSuccess extends ReviewState {}
class AddReviewFailure extends ReviewState {
  final String errMessage;
  AddReviewFailure(this.errMessage);
}