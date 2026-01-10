// import 'package:flutter/material.dart';
// import 'package:fruits/custom_widgets/custom_button.dart';
// import 'package:fruits/forget_password/forget_password_check.dart';
// import 'package:fruits/helper/app_text_styles.dart';
//
// class ForgetPasswordViewBody extends StatefulWidget {
//   const ForgetPasswordViewBody({super.key});
//
//   @override
//   State<ForgetPasswordViewBody> createState() => _ForgetPasswordViewBodyState();
// }
//
// class _ForgetPasswordViewBodyState extends State<ForgetPasswordViewBody> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController phoneController = TextEditingController();
//
//   String formatPhone(String phone) {
//     phone = phone.trim();
//     if (phone.startsWith('0')) phone = phone.substring(1);
//     return '+2$phone'; // مصر +2
//   }
//
//   String? validatePhone(String? value) {
//     if (value == null || value.isEmpty) return 'الرجاء إدخال رقم الهاتف';
//     if (value.length < 10) return 'رقم الهاتف غير صحيح';
//     return null;
//   }
//
//   void submit() {
//     if (_formKey.currentState!.validate()) {
//       String formattedPhone = formatPhone(phoneController.text);
//       Navigator.pushNamed(
//         context,
//         ForgetPasswordCheck.routeName,
//         arguments: formattedPhone,
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('الرجاء إدخال رقم هاتف صحيح')),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               SizedBox(
//                 width: double.infinity,
//                 child: Text(
//                   'لا تقلق ، ما عليك سوى كتابة رقم هاتفك وسنرسل رمز التحقق.',
//                   style: TextStyles.semiBold16,
//                 ),
//               ),
//               const SizedBox(height: 32),
//               TextFormField(
//                 controller: phoneController,
//                 keyboardType: TextInputType.phone,
//                 decoration: InputDecoration(
//                   filled: true,
//                   fillColor: const Color(0xffF9FAFA),
//                   hintText: 'رقم الهاتف',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//                 validator: validatePhone,
//               ),
//               const SizedBox(height: 32),
//               CustomButton(onPressed: submit, text: 'إرسال الرمز'),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
