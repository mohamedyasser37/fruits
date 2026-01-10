import 'package:flutter/material.dart';
import 'package:fruits/helper/app_colors.dart';
import 'package:fruits/helper/app_text_styles.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.onPressed, required this.text,  this.backgroundColor=AppColors.primary,  this.textColor=Colors.white});
final VoidCallback onPressed;
final String text;

final Color backgroundColor , textColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 54,
      width: double.infinity,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      onPressed:onPressed  ,
          child: Text(text,style: TextStyles.bold19.copyWith(color: textColor),),
      ),
    );
  }
}
