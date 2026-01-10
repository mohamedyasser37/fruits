import 'dart:convert';

import 'package:fruits/auth/data/user_model.dart';
import 'package:fruits/auth/entity/user_entity.dart';
import 'package:fruits/helper/constants.dart';
import 'package:fruits/helper/shared_prefrence.dart';

UserEntity getUser(){
  var jsonString= Prefs.getString(KUserData);
  var userEntity = UserModel.fromJson(jsonDecode(jsonString));
  return userEntity;
}


