part of 'models.dart';

class Personal extends Equatable {
  final String personalId;
  final String name;
  final String nim;
  final String email;
  final String phoneNumber;
  final String prodi;
  final int totalSks;
  final int sks;
  final double ipk;
  final String dosenVerifier;
  final String lkmVerifier;

  Personal({
    @required this.personalId,
    this.name,
    this.nim,
    this.email,
    this.phoneNumber,
    this.prodi,
    this.totalSks,
    this.sks,
    this.ipk,
    this.dosenVerifier,
    this.lkmVerifier,
  });

  Personal copyWith({
    String dosenVerifier,
    String lkmVerifier,
  }) =>
      Personal(
        personalId: this.personalId,
        name: this.name,
        nim: this.nim,
        email: this.email,
        phoneNumber: this.phoneNumber,
        prodi: this.prodi,
        totalSks: this.totalSks,
        sks: this.sks,
        ipk: this.ipk,
        dosenVerifier: dosenVerifier ?? this.dosenVerifier,
        lkmVerifier: lkmVerifier ?? this.lkmVerifier,
      );
  @override
  List<Object> get props => [
        this.personalId,
        this.name,
        this.nim,
        this.email,
        this.phoneNumber,
        this.prodi,
        this.totalSks,
        this.sks,
        this.ipk,
        this.dosenVerifier,
        this.lkmVerifier,
      ];
}
