part of 'models.dart';

class VerifyData {
  User user;
  File suratFile;
  String suratFileName;
  String suratPath;
  bool isDosenApprovedPersonal;
  bool isDosenApprovedCompany;
  bool isDosenApprovedTranskripNilai;
  bool isDosenApprovedKSM;
  bool isLKMApprovedPersonal;
  bool isLKMApprovedCompany;
  bool isLKMApprovedTranskripNilai;
  bool isLKMApprovedKSM;
  bool isDosenRejectedPersonal;
  bool isDosenRejectedCompany;
  bool isDosenRejectedTranskripNilai;
  bool isDosenRejectedKSM;
  bool isLKMRejectedPersonal;
  bool isLKMRejectedCompany;
  bool isLKMRejectedTranskripNilai;
  bool isLKMRejectedKSM;

  VerifyData({
    this.suratFile,
    this.suratFileName,
    this.suratPath,
    this.user,
    this.isDosenApprovedPersonal = false,
    this.isDosenApprovedCompany = false,
    this.isDosenApprovedTranskripNilai = false,
    this.isDosenApprovedKSM = false,
    this.isLKMApprovedPersonal = false,
    this.isLKMApprovedCompany = false,
    this.isLKMApprovedTranskripNilai = false,
    this.isLKMApprovedKSM = false,
    this.isDosenRejectedPersonal = false,
    this.isDosenRejectedCompany = false,
    this.isDosenRejectedTranskripNilai = false,
    this.isDosenRejectedKSM = false,
    this.isLKMRejectedPersonal = false,
    this.isLKMRejectedCompany = false,
    this.isLKMRejectedTranskripNilai = false,
    this.isLKMRejectedKSM = false,
  });
}
