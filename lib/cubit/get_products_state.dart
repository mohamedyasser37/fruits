part of 'get_products_cubit.dart';

@immutable
sealed class GetProductsState {}

final class GetProductsInitial extends GetProductsState {}
final class ChangeMode extends GetProductsState {}
final class GetProductsLoading extends GetProductsState {}
final class GetProductsSuccess extends GetProductsState {
  final List<ProductModel> products;

  GetProductsSuccess({required this.products});
}
final class GetProductsError extends GetProductsState {
  final String message;

  GetProductsError({required this.message});
}



