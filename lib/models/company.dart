part of 'models.dart';

class Company extends Equatable {
  final String companyId;
  final String companyName;
  final String recipientName;
  final String recipientGrade;
  final String recipientPosition;
  final String companyPhone;
  final String companyAddress;
  final String companyEmail;
  final String dosenVerifier;
  final String lkmVerifier;
  final DateTime beginWork;
  final DateTime endWork;

  String get recipient => '$recipientGrade $recipientName';

  Company({
    @required this.companyId,
    this.companyName = '',
    this.companyEmail = '',
    this.companyAddress = '',
    this.companyPhone = '',
    this.recipientName = '',
    this.recipientGrade = '',
    this.recipientPosition = '',
    this.dosenVerifier,
    this.lkmVerifier,
    this.beginWork,
    this.endWork,
  });

  Company copyWith({
    String dosenVerifier,
    String lkmVerifier,
  }) =>
      Company(
        companyId: this.companyId,
        companyName: this.companyName,
        companyEmail: this.companyEmail,
        companyAddress: this.companyAddress,
        companyPhone: this.companyPhone,
        recipientName: this.recipientName,
        recipientGrade: this.recipientGrade,
        recipientPosition: this.recipientPosition,
        beginWork: this.beginWork,
        endWork: this.endWork,
        dosenVerifier: dosenVerifier ?? this.dosenVerifier,
        lkmVerifier: lkmVerifier ?? this.lkmVerifier,
      );
  @override
  List<Object> get props => [
        companyId,
        companyName,
        recipientName,
        recipientGrade,
        recipientPosition,
        companyPhone,
        companyAddress,
        companyEmail,
        dosenVerifier,
        lkmVerifier,
        this.beginWork,
        this.endWork,
      ];
}
