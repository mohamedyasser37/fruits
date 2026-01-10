import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits/auth/cubit/signup_cubit.dart';
import 'package:fruits/auth/domain/repos/auth_repo.dart';
import 'package:fruits/auth/signup/signup_view_body_bloc_consumer.dart';
import 'package:fruits/helper/app_text_styles.dart';
import 'package:fruits/helper/get_it.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  static const String routeName = 'sign_up';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupCubit(getIt<AuthRepo>()),
      child: Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: IconButton(
              iconSize: 30,
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios),
            ),
          ),
          title: const Text('حساب جديد', style: TextStyles.bold19),
          centerTitle: true,
        ),
        body: SignUpViewBodyBlocConsumer(),
      ),
    );
  }
}

