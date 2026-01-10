import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:fruits/helper/app_colors.dart';
import 'package:fruits/helper/app_text_styles.dart';


void showScaffoldBar(BuildContext context, String message) {
  Flushbar(
    message: message,
    duration: Duration(seconds: 2),
    backgroundColor: AppColors.primary,
    margin: EdgeInsets.symmetric(horizontal: 16,vertical: 60),
    borderRadius: BorderRadius.circular(16),
    flushbarPosition: FlushbarPosition.TOP, // تظهر من فوق
  ).show(context);
}







// void showScaffoldBar(BuildContext context, String message) {
//   ScaffoldMessenger.of(context).showSnackBar(
//     SnackBar(
//
//       dismissDirection: DismissDirection.horizontal,
//       backgroundColor: AppColors.primary,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//       behavior: SnackBarBehavior.floating,
//       duration: Duration(seconds: 1),
//       content: Text(message, style: TextStyles.semiBold16),
//     ),
//   );
// }
