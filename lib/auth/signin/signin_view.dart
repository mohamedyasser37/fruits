import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits/auth/domain/repos/auth_repo.dart';
import 'package:fruits/auth/signin_cubit/signin_cubit.dart';
import 'package:fruits/custom_widgets/signIn_view_body_bloc_consumer.dart';
import 'package:fruits/helper/app_colors.dart';
import 'package:fruits/helper/app_text_styles.dart';
import 'package:fruits/helper/get_it.dart';
import 'package:fruits/views/cart/cubit/cart_cubit.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  static const String routeName = 'signin';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SigninCubit(getIt<AuthRepo>()),
      child: Scaffold(

        appBar: AppBar(

          title: const Text('تسجيل دخول', style: TextStyles.bold19,),
          centerTitle: true,
        ),

        body: SignInViewBodyBlocConsumer(),
      ),
    );
  }
}


