import 'package:flutter/material.dart';
import 'package:fruits/custom_widgets/custom_text_form_field.dart';
import 'package:fruits/helper/app_colors.dart';
import 'package:fruits/helper/app_text_styles.dart';

class PasswordFiled extends StatefulWidget {
  const PasswordFiled({
    super.key,
    required this.passwordController,
  });

  final TextEditingController passwordController;

  @override
  State<PasswordFiled> createState() => _PasswordFiledState();
}

class _PasswordFiledState extends State<PasswordFiled> {
  bool isObscure = true;
  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      controller: widget.passwordController,
      isObscure: isObscure,
      hintText: 'كلمة المرور',
      style: TextStyles.semiBold16.copyWith(
        color:
        AppColors.mainBlack,
      ),
      suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              isObscure = !isObscure;
            });
          },
          child: isObscure
              ? const Icon(Icons.remove_red_eye): const Icon(Icons.visibility_off)),
      keyboardType: TextInputType.visiblePassword,
    );
  }
}