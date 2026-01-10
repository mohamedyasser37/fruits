import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fruits/auth/signup/sign_up.dart';
import 'package:fruits/auth/signup/terms_view.dart';
import 'package:fruits/helper/app_colors.dart';
import 'package:fruits/helper/app_text_styles.dart';

class CustomTerms extends StatefulWidget {
  const CustomTerms({super.key, required this.onChanged});

  final ValueChanged<bool> onChanged;

  @override
  State<CustomTerms> createState() => _CustomTermsState();
}

class _CustomTermsState extends State<CustomTerms> {

  bool isChecked = false;



  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              isChecked = !isChecked;
              widget.onChanged(isChecked);
            });
          },
          child: AnimatedContainer(

            duration: const Duration(milliseconds: 100),
            width: 26,
            height: 26,
            decoration: BoxDecoration(
              color: isChecked ? AppColors.primary : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: isChecked ? AppColors.primary : const Color(0xff949D9E),
                width: 2,
              ),
            ),
            child: isChecked
                ? const Icon(Icons.check, color: Colors.white, size: 18)
                : null,
          ),
        ),
        const SizedBox(width: 8),

        Expanded(
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "من خلال إنشاء حساب ، فإنك توافق على ",
                  style: TextStyles.semiBold16.copyWith(
                    color: const Color(0xff949D9E),
                  ),
                ),
                TextSpan(
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.pushNamed(context, TermsView.routeName);
                    },
                  text: "الشروط والأحكام الخاصة بنا",
                  style: TextStyles.semiBold16.copyWith(
                    color: AppColors.lightPrimary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
