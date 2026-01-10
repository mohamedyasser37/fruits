import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fruits/auth/cubit/signup_cubit.dart';
import 'package:fruits/auth/signin/signin_view.dart';
import 'package:fruits/custom_widgets/custom_button.dart';
import 'package:fruits/helper/app_colors.dart';
import 'package:fruits/helper/app_text_styles.dart';
import 'package:fruits/helper/get_user_data.dart';
import 'package:fruits/views/cart/cubit/cart_cubit.dart';
import 'package:fruits/views/profile/views/about_us_view.dart';
import 'package:fruits/views/profile/views/personal_favourite.dart';
import 'package:fruits/views/profile/views/personal_profile.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';

class ProfileViewBody extends StatefulWidget {
  const ProfileViewBody({super.key});

  @override
  State<ProfileViewBody> createState() => _ProfileViewBodyState();
}

class _ProfileViewBodyState extends State<ProfileViewBody> {
  File? _avatarImage;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _loadSavedImage();
  }

  Future<void> _loadSavedImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? path = prefs.getString('avatar_path');
    if (path != null && File(path).existsSync()) {
      setState(() {
        _avatarImage = File(path);
      });
    }
  }

  Future<void> _pickImage() async {
    final XFile? pickedFile =
    await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final directory = await getApplicationDocumentsDirectory();
      final String newPath = '${directory.path}/avatar.png';
      final File newImage = await File(pickedFile.path).copy(newPath);

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('avatar_path', newPath);

      setState(() {
        _avatarImage = newImage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<CartCubit>().isDarkMode;

    return Scaffold(
      backgroundColor: isDark ? AppColors.mainBlack : AppColors.mainWhite,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // عنوان "حسابي"
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'حسابي',
                  style: TextStyles.bold19.copyWith(
                    color: isDark ? AppColors.mainWhite : AppColors.mainBlack,
                  ),
                ),
              ],
            ),
            // الصورة والاسم والايميل
            Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  SizedBox(
                    height: 80,
                    width: 80,
                    child: GestureDetector(
                      onTap: _pickImage,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          CircleAvatar(
                            radius: 35,
                            backgroundImage: _avatarImage != null
                                ? FileImage(_avatarImage!)
                                : const AssetImage(
                                'assets/images/profile_image2.png')
                            as ImageProvider,
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: isDark
                                    ? const Color(0xff191919).withOpacity(0.1)
                                    : const Color(0xffebf9f1),
                                shape: BoxShape.circle,
                                boxShadow: const [
                                  BoxShadow(
                                      color: Colors.black26, blurRadius: 4),
                                ],
                              ),
                              child: Icon(
                                Icons.camera_alt,
                                size: 16,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          getUser().name,
                          style: TextStyles.bold16.copyWith(
                            color: isDark ? AppColors.mainWhite : AppColors.mainBlack,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          getUser().email,
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'عام',
                style: TextStyles.semiBold16.copyWith(
                  color: isDark ? AppColors.mainWhite : AppColors.mainBlack,
                ),
              ),
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, PersonalProfile.routeName);
              },
              child: const CustomProfileLisTile(
                leading: Icon(Icons.person_3_outlined),
                title: 'الملف الشخصي',
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            ),
            const CustomProfileLisTile(
              leading: Icon(Icons.domain_verification_outlined),
              title: 'طلباتي',
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, PersonalFavourite.routeName);
              },
              child: const CustomProfileLisTile(
                leading: Icon(Icons.favorite_border),
                title: 'المفضلة',
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            ),
            const CustomProfileLisTile(
              leading: Icon(Icons.notifications_none_outlined),
              title: 'الاشعارات',
              trailing: Switch(
                activeTrackColor: Colors.grey,
                value: true,
                activeColor: AppColors.primary,
                inactiveThumbColor: Colors.white,
                inactiveTrackColor: Colors.grey,
                onChanged: null,
              ),
            ),
            const CustomProfileLisTile(
              leading: Icon(Icons.language_outlined),
              title: 'اللغة',
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('العربية', style: TextStyles.regular16),
                  Icon(Icons.arrow_forward_ios),
                ],
              ),
            ),
            BlocBuilder<CartCubit, CartState>(
              builder: (context, state) {
                final cubit = context.read<CartCubit>();
                return CustomProfileLisTile(
                  leading: const Icon(Icons.brightness_4_outlined),
                  title: 'الوضع',
                  trailing: Switch(
                    value: cubit.isDarkMode,
                    activeColor: AppColors.primary,
                    activeTrackColor: Colors.grey.shade300,
                    inactiveThumbColor: Colors.white,
                    inactiveTrackColor: Colors.grey.shade300,
                    onChanged: (value) {
                      cubit.changeMode(value);
                    },
                  ),
                );
              },
            ),
            const SizedBox(height: 22),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'المساعده',
                style: TextStyles.semiBold16.copyWith(
                  color: isDark ? AppColors.mainWhite : AppColors.mainBlack,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, AboutUsView.routeName);
              },
              child: const CustomProfileLisTile(
                leading: Icon(Icons.error_outline_outlined),
                title: 'من نحن',
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            ),
            const SizedBox(height: 60),
            Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                color: isDark ? const Color(0xff191919) : const Color(0xffebf9f1),
              ),
              child: GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      backgroundColor: isDark ? const Color(0xff191919) : const Color(0xffebf9f1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(
                            'assets/images/password_check.svg',
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'هل ترغب في تسجيل الخروج ؟',
                            textAlign: TextAlign.center,
                            style: TextStyles.semiBold16.copyWith(
                              color: isDark ? AppColors.mainWhite : AppColors.mainBlack,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: CustomButton(
                                  onPressed: () {
                                    context.read<SignupCubit>().logOut();
                                    Navigator.pop(context);
                                    Navigator.pushReplacementNamed(
                                      context,
                                      SignInView.routeName,
                                    );
                                  },
                                  text: 'تأكيد',
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: CustomButton(
                                  textColor: AppColors.primary,
                                  backgroundColor: Colors.white,
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  text: 'لا أرغب',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'تسجيل الخروج',
                      style: TextStyles.bold16.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                    Icon(Icons.login, color: AppColors.primary),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomProfileLisTile extends StatelessWidget {
  const CustomProfileLisTile({
    super.key,
    required this.trailing,
    required this.title,
    required this.leading,
  });

  final Widget leading, trailing;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Color(0xffE0E0E0), width: 1),
          ),
        ),
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          iconColor: AppColors.primary,
          leading: leading,
          trailing: trailing,
          title: Text(
            title,
            style: TextStyles.semiBold16.copyWith(color: const Color(0xff949D9E)),
          ),
        ),
      ),
    );
  }
}
