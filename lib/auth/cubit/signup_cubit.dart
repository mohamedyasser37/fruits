import 'package:bloc/bloc.dart';
import 'package:fruits/auth/domain/repos/auth_repo.dart';
import 'package:fruits/auth/entity/user_entity.dart';
import 'package:meta/meta.dart';
part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit(this.authRepo) : super(SignupInitial());

  final AuthRepo authRepo;
  Future<void> createUserWithEmailAndPassword(
      String email, String password, String name) async {
    emit(SignupLoading());
    final result = await authRepo.createUserWithEmailAndPassword(
        email, password, name);
    result.fold((failure) {
      emit(SignupFailure(failure.message));
    }, (user) {
      emit(SignupSuccess(user));
    });
  }

  Future<void> logOut() async {
    emit(LogOutLoading());

    final result = await authRepo.logOut();

    result.fold(
          (failure) => emit(LogOutFailure(failure.message)),
          (_) => emit(LogOutSuccess()),
    );
  }

}
