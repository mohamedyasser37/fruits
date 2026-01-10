import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits/auth/cubit/signup_cubit.dart';
import 'package:fruits/auth/signin/signin_view.dart';
import 'package:fruits/auth/signup/sign_up_view_body.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
class SignUpViewBodyBlocConsumer extends StatelessWidget {
  const SignUpViewBodyBlocConsumer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignupCubit, SignupState>(
      listener: (context, state) {
        if (state is SignupFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
            ),
          );}  else if (state is SignupSuccess) {

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("تم إنشاء الحساب بنجاح")),
          );

          Future.delayed(Duration(milliseconds: 300), () {
            Navigator.pushReplacementNamed(context, SignInView.routeName);
          });


      }
      },
      builder: (context, state) {
        return ModalProgressHUD(
            
            inAsyncCall: state is SignupLoading ? true : false,
            child: SignUpViewBody());
      },
    );
  }
}
