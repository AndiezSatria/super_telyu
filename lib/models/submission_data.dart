part of 'models.dart';

enum LetterKind { SuratPengantar, SuratDispensasi }

class SubmissionData {
  String id;
  String userId;
  PersonalData personalData;
  CompanyData companyData;
  File transkripNilai;
  String transkripNilaiFileName;
  String transkripNilaiPath;
  File ksm;
  String ksmFileName;
  String ksmPath;
  LetterKind letterKind;
  DispenData dispenData;

  SubmissionData({
    this.id,
    this.userId,
    this.personalData,
    this.transkripNilai,
    this.ksm,
    this.companyData,
    this.ksmFileName = '',
    this.transkripNilaiFileName = '',
    this.transkripNilaiPath = '',
    this.ksmPath = '',
    this.letterKind,
    this.dispenData,
  });

  Submission convertToSubmission(
    Personal personal, {
    Company company,
    Dispen dispen,
    String transkripNilaiPath,
    String ksmPath,
  }) =>
      Submission(
        submissionId: id,
        userId: userId,
        personal: personal,
        dispen: dispen,
        transkripNilai: transkripNilai,
        ksm: ksm,
        company: company,
        ksmFileName: ksmFileName,
        transkripNilaiFileName: transkripNilaiFileName,
        transkripNilaiPath: transkripNilaiPath,
        ksmPath: ksmPath,
        letterKind: letterKind,
      );
}
