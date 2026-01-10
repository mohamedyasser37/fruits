import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits/auth/signin/signin_view_body.dart';
import 'package:fruits/auth/signin_cubit/signin_cubit.dart';
import 'package:fruits/views/main_view.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignInViewBodyBlocConsumer extends StatelessWidget {
  const SignInViewBodyBlocConsumer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SigninCubit, SigninState>(
      listener: (context, state) {
        if (state is SigninFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        } else if (state is SigninSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(

            SnackBar(content: Text("تم تسجيل الدخول بنجاح"),duration: Duration(seconds: 2),),
          );

          Future.delayed(Duration(milliseconds: 200), () {
            Navigator.pushReplacementNamed(context, MainView.routeName);
          });
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
            inAsyncCall: state is SigninLoading ? true : false,
            child: SignInViewBody());
      },
    );
  }
}
