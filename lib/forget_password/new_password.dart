// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:fruits/auth/signin/signin_view.dart';
// import 'package:fruits/custom_widgets/custom_button.dart';
// import 'package:fruits/helper/app_text_styles.dart';
//
// class NewPassword extends StatefulWidget {
//   const NewPassword({super.key});
//   static const String routeName = 'new_password';
//
//   @override
//   State<NewPassword> createState() => _NewPasswordState();
// }
//
// class _NewPasswordState extends State<NewPassword> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController passwordController = TextEditingController();
//   final TextEditingController confirmController = TextEditingController();
//
//   String? validatePassword(String? value) {
//     if (value == null || value.isEmpty) return 'الرجاء إدخال كلمة المرور';
//     if (value.length < 6) return 'كلمة المرور قصيرة جدًا';
//     return null;
//   }
//
//   void submit() {
//     if (_formKey.currentState!.validate()) {
//       if (passwordController.text != confirmController.text) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('كلمة المرور وتأكيدها غير متطابقين')),
//         );
//         return;
//       }
//
//       showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               SvgPicture.asset('assets/images/password_check.svg'),
//               const SizedBox(height: 16),
//               Text('تم إنشاء كلمة مرور جديدة بنجاح', textAlign: TextAlign.center, style: TextStyles.semiBold16),
//               const SizedBox(height: 16),
//               CustomButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                   Navigator.pushReplacementNamed(context, SignInView.routeName);
//                 },
//                 text: 'حسناً',
//               ),
//             ],
//           ),
//         ),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('إنشاء كلمة مرور جديدة', style: TextStyles.bold19),
//         centerTitle: true,
//         leading: IconButton(icon: const Icon(Icons.arrow_back_ios), onPressed: () => Navigator.pop(context)),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               Text('قم بإنشاء كلمة مرور جديدة لتسجيل الدخول', style: TextStyles.semiBold16),
//               const SizedBox(height: 24),
//               CustomTextFormField(
//                 controller: passwordController,
//                 hintText: 'كلمة المرور الجديدة',
//                 suffixIcon: const Icon(Icons.remove_red_eye),
//                 keyboardType: TextInputType.visiblePassword,
//                 validator: validatePassword,
//               ),
//               const SizedBox(height: 16),
//               CustomTextFormField(
//                 controller: confirmController,
//                 hintText: 'تأكيد كلمة المرور',
//                 suffixIcon: const Icon(Icons.remove_red_eye),
//                 keyboardType: TextInputType.visiblePassword,
//                 validator: validatePassword,
//               ),
//               const SizedBox(height: 24),
//               CustomButton(onPressed: submit, text: 'إنشاء كلمة مرور جديدة'),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class CustomTextFormField extends StatelessWidget {
//   final TextEditingController? controller;
//   final String? hintText;
//   final Widget? suffixIcon;
//   final TextInputType? keyboardType;
//   final String? Function(String?)? validator; // ← أضف هذا
//
//   const CustomTextFormField({
//     super.key,
//     this.controller,
//     this.hintText,
//     this.suffixIcon,
//     this.keyboardType,
//     this.validator, // ← أضف هذا
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       controller: controller,
//       decoration: InputDecoration(
//         hintText: hintText,
//         suffixIcon: suffixIcon,
//         border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
//         filled: true,
//         fillColor: const Color(0xffF9FAFA),
//       ),
//       keyboardType: keyboardType,
//       validator: validator, // ← تمرير هنا
//     );
//   }
// }
//
