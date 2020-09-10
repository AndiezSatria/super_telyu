part of 'models.dart';

class CompanyData {
  String id;
  String companyName;
  String recipientName;
  String recipientGrade;
  String recipientPosition;
  String companyPhone;
  String companyAddress;
  String companyEmail;
  DateTime beginWork;
  DateTime endWork;

  CompanyData({
    this.id,
    this.companyName = '',
    this.companyEmail = '',
    this.companyAddress = '',
    this.companyPhone = '',
    this.recipientName = '',
    this.recipientGrade = '',
    this.recipientPosition = '',
    this.beginWork,
    this.endWork,
  });

  Company convertToCompany({
    String dosenVerifier,
    String lkmVerifier,
  }) =>
      Company(
        companyId: id,
        companyName: companyName,
        companyEmail: companyEmail,
        companyAddress: companyAddress,
        companyPhone: companyPhone,
        recipientName: recipientName,
        recipientGrade: recipientGrade,
        recipientPosition: this.recipientPosition,
        dosenVerifier: dosenVerifier,
        lkmVerifier: lkmVerifier,
        beginWork: this.beginWork,
        endWork: this.endWork,
      );
}
