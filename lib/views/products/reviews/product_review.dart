import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fruits/core/entities/product_entity.dart';
import 'package:fruits/core/entities/review_entity.dart';
import 'package:fruits/core/models/product_model.dart';
import 'package:fruits/cubit/get_products_cubit.dart';
import 'package:fruits/helper/app_colors.dart';
import 'package:fruits/helper/app_text_styles.dart';
import 'package:fruits/helper/get_it.dart';
import 'package:fruits/helper/get_user_data.dart';
import 'package:fruits/repos/product_repo.dart';
import 'package:fruits/views/cart/cubit/cart_cubit.dart';
import 'package:fruits/views/products/reviews/review_cubit.dart';
import 'package:get_it/get_it.dart';

class ProductReview extends StatelessWidget {
  const ProductReview({super.key, required this.productEntity});

  final ProductEntity productEntity;
  static const String routeName = 'productReview';

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<CartCubit>().isDarkMode;
    final Color textColor = isDark ? AppColors.mainWhite : AppColors.mainBlack;
    final Color scaffoldBg = isDark ? AppColors.mainBlack : AppColors.mainWhite;

    return BlocProvider(
      // إنشاء الكيوبيت فور فتح الصفحة
      create: (context) =>
          GetProductsCubit(getIt<ProductRepo>())..getProducts(),
      child: Scaffold(
        backgroundColor: scaffoldBg,
        appBar: AppBar(
          backgroundColor: scaffoldBg,
          elevation: 0,
          title: Text(
            'المراجعه',
            style: TextStyles.bold19.copyWith(color: textColor),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: textColor),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: BlocBuilder<GetProductsCubit, GetProductsState>(
          builder: (context, state) {
            ProductEntity currentProduct = productEntity;

            if (state is GetProductsSuccess) {
              currentProduct = state.products
                  .firstWhere(
                    (p) => p.id == productEntity.id,
                    orElse: () => productEntity as ProductModel,
                  )
                  .toEntity();
            }

            // عرض مؤشر تحميل لو الداتا لسه بتيجي لأول مرة
            if (state is GetProductsLoading && currentProduct.reviews.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _AddReviewField(productId: currentProduct.id, isDark: isDark),
                  const SizedBox(height: 24),
                  _buildSummarySection(currentProduct, textColor),
                  const SizedBox(height: 32),
                  currentProduct.reviews.isEmpty
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Text(
                              "لا توجد مراجعات بعد",
                              style: TextStyle(color: textColor),
                            ),
                          ),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: currentProduct.reviews.length,
                          itemBuilder: (context, index) => _buildReviewItem(
                            currentProduct.reviews[index],
                            textColor,
                            isDark,
                          ),
                        ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  // --- Widgets البناء ---

  Widget _buildSummarySection(ProductEntity product, Color textColor) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Column(
            children: List.generate(5, (index) {
              int star = 5 - index;
              double percent = product.reviews.isEmpty
                  ? 0
                  : product.reviews
                            .where((r) => r.ratting.round() == star)
                            .length /
                        product.reviews.length;
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Row(
                  children: [
                    Text(
                      '$star',
                      style: TextStyle(fontSize: 12, color: textColor),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: LinearProgressIndicator(
                        value: percent,
                        color: Colors.orange,
                        backgroundColor: Colors.grey[300],
                        minHeight: 6,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
        const SizedBox(width: 20),
        Column(
          children: [
            Row(
              children: [
                Text(
                  product.avgRating.toStringAsFixed(1),
                  style: TextStyles.bold19.copyWith(color: textColor),
                ),
                const Icon(Icons.star, color: Colors.orange),
              ],
            ),
            Text(
              '${product.ratingCount} مراجعه',
              style: TextStyles.regular16.copyWith(color: Colors.grey),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildReviewItem(ReviewEntity review, Color textColor, bool isDark) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.withOpacity(0.2))),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundImage: review.image.startsWith('http')
                    ? NetworkImage(review.image)
                    : const AssetImage('assets/images/profile_image.png')
                          as ImageProvider,
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    review.name,
                    style: TextStyles.bold16.copyWith(color: textColor),
                  ),
                  Text(
                    review.date,
                    style: const TextStyle(fontSize: 10, color: Colors.grey),
                  ),
                ],
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Text(
                      '${review.ratting}',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      ),
                    ),
                    const Icon(Icons.star, size: 12, color: Colors.orange),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            review.reviewDescription,
            style: TextStyles.regular16.copyWith(
              color: isDark ? Colors.grey[400] : Colors.grey[700],
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

// ويدجت حقل "اكتب تعليق"
class _AddReviewField extends StatelessWidget {
  final String productId;
  final bool isDark;

  const _AddReviewField({required this.productId, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final Color cardBg = isDark ? const Color(0xff191919) : Colors.grey[100]!;
    return GestureDetector(
      onTap: () => _showAddReviewBottomSheet(context, productId, isDark),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            const CircleAvatar(
              backgroundImage: AssetImage('assets/images/profile_image.png'),
            ),
            const SizedBox(width: 12),
            Text(
              'اكتب التعليق..',
              style: TextStyles.regular16.copyWith(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddReviewBottomSheet(
    BuildContext parentContext,
    String productId,
    bool isDark,
  ) {
    showModalBottomSheet(
      context: parentContext,
      isScrollControlled: true,
      backgroundColor: isDark ? const Color(0xff191919) : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ReviewCubit(GetIt.I<ProductRepo>()),
          ),
          // تمرير الـ Cubit الخاص بالصفحة للـ BottomSheet
          BlocProvider.value(value: parentContext.read<GetProductsCubit>()),
        ],
        child: _AddReviewForm(productId: productId, isDark: isDark),
      ),
    );
  }
}

class _AddReviewForm extends StatefulWidget {
  final String productId;
  final bool isDark;

  const _AddReviewForm({required this.productId, required this.isDark});

  @override
  State<_AddReviewForm> createState() => _AddReviewFormState();
}

class _AddReviewFormState extends State<_AddReviewForm> {
  double rating = 0;
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final textColor = widget.isDark ? AppColors.mainWhite : AppColors.mainBlack;

    return BlocConsumer<ReviewCubit, ReviewState>(
      listener: (context, state) {
        if (state is AddReviewSuccess) {
          // التحديث الفوري: طلب البيانات فور النجاح
          context.read<GetProductsCubit>().getProducts();
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 20,
            right: 20,
            top: 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'ما هو تقييمك؟',
                style: TextStyles.bold16.copyWith(color: textColor),
              ),
              const SizedBox(height: 16),
              RatingBar.builder(
                itemSize: 40,
                unratedColor: Colors.grey[300],
                itemBuilder: (context, _) =>
                    const Icon(Icons.star, color: Colors.amber),
                onRatingUpdate: (val) => rating = val,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: controller,
                style: TextStyle(color: textColor),
                decoration: InputDecoration(
                  hintText: 'اكتب رأيك هنا...',
                  hintStyle: const TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: widget.isDark ? Colors.black26 : Colors.grey[50],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 24),
              state is AddReviewLoading
                  ? const CircularProgressIndicator(
                color: AppColors.primary,
              )
                  : SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          if (rating > 0 && controller.text.isNotEmpty) {
                            context.read<ReviewCubit>().addReview(
                              productId: widget.productId,
                              review: ReviewEntity(
                                name: getUser().name,
                                image: "assets/images/profile_image.png",
                                ratting: rating,
                                date:
                                    "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                                reviewDescription: controller.text,
                              ),
                            );
                          }
                        },
                        child: Text(
                          'إرسال التقييم',
                          style: TextStyles.bold16.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
              const SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }
}
