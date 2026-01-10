import 'package:flutter/material.dart';
import 'package:fruits/auth/signin/signin_view.dart';
import 'package:fruits/auth/signup/sign_up.dart';
import 'package:fruits/auth/signup/terms_view.dart';
import 'package:fruits/cart_entities/cart_list_entity.dart';
import 'package:fruits/forget_password/forget_password.dart';
import 'package:fruits/onBoarding/on_boarding_view.dart';
import 'package:fruits/splash/splash_view_body.dart';
import 'package:fruits/views/home/notifications.dart';
import 'package:fruits/views/home/search_view.dart';
import 'package:fruits/views/main_view.dart';
import 'package:fruits/views/products/product_review.dart';
import 'package:fruits/views/profile/views/about_us_view.dart';
import 'package:fruits/views/profile/views/personal_favourite.dart';
import 'package:fruits/views/profile/views/personal_profile.dart';
import 'package:fruits/views/shipping/shipping_view.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashViewBody.routeName:
      return MaterialPageRoute(builder: (_) => const SplashViewBody());
    case SignInView.routeName:
      return MaterialPageRoute(builder: (_) => const SignInView());
    case ShippingView.routeName:
      return MaterialPageRoute(
        builder: (_) =>
            ShippingView(cartItems: settings.arguments as CartListEntity),
      );
    case MainView.routeName:
      return MaterialPageRoute(builder: (_) => const MainView());
    case ProductReview.routeName:
      return MaterialPageRoute(builder: (_) => const ProductReview());
    case SearchView.routeName:
      return MaterialPageRoute(builder: (_) => const SearchView());
    case NotificationsView.routeName:
      return MaterialPageRoute(builder: (_) => const NotificationsView());
    case TermsView.routeName:
      return MaterialPageRoute(builder: (_) => const TermsView());
    case PersonalProfile.routeName:
      return MaterialPageRoute(builder: (_) => const PersonalProfile());
    case PersonalFavourite.routeName:
      return MaterialPageRoute(builder: (_) => const PersonalFavourite());
    case AboutUsView.routeName:
      return MaterialPageRoute(builder: (_) => const AboutUsView());
    // case ProductDetailsView.routeName:
    //   return MaterialPageRoute(builder: (_) => const ProductDetailsView());

    case ForgetPasswordEmail.routeName:
      return MaterialPageRoute(builder: (_) =>  ForgetPasswordEmail());
    // case ForgetPasswordCheck.routeName:
    //   return MaterialPageRoute(builder: (_) => const ForgetPasswordCheck());
    // case NewPassword.routeName:
    //   return MaterialPageRoute(builder: (_) =>  NewPassword());
    case SignUp.routeName:
      return MaterialPageRoute(builder: (_) => const SignUp());

    case OnBoardingView.routeName:
      return MaterialPageRoute(builder: (_) => const OnBoardingView());
    default:
      return MaterialPageRoute(builder: (_) => const Scaffold());
  }
}
