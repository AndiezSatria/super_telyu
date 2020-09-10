part of 'extensions.dart';

extension FirebaseUserExtension on FirebaseUser {
  User convertToUser({
    String name = 'No Name',
    Role role,
    String nomorInduk = '',
  }) {
    return User(
      this.uid,
      this.email,
      name: name,
      role: role,
      nomorInduk: nomorInduk,
    );
  }

  Future<User> fromFireStore() async => await UserServices.getUser(this.uid);
}
