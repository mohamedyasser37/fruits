  import 'package:bloc/bloc.dart';
  import 'package:firebase_core/firebase_core.dart';
  import 'package:flutter/material.dart';
  import 'package:flutter_bloc/flutter_bloc.dart';
  import 'package:flutter_localizations/flutter_localizations.dart';
  import 'package:fruits/auth/cubit/signup_cubit.dart';
  import 'package:fruits/auth/domain/repos/auth_repo.dart';
  import 'package:fruits/firebase_options.dart';
  import 'package:fruits/generated/l10n.dart';
  import 'package:fruits/helper/bloc_observer.dart';
  import 'package:fruits/helper/get_it.dart';
import 'package:fruits/helper/get_user_data.dart';
  import 'package:fruits/helper/onGenerateRouets.dart';
  import 'package:fruits/helper/shared_prefrence.dart';
  import 'package:fruits/splash/splash_view_body.dart' show SplashViewBody;
  import 'package:fruits/views/cart/cubit/cart_cubit.dart';
  import 'package:fruits/views/home/favourits_cubit/favourites_cubit.dart';
import 'package:fruits/views/home/notification_cubit/notifications_cubit.dart';
import 'package:fruits/views/home/notification_repo.dart';

  void main() async {
    WidgetsFlutterBinding.ensureInitialized();

    await Prefs.init();

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    setUpGetIt();
    Bloc.observer = CustomBlocObserver();
    runApp(const FruitsApp());
  }

  class FruitsApp extends StatelessWidget {
    const FruitsApp({super.key});

    @override
    Widget build(BuildContext context) {
      return MultiBlocProvider(

        providers: [
          BlocProvider(
            create: (_) => CartCubit(),
          ),
          BlocProvider(
            create: (_) => NotificationsCubit(
              getIt<NotificationRepo>(),
            )..fetchNotifications(),
          ),
          BlocProvider(create: (_) => FavoritesCubit(
            userId:
              getUser().name
          )),

          BlocProvider(
            create: (_) => SignupCubit(getIt<AuthRepo>()),
          ),
        ],

        child: MaterialApp(
          //   themeMode: ThemeMode.dark,
          theme: ThemeData(
            fontFamily: 'Cairo',
          ),
          localizationsDelegates: [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          locale: Locale('ar'),
          debugShowCheckedModeBanner: false,
          onGenerateRoute: generateRoute,
          initialRoute: SplashViewBody.routeName,
          //  initialRoute: MainView.routeName,


        ),
      );
    }
  }
