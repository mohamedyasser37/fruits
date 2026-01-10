import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits/auth/signin_cubit/signin_cubit.dart';
import 'package:fruits/auth/signup/sign_up.dart';
import 'package:fruits/custom_widgets/custom_button.dart';
import 'package:fruits/custom_widgets/custom_list_tile.dart';
import 'package:fruits/custom_widgets/custom_or.dart';
import 'package:fruits/custom_widgets/custom_text_form_field.dart';
import 'package:fruits/custom_widgets/password_filed.dart';
import 'package:fruits/forget_password/forget_password.dart';
import 'package:fruits/helper/app_colors.dart';
import 'package:fruits/helper/app_text_styles.dart';

class SignInViewBody extends StatefulWidget {
  const SignInViewBody({super.key});


  @override
  State<SignInViewBody> createState() => _SignInViewBodyState();
}

class _SignInViewBodyState extends State<SignInViewBody> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              SizedBox(height: 24),
              CustomTextFormField(
                controller: emailController,
                hintText: 'البريد الالكتروني',
                suffixIcon: const Icon(Icons.email),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 20),
              PasswordFiled(

                  passwordController: passwordController),
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, ForgetPasswordEmail.routeName);
                    },
                    child: Text(
                      'نسيت كلمة المرور؟',
                      style: TextStyles.semiBold16.copyWith(
                        color: AppColors.lightPrimary,
                      ),
                    ),
                  ),
                ],
              ),
              CustomButton(onPressed: () {
                if (formKey.currentState!.validate()) {
                  formKey.currentState!.save();
                  context.read<SigninCubit>().signInWithEmailAndPassword(
                    emailController.text,
                    passwordController.text,
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('الرجاء ملء جميع الحقول بشكل صحيح'),
                    ),
                  );
                }
              }, text:'تسجيل دخول'),
              SizedBox(height: 32),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "لا تمتلك حساب؟ ",
                      style: TextStyles.semiBold16.copyWith(color: Color(0xff949D9E)),
                    ),
                    TextSpan(
                      recognizer: TapGestureRecognizer()..onTap = () {
                        Navigator.pushNamed(context, SignUp.routeName);
                      },
                      text: "قم بإنشاء حساب",
                      style: TextStyles.semiBold16.copyWith(color: AppColors.lightPrimary),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 32),
              CustomOr(),
              SizedBox(height: 32),
              CustomListTile(
                image: "assets/images/google_icon.svg",
                title: "تسجيل بواسطة جوجل",
                onTap: () {
                  context.read<SigninCubit>().signInWithGoogle();
                },
              ),
              SizedBox(height: 16),
         Platform.isAndroid
                  ? SizedBox()
                  :     Column(
                    children: [
                      CustomListTile(
                                      title: "تسجيل بواسطة أبل",
                                      image: "assets/images/appl_icon.svg",
                                      onTap: () {},
                                    ),
                      SizedBox(height: 16),

                    ],
                  ),
              CustomListTile(
                title: "تسجيل بواسطة فيسبوك",
                image: "assets/images/facebook_icon.svg",
                onTap: () {
                  context.read<SigninCubit>().signInWithFacebook();

                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
