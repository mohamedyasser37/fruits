import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fruits/helper/app_colors.dart';
import 'package:fruits/views/cart/cubit/cart_cubit.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class CustomBottomNavBar extends StatefulWidget {
  const CustomBottomNavBar({super.key, required this.onValueChanged});

  final Function(int) onValueChanged;

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  int selectedIndex = 0;
  static const TextStyle optionStyle = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.w600,
  );
  static const List<Widget> _widgetOptions = <Widget>[
    Text('Home', style: optionStyle),
    Text('Likes', style: optionStyle),
    Text('Search', style: optionStyle),
    Text('Profile', style: optionStyle),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: AppColors.mainColor,
        boxShadow: [
          BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1)),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 27.0, vertical: 16),
          child: GNav(
            rippleColor: Colors.grey[300]!,
            hoverColor: Colors.grey[100]!,
            gap: 8,
            activeColor: AppColors.primary,
            padding: const EdgeInsets.symmetric(vertical: 2),
            duration: const Duration(milliseconds: 200),
            tabBackgroundColor: context.read<CartCubit>().isDarkMode
                ? AppColors.grey.withOpacity(0.1)
                : Color(0xffeeeeee),
            color: AppColors.lightPrimary,
            tabs: [
              GButton(
                icon: Icons.home,
                leading: CircleAvatar(
                  radius: 18,
                  backgroundColor: selectedIndex == 0
                      ? AppColors.primary
                      : Colors.transparent,
                  child: SvgPicture.asset(
                    selectedIndex == 0
                        ? 'assets/images/bold/home.svg'
                        : 'assets/images/outline/home.svg',
                    width: 18,
                    height: 18,
                  ),
                ),
                text: 'الرئيسية',
              ),

              GButton(
                icon: Icons.home,
                leading: CircleAvatar(
                  radius: 15,
                  backgroundColor: selectedIndex == 1
                      ? AppColors.primary
                      : Colors.transparent,
                  child: SvgPicture.asset(
                    selectedIndex == 1
                        ? 'assets/images/bold/products.svg'
                        : 'assets/images/outline/products.svg',
                    width: 16,
                    height: 16,
                  ),
                ),
                text: 'المنتجات',
              ),

              GButton(
                icon: Icons.home,
                leading: CircleAvatar(
                  radius: 15,
                  backgroundColor: selectedIndex == 2
                      ? AppColors.primary
                      : Colors.transparent,
                  child: SvgPicture.asset(
                    selectedIndex == 2
                        ? 'assets/images/bold/shopping-cart.svg'
                        : 'assets/images/outline/shopping-cart.svg',
                    width: 16,
                    height: 16,
                  ),
                ),
                text: 'سلة التسوق',
              ),

              GButton(
                icon: Icons.home,
                leading: CircleAvatar(
                  radius: 15,
                  backgroundColor: selectedIndex == 3
                      ? AppColors.primary
                      : Colors.transparent,
                  child: SvgPicture.asset(
                    selectedIndex == 3
                        ? 'assets/images/bold/user.svg'
                        : 'assets/images/outline/user.svg',
                    width: 16,
                    height: 16,
                  ),
                ),
                text: 'حسابي',
              ),
            ],
            selectedIndex: selectedIndex,
            onTabChange: (index) {
              setState(() {
                selectedIndex = index;
                widget.onValueChanged(index);
              });
            },
          ),
        ),
      ),
    );
  }
}
