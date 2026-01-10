import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fruits/auth/data/user_model.dart';
import 'package:fruits/auth/domain/repos/auth_repo.dart';
import 'package:fruits/auth/entity/user_entity.dart';
import 'package:fruits/auth/services/data_service.dart';
import 'package:fruits/auth/services/firebase_auth_service.dart';
import 'package:fruits/errors/exceptions.dart';
import 'package:fruits/errors/faliures.dart';
import 'package:fruits/helper/constants.dart';
import 'package:fruits/helper/end_points.dart';
import 'package:fruits/helper/shared_prefrence.dart';

class AuthRepoImpl implements AuthRepo {
  final FirebaseAuthService firebaseAuthService;
  final DataService dataService;

  AuthRepoImpl(this.firebaseAuthService, {required this.dataService});

  @override
  Future<Either<Failure, UserEntity>> createUserWithEmailAndPassword(
    String email,
    String password,
    String name,
  ) async {
    User? user;
    try {


      user = await firebaseAuthService.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      var userEntity = UserModel(
        uid: user.uid,
        email: user.email ?? '',
        name: name,
      );
      await addUserData(user: userEntity);
      await saveUserData(user: userEntity);
      return Right(userEntity);
    } on CustomException catch (e) {
      if (user != null) {
        await user.delete();
      }
      return Left(ServerFailure(e.message));
    } catch (e) {
      if (user != null) {
        await user.delete();
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> sendPasswordResetEmail({required String email}) async {
    try {
      await firebaseAuthService.sendPasswordResetEmail(email: email);
      return right(unit);
    } on CustomException catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      return left(ServerFailure('حدث خطأ، يرجى المحاولة لاحقاً'));
    }
  }


  @override
  Future<Either<Failure, UserEntity>> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      var user = await firebaseAuthService.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      var userEntity = UserModel(
        uid: user.uid,
        email: user.email ?? '',
        name: user.displayName ?? '',
      );
      await getUserData(
        collectionName: EndPoints.addUserEndPoint,
        docId: user.uid,
      );
      final userData = await getUserData(
        collectionName: EndPoints.addUserEndPoint,
        docId: user.uid,
      );
      final data = UserModel(
        uid: user.uid,
        email: user.email ?? '',
        name: userData['name'] ?? '',
      );
      await saveUserData(user: data);

      return Right(userEntity);
    } on CustomException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signInWithGoogle() async {
    User? user;
    try {
      user = await firebaseAuthService.signInWithGoogle();
      var userEntity = UserModel.fromFirebase(user);
      var isUserExist = await dataService.checkIfUserExists(
        collectionName: EndPoints.addUserEndPoint,
        docId: user.uid,
      );
      if (isUserExist) {
        await getUserData(
          collectionName: EndPoints.addUserEndPoint,
          docId: user.uid,
        );

        await saveUserData(user: userEntity);
      } else {
        await addUserData(user: userEntity);
      }

      return Right(
        UserEntity(
          email: user.email ?? '',
          uid: user.uid,
          name: user.displayName ?? '',
        ),
      );
    } on CustomException catch (e) {
      if (user != null) {
        await user.delete();
      }
      return Left(ServerFailure(e.message));
    } catch (e) {
      if (user != null) {
        await user.delete();
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signInWithFacebook() async {
    User? user;
    try {
      user = await firebaseAuthService.signInWithFacebook();
      var userEntity = UserModel.fromFirebase(user);
      var isUserExist = await dataService.checkIfUserExists(
        collectionName: EndPoints.addUserEndPoint,
        docId: user.uid,
      );
      if (isUserExist) {
        await getUserData(
          collectionName: EndPoints.addUserEndPoint,
          docId: user.uid,
        );
      } else {
        await addUserData(user: userEntity);
      }

      await saveUserData(user: userEntity);

      return Right(
        UserEntity(
          email: user.email ?? '',
          uid: user.uid,
          name: user.displayName ?? '',
        ),
      );
    } on CustomException catch (e) {
      if (user != null) {
        await user.delete();
      }
      return Left(ServerFailure(e.message));
    } catch (e) {
      if (user != null) {
        await user.delete();
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<dynamic> addUserData({required UserEntity user}) async {
    return await dataService.addData(
      collectionName: EndPoints.addUserEndPoint,
      data: user.toMap(),
      docId: user.uid,
    );
  }

  @override
  Future<Map<String, dynamic>> getUserData({
    required String collectionName,
    required String docId,
  }) async {
    var data = await dataService.getData(
      collectionName: collectionName,
      docId: docId,
    );
    return data as Map<String, dynamic>;
  }

  @override
  Future<dynamic> saveUserData({required UserEntity user}) async {
    var data = jsonEncode(user.toMap());

    await Prefs.setString(KUserData, data);
  }

  @override
  Future<Either<Failure, Unit>> logOut() async {
    try {
      await firebaseAuthService.signOut();
      return right(unit);
    } catch (e) {
      return left(ServerFailure('حدث خطأ أثناء تسجيل الخروج'));
    }
  }
}
