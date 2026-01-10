class UserEntity {
  final String email;
  final String uid;
  final String name;

  UserEntity({
    required this.email,
    required this.uid,
    required this.name,
  });
  toMap(){
    return {
      'email': email,
      'uid': uid,
      'name': name,
    };
  }
}