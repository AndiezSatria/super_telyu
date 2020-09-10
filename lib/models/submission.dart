part of 'models.dart';

class Submission extends Equatable {
  final String submissionId;
  final String userId;
  final Personal personal;
  final Company company;
  final File transkripNilai;
  final String transkripNilaiFileName;
  final String transkripNilaiPath;
  final File ksm;
  final String ksmUrl;
  final String nilaiUrl;
  final String ksmFileName;
  final String ksmPath;
  final String nilaiDosenVerifier;
  final String nilaiLkmVerifier;
  final String ksmDosenVerifier;
  final String ksmLkmVerifier;
  final DateTime time;
  final File surat;
  final String suratFileName;
  final String suratFilePath;
  final String suratUrl;
  final bool isVerifying;
  final bool isProcessing;
  final bool isDone;
  final bool isRejected;
  final LetterKind letterKind;
  final Dispen dispen;

  Submission({
    this.submissionId,
    this.userId,
    this.personal,
    this.transkripNilai,
    this.ksm,
    this.company,
    this.ksmFileName,
    this.transkripNilaiFileName,
    this.transkripNilaiPath,
    this.ksmPath,
    this.nilaiDosenVerifier,
    this.nilaiLkmVerifier,
    this.ksmDosenVerifier,
    this.ksmLkmVerifier,
    this.time,
    this.surat,
    this.suratFileName,
    this.suratFilePath,
    this.isVerifying,
    this.isDone,
    this.isProcessing,
    this.isRejected,
    this.ksmUrl,
    this.nilaiUrl,
    this.suratUrl,
    this.letterKind,
    this.dispen,
  });

  Submission copyWith({
    String id,
    Personal personal,
    Company company,
    File transkripNilai,
    String transkripNilaiFileName,
    String transkripNilaiPath,
    File ksm,
    String ksmFileName,
    String ksmPath,
    String nilaiDosenVerifier,
    String nilaiLkmVerifier,
    String ksmDosenVerifier,
    String ksmLkmVerifier,
    DateTime time,
    File surat,
    String suratFileName,
    String suratFilePath,
    String nialiUrl,
    String ksmUrl,
    String suratUrl,
    bool isVerifying,
    bool isProcessing,
    bool isDone,
    bool isRejected,
    LetterKind letterKind,
    Dispen dispen,
  }) =>
      Submission(
        submissionId: id ?? this.submissionId,
        userId: this.userId,
        personal: personal ?? this.personal,
        transkripNilai: transkripNilai ?? this.transkripNilai,
        ksm: ksm ?? this.ksm,
        company: company ?? this.company,
        ksmFileName: ksmFileName ?? this.ksmFileName,
        transkripNilaiFileName:
            transkripNilaiFileName ?? this.transkripNilaiFileName,
        transkripNilaiPath: transkripNilaiPath ?? this.transkripNilaiPath,
        ksmPath: ksmPath ?? this.ksmPath,
        nilaiDosenVerifier: nilaiDosenVerifier ?? this.nilaiDosenVerifier,
        nilaiLkmVerifier: nilaiLkmVerifier ?? this.nilaiLkmVerifier,
        ksmDosenVerifier: ksmDosenVerifier ?? this.ksmDosenVerifier,
        ksmLkmVerifier: ksmLkmVerifier ?? this.ksmLkmVerifier,
        time: time ?? this.time,
        isDone: isDone ?? this.isDone,
        isProcessing: isProcessing ?? this.isProcessing,
        isRejected: isRejected ?? this.isRejected,
        isVerifying: isVerifying ?? this.isVerifying,
        surat: surat ?? this.surat,
        suratFileName: suratFileName ?? this.suratFileName,
        suratFilePath: suratFilePath ?? this.suratFilePath,
        nilaiUrl: nialiUrl ?? this.nilaiUrl,
        ksmUrl: ksmUrl ?? this.ksmUrl,
        suratUrl: suratUrl ?? this.suratUrl,
        letterKind: letterKind ?? this.letterKind,
        dispen: dispen ?? this.dispen,
      );

  @override
  List<Object> get props => [
        this.submissionId,
        this.userId,
        this.personal,
        this.transkripNilai,
        this.ksm,
        this.company,
        this.ksmFileName,
        this.transkripNilaiFileName,
        this.transkripNilaiPath,
        this.ksmPath,
        this.nilaiDosenVerifier,
        this.nilaiLkmVerifier,
        this.ksmDosenVerifier,
        this.ksmLkmVerifier,
        this.time,
        this.surat,
        this.suratFileName,
        this.suratFilePath,
        this.isVerifying,
        this.isDone,
        this.isProcessing,
        this.isRejected,
        this.ksmUrl,
        this.nilaiUrl,
        this.letterKind,
        this.dispen,
      ];
}
