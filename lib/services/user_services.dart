part of 'services.dart';

class UserServices {
  static CollectionReference _userCollection =
      Firestore.instance.collection('users');

  static Future<void> updateUser(User user) async {
    var role;
    switch (user.role) {
      case Role.Mahasiswa:
        role = 'Mahasiswa';
        break;
      case Role.DosenWali:
        role = 'DosenWali';
        break;
      case Role.Kemahasiswaan:
        role = 'Kemahasiswaan';
        break;
    }
    _userCollection.document(user.id).setData({
      'email': user.email,
      'name': user.name,
      'nomorInduk': user.nomorInduk,
      'role': role,
      'profilePicture': user.profilePicture ?? ""
    });
  }

  static Future<User> getUser(String id) async {
    if (id == '') {
      return null;
    }
    DocumentSnapshot snapshot = await _userCollection.document(id).get();
    var role;
    switch (snapshot.data['role']) {
      case 'Mahasiswa':
        role = Role.Mahasiswa;
        break;
      case 'DosenWali':
        role = Role.DosenWali;
        break;
      case 'Kemahasiswaan':
        role = Role.Kemahasiswaan;
        break;
    }

    return User(
      id,
      snapshot.data['email'],
      name: snapshot.data['name'],
      nomorInduk: snapshot.data['nomorInduk'],
      profilePicture: snapshot.data['profilePicture'],
      role: role,
    );
  }
}
