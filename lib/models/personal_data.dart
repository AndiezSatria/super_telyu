part of 'models.dart';

class PersonalData {
  String id;
  String name;
  String nim;
  String email;
  String phoneNumber;
  String prodi;
  int totalSks;
  int sks;
  double ipk;

  PersonalData(
    this.id,
    this.name,
    this.nim,
    this.email,
    this.phoneNumber,
    this.prodi,
    this.totalSks,
    this.sks,
    this.ipk,
  );
  Personal convertToPersonal({
    String dosenVerifier,
    String lkmVerifier,
  }) =>
      Personal(
        personalId: id,
        name: this.name,
        nim: this.nim,
        email: this.email,
        phoneNumber: this.phoneNumber,
        prodi: this.prodi,
        totalSks: this.totalSks,
        sks: this.sks,
        ipk: this.ipk,
        dosenVerifier: dosenVerifier,
        lkmVerifier: lkmVerifier,
      );
}
