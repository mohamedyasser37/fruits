part of 'signup_cubit.dart';

@immutable
abstract class SignupState {}

class SignupInitial extends SignupState {}

class SignupLoading extends SignupState {}
class LogOutSuccess extends SignupState {}
class LogOutFailure extends SignupState {
  final String error;
  LogOutFailure(this.error);
}
class LogOutLoading extends SignupState {}



class SignupSuccess extends SignupState {
  final UserEntity user;
  SignupSuccess(this.user);
}

class SignupFailure extends SignupState {
  final String error;
  SignupFailure(this.error);
}
