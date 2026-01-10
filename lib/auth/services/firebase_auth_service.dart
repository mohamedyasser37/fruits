import 'package:firebase_auth/firebase_auth.dart';
import 'package:fruits/errors/exceptions.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class FirebaseAuthService {

  Future<void> deleteUser()async{
   await  FirebaseAuth.instance.currentUser!.delete();
}

  /// Send a password reset email
  Future<void> sendPasswordResetEmail({required String email}) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw CustomException('لا يوجد حساب مسجل بهذا البريد الإلكتروني');
      } else if (e.code == 'invalid-email') {
        throw CustomException('البريد الإلكتروني غير صحيح');
      } else if (e.code == 'network-request-failed') {
        throw CustomException('الرجاء التحقق من اتصالك بالانترنت');
      } else {
        throw CustomException('حدث خطأ، يرجى المحاولة لاحقاً');
      }
    } catch (e) {
      throw CustomException('حدث خطأ، يرجى المحاولة لاحقاً');
    }
  }


  Future<User> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return credential.user!;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw CustomException('الباسورد ضعيف جدا');
      }else if(e.code == 'invalid-email'){
        throw CustomException('البريد الالكتروني غير صحيح');
      } else if (e.code == 'network-request-failed') {
        throw CustomException('الرجاء التحقق من اتصالك بالانترنت');
      }

      else if (e.code == 'email-already-in-use') {
        throw CustomException(' هذا الايميل مستخدم بالفعل ');
      } else {
        throw CustomException('حدث خطأ,برجأ المحاوله لاحقا');
      }
    } catch (e) {
      throw CustomException('حدث خطأ,برجأ المحاوله لاحقا');
    }
  }

  Future<User> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user!;
    } on FirebaseAuthException catch (e) {
      print("LOGIN ERROR CODE: ${e.code}");

      if (e.code == 'user-not-found') {
        throw CustomException('الايميل المستخدم او الرقم السرى غير صحيح');

      } else if (e.code == 'network-request-failed') {
        throw CustomException('الرجاء التحقق من اتصالك بالانترنت');
      } else if (e.code == 'wrong-password') {
        throw CustomException('الايميل المستخدم او الرقم السرى غير صحيح');

      }
      else if (e.code == 'invalid-credential') {
        throw CustomException('الايميل المستخدم او الرقم السرى غير صحيح');
      } else {
        throw CustomException('حدث خطأ,برجأ المحاوله لاحقا');
      }
    } catch (e) {
      throw CustomException('حدث خطأ,برجأ المحاوله لاحقا');
    }
  }



  Future<User> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    return (await FirebaseAuth.instance.signInWithCredential(credential)).user!;
  }

  Future<User> signInWithFacebook() async {
    // Trigger the signup-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.tokenString);

    // Once signed in, return the UserCredential
    return (await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential)).user!;
  }

  bool isLoggedIn(){
    return FirebaseAuth.instance.currentUser != null;
  }
  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();

      // علشان لو كان مسجل بجوجل
      await GoogleSignIn().signOut();

      // علشان لو كان مسجل بفيسبوك
      await FacebookAuth.instance.logOut();
    } catch (e) {
      throw CustomException('حدث خطأ أثناء تسجيل الخروج');
    }
  }
}
