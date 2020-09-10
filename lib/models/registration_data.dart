part of 'models.dart';

class RegistrationData {
  String email;
  String name;
  String nomorInduk;
  String password;
  Role role;
  File profilePicture;

  RegistrationData({
    this.email = '',
    this.name = '',
    this.nomorInduk = '',
    this.profilePicture,
    this.password = '',
    this.role = Role.Mahasiswa,
  });
}
