part of 'models.dart';

enum Role { Mahasiswa, DosenWali, Kemahasiswaan }

class User extends Equatable {
  final String id;
  final String email;
  final String name;
  final String profilePicture;
  final String nomorInduk;
  final Role role;

  User(
    this.id,
    this.email, {
    this.name,
    this.profilePicture,
    this.nomorInduk,
    this.role,
  });

  User copyWith({String name, String profilePicture}) => User(
        this.id,
        this.email,
        name: name ?? this.name,
        profilePicture: profilePicture ?? this.profilePicture,
        nomorInduk: this.nomorInduk,
        role: this.role,
      );

  @override
  List<Object> get props => [
        id,
        email,
        name,
        profilePicture,
        nomorInduk,
        role,
      ];
}
