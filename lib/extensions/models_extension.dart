part of 'extensions.dart';

extension SubmissionDataExtension on SubmissionData {
  Submission convertToSubmission(
    Personal personal,
    Company company, {
    String transkripNilaiPath,
    String ksmPath,
  }) =>
      Submission(
        submissionId: id,
        userId: userId,
        personal: personal,
        transkripNilai: transkripNilai,
        ksm: ksm,
        company: company,
        ksmFileName: ksmFileName,
        transkripNilaiFileName: transkripNilaiFileName,
        transkripNilaiPath: transkripNilaiPath,
        ksmPath: ksmPath,
      );
}

extension CompanyDataExtension on CompanyData {
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
      );
}

extension PersonalDataExtension on PersonalData {
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
