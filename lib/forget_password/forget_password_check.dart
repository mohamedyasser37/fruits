// import 'package:flutter/material.dart';
// import 'package:fruits/custom_widgets/custom_button.dart';
// import 'package:fruits/custom_widgets/otp.dart';
// import 'package:fruits/forget_password/new_password.dart';
// import 'package:fruits/helper/app_text_styles.dart';
// import 'package:fruits/helper/app_colors.dart';
//
// class ForgetPasswordCheck extends StatefulWidget {
//   const ForgetPasswordCheck({super.key});
//   static const String routeName = 'forget_password_check';
//
//   @override
//   State<ForgetPasswordCheck> createState() => _ForgetPasswordCheckState();
// }
//
// class _ForgetPasswordCheckState extends State<ForgetPasswordCheck> {
//   final TextEditingController otpController = TextEditingController();
//
//   void submitOtp() {
//     if (otpController.text.length != 6) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('رمز التحقق غير صالح')),
//       );
//       return;
//     }
//     Navigator.pushReplacementNamed(context, NewPassword.routeName);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final String phone = ModalRoute.of(context)?.settings.arguments as String? ?? '';
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('التحقق من الرمز', style: TextStyles.bold19),
//         centerTitle: true,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios),
//           onPressed: () => Navigator.pop(context),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             Text('أدخل الرمز الذي أرسلناه إلى الرقم $phone'),
//             const SizedBox(height: 32),
//             OtpFields(onCompleted: (otp) {
//               otpController.text = otp;
//             }),
//             const SizedBox(height: 32),
//             CustomButton(onPressed: submitOtp, text: 'تأكيد الرمز'),
//             const SizedBox(height: 16),
//             TextButton(
//               onPressed: () {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(content: Text('تم إعادة إرسال الرمز')),
//                 );
//               },
//               child: Text('إعادة إرسال الرمز', style: TextStyles.semiBold16.copyWith(color: AppColors.lightPrimary)),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
