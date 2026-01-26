import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits/helper/app_colors.dart';
import 'package:fruits/helper/app_text_styles.dart';
import 'package:fruits/views/cart/cubit/cart_cubit.dart';

class MyOrdersView extends StatelessWidget {
  const MyOrdersView({super.key});
  static const routeName = 'myOrders';

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.watch<CartCubit>().isDarkMode;
    final String uId = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      backgroundColor: isDark ? AppColors.mainBlack : const Color(0xFFF9F9F9),
      appBar: AppBar(
        title: Text(
            'طلباتي',
            style: TextStyles.bold19.copyWith(
                color: isDark ? AppColors.mainWhite : AppColors.mainBlack
            )
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
              Icons.arrow_back_ios,
              color: isDark ? AppColors.mainWhite : AppColors.mainBlack
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('orders')
            .where('uId', isEqualTo: uId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text(
                'لا توجد طلبات حتى الآن',
                style: TextStyle(color: isDark ? Colors.grey : Colors.black54),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var order = snapshot.data!.docs[index].data() as Map<String, dynamic>;
              return OrderExpansionItem(order: order, isDark: isDark);
            },
          );
        },
      ),
    );
  }
}

class OrderExpansionItem extends StatelessWidget {
  final Map<String, dynamic> order;
  final bool isDark;

  const OrderExpansionItem({super.key, required this.order, required this.isDark});

  @override
  Widget build(BuildContext context) {
    List productsList = order['orderProducts'] as List? ?? [];

    String productNames = productsList.map((item) => item['name'] ?? 'منتج').join(' ، ');

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF191919) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: isDark ? Border.all(color: Colors.white10) : null,
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
          iconTheme: IconThemeData(color: isDark ? Colors.white70 : Colors.black45),
        ),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isDark ? Colors.white10 : const Color(0xFFE8F5E9),
              shape: BoxShape.circle,
            ),
            child: Icon(
                Icons.inventory_2_outlined,
                color: isDark ? AppColors.primary : const Color(0xFF1B5E20)
            ),
          ),
          title: Text(
            productNames,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyles.bold19.copyWith(
              color: AppColors.primary,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              Text(
                'طلب رقم: #${order['orderId']?.toString().substring(0, 7) ?? '0000'}',
                style: TextStyles.regular13.copyWith(
                  color: isDark ? AppColors.mainWhite.withOpacity(0.9) : AppColors.mainBlack,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                ' تم الطلب :  ${order['date']?.toString().split(' ')[0] ?? ''}',
                style: TextStyles.regular13.copyWith(color: Colors.grey),
              ),
              const SizedBox(height: 4),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(text: 'العدد: ', style: TextStyles.regular13.copyWith(color: Colors.grey)),
                    TextSpan(text: ' ${productsList.length}  ', style: TextStyles.bold13.copyWith(color: isDark ? AppColors.mainWhite : AppColors.mainBlack)),
                    TextSpan(text: '|  الاجمالي: ', style: TextStyles.regular13.copyWith(color: Colors.grey)),
                    TextSpan(text: ' ${order['totalPrice'] ?? 0} جنية', style: TextStyles.bold13.copyWith(color: isDark ? AppColors.mainWhite : AppColors.mainBlack)),
                  ],
                ),
              ),
            ],
          ),
          children: [
            Divider(
                indent: 16,
                endIndent: 16,
                color: isDark ? Colors.white10 : Colors.grey.shade200
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: OrderTimeline(
                status: order['status'] ?? 'pending',
                date: order['date']?.toString() ?? '',
                isDark: isDark,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class OrderTimeline extends StatelessWidget {
  final String status;
  final String date;
  final bool isDark;

  const OrderTimeline({super.key, required this.status, required this.date, required this.isDark});

  @override
  Widget build(BuildContext context) {
    List<String> statuses = ['pending', 'accepted', 'shipped', 'out_for_delivery', 'delivered'];
    int currentStep = statuses.indexOf(status.toLowerCase());

    return Column(
      children: [
        _buildTimelineStep('تتبع الطلب', date, true),
        _buildTimelineStep('قبول الطلب', date, currentStep >= 1),
        _buildTimelineStep('تم شحن الطلب', date, currentStep >= 2),
        _buildTimelineStep('خرج للتوصيل', 'قيد الانتظار', currentStep >= 3),
        _buildTimelineStep('تم تسليم', 'تم التسليم', currentStep >= 4),
      ],
    );
  }

  Widget _buildTimelineStep(String title, String subtitle, bool isCompleted) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 14,
              height: 14,
              decoration: BoxDecoration(
                color: isCompleted ? AppColors.primary : (isDark ? Colors.white12 : Colors.grey[300]),
                shape: BoxShape.circle,
              ),
            ),
            Container(
              width: 2,
              height: 40,
              color: isCompleted ? AppColors.primary : (isDark ? Colors.white10 : Colors.grey[300]),
            ),
          ],
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: isCompleted
                      ? (isDark ? Colors.white : Colors.black)
                      : Colors.grey,
                  fontWeight: isCompleted ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              Text(
                subtitle.split(' ')[0],
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
        ),
      ],
    );
  }
}