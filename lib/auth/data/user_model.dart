import 'package:firebase_auth/firebase_auth.dart';
import 'package:fruits/auth/entity/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({required super.email, required super.uid, required super.name});

  factory UserModel.fromFirebase(User user) {
    return UserModel(
      email: user.email ?? '',
      uid: user.uid,
      name: user.displayName ?? '',
    );
  }
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
    );
  }
  toMap() {
    return {
      'email': email,
      'uid': uid,
      'name': name,
    };
  }
}
