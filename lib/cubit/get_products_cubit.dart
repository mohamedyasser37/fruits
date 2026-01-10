import 'package:bloc/bloc.dart';
import 'package:fruits/core/entities/product_entity.dart';
import 'package:fruits/core/models/product_model.dart';
import 'package:fruits/helper/app_colors.dart';
import 'package:fruits/helper/shared_prefrence.dart';
import 'package:fruits/repos/product_repo.dart';
import 'package:meta/meta.dart';

part 'get_products_state.dart';

class GetProductsCubit extends Cubit<GetProductsState> {
  final ProductRepo productRepo;

  GetProductsCubit(this.productRepo) : super(GetProductsInitial());
  int length = 0;

  Future<void> getProducts() async {
    emit(GetProductsLoading());
    final result = await productRepo.getProducts();
    result.fold(
      (failure) => emit(GetProductsError(message: failure.message)),
      (products){
        length = products.length;
        emit(GetProductsSuccess(products: products));
      }
    );
  }

  Future<void> getBestSellingProducts() async {
    emit(GetProductsLoading());
    final result = await productRepo.getProducts();
    result.fold(
          (failure) => emit(GetProductsError(message: failure.message)),
          (products) => emit(GetProductsSuccess(products: products)),
    );
  }


  void changeMode(bool isDark){

    AppColors.mainBlack =  AppColors.mainWhite ;

    Prefs.setBool('isDark', isDark);
    emit(ChangeMode());





  }


}
