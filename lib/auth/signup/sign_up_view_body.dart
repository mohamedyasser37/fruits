import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits/auth/cubit/signup_cubit.dart';
import 'package:fruits/custom_widgets/custom_button.dart';
import 'package:fruits/custom_widgets/custom_terms.dart';
import 'package:fruits/custom_widgets/custom_text_form_field.dart';
import 'package:fruits/custom_widgets/password_filed.dart';
import 'package:fruits/helper/app_colors.dart';
import 'package:fruits/helper/app_text_styles.dart';

class SignUpViewBody extends StatefulWidget {
  const SignUpViewBody({super.key});

  @override
  State<SignUpViewBody> createState() => _SignUpViewBodyState();
}

class _SignUpViewBodyState extends State<SignUpViewBody> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isObscure = true;
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              SizedBox(height: 24),
              CustomTextFormField(
                controller: nameController,
                hintText: 'الاسم كامل',
                suffixIcon: const Icon(Icons.person),
                keyboardType: TextInputType.name,
              ),
              SizedBox(height: 16),
              CustomTextFormField(
                controller: emailController,
                hintText: 'البريد الإلكتروني',
                suffixIcon: const Icon(Icons.email),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 16),
              PasswordFiled(passwordController: passwordController),
              SizedBox(height: 24),
              CustomTerms(
                onChanged: (value) {
                  setState(() {
                    isChecked = value;
                  });
                },
              ),
              SizedBox(height: 30),
              CustomButton(
                onPressed: () {
                  if (!isChecked) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('الرجاء الموافقة على الشروط والأحكام'),
                      ),
                    );
                    return;
                  }

                  if (!formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('الرجاء ملء جميع الحقول'),
                      ),
                    );
                    return;
                  }

                  formKey.currentState!.save();

                  context.read<SignupCubit>().createUserWithEmailAndPassword(
                    emailController.text,
                    passwordController.text,
                    nameController.text,
                  );

                },
                text: 'إنشاء حساب جديد',
              ),
              SizedBox(height: 24),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "تمتلك حساب بالفعل؟ ",
                      style: TextStyles.semiBold16.copyWith(
                        color: const Color(0xff949D9E),
                      ),
                    ),
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pop(context);
                        },
                      text: "تسجيل دخول",
                      style: TextStyles.semiBold16.copyWith(
                        color: AppColors.lightPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
