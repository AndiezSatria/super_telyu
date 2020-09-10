part of 'services.dart';

class SubmissionServices {
  static CollectionReference _submissionCollection =
      Firestore.instance.collection('submission');
  static CollectionReference _companyCollection =
      Firestore.instance.collection('company');
  static CollectionReference _personalCollection =
      Firestore.instance.collection('personal');
  static CollectionReference _dispenCollection =
      Firestore.instance.collection('dispen');

  static Future<String> saveSubmission(
    String userId,
    Submission submissionData, {
    String nilaiUrl,
    String ksmUrl,
  }) async {
    var letterKind;
    switch (submissionData.letterKind) {
      case LetterKind.SuratPengantar:
        letterKind = 'SuratPengantar';
        break;
      case LetterKind.SuratDispensasi:
        letterKind = 'SuratDispensasi';
        break;
    }
    var docRef = await _submissionCollection.add({});

    await _submissionCollection.document(docRef.documentID).setData({
      'id': docRef.documentID,
      'companyId': submissionData.letterKind == LetterKind.SuratPengantar
          ? submissionData.company.companyId
          : null,
      'personalId': submissionData.personal.personalId,
      'dispenId': submissionData.letterKind == LetterKind.SuratDispensasi
          ? submissionData.dispen.dispenId
          : null,
      'userId': userId,
      'nilaiFileName': submissionData.transkripNilaiFileName,
      'ksmFileName': submissionData.ksmFileName,
      'nilaiUrl': nilaiUrl,
      'ksmUrl': ksmUrl,
      'time': DateTime.now().millisecondsSinceEpoch,
      'isRejected': false,
      'suratUrl': null,
      'suratFileName': null,
      'nilaiDosenVerifier': null,
      'nilaiLkmVerifier': null,
      'ksmDosenVerifier': null,
      'ksmLkmVerifier': null,
      'jenisSurat': letterKind,
    });
    return docRef.documentID;
  }

  static Future<void> updateSubmission(
    Submission submission,
    String id, {
    String nilaiUrl,
    String ksmUrl,
    String suratUrl,
    String dosenId,
    String lkmId,
  }) async {
    var letterKind;
    switch (submission.letterKind) {
      case LetterKind.SuratPengantar:
        letterKind = 'SuratPengantar';
        break;
      case LetterKind.SuratDispensasi:
        letterKind = 'SuratDispensasi';
        break;
    }
    await _submissionCollection.document(id).setData({
      'id': id,
      'companyId': submission.letterKind == LetterKind.SuratPengantar
          ? submission.company.companyId
          : null,
      'personalId': submission.personal.personalId,
      'dispenId': submission.letterKind == LetterKind.SuratDispensasi
          ? submission.dispen.dispenId
          : null,
      'userId': submission.userId,
      'nilaiFileName': submission.transkripNilaiFileName,
      'ksmFileName': submission.ksmFileName,
      'nilaiUrl': nilaiUrl ?? submission.nilaiUrl,
      'ksmUrl': ksmUrl ?? submission.ksmUrl,
      'time': submission.time.millisecondsSinceEpoch,
      'isRejected': submission.isRejected,
      'suratUrl': suratUrl ?? submission.suratUrl,
      'suratFileName': submission.suratFileName,
      'nilaiDosenVerifier': dosenId ?? submission.nilaiDosenVerifier,
      'nilaiLkmVerifier': lkmId ?? submission.nilaiLkmVerifier,
      'ksmDosenVerifier': dosenId ?? submission.ksmDosenVerifier,
      'ksmLkmVerifier': lkmId ?? submission.ksmLkmVerifier,
      'jenisSurat': letterKind,
    });
  }

  static Future<void> updateCompany(
    Company company,
    String id, {
    String dosenId,
    String lkmId,
  }) async {
    await _companyCollection.document(id).setData({
      'id': id,
      'companyName': company.companyName,
      'recipientName': company.recipientName,
      'recipientGrade': company.recipientGrade,
      'recipientPosition': company.recipientPosition,
      'companyPhone': company.companyPhone,
      'companyAddress': company.companyAddress,
      'companyEmail': company.companyEmail,
      'dosenVerifier': dosenId ?? company.dosenVerifier,
      'lkmVerifier': lkmId ?? company.lkmVerifier,
      'beginWork': company.beginWork.millisecondsSinceEpoch,
      'endWork': company.endWork.millisecondsSinceEpoch,
    });
  }

  static Future<void> updatePersonalData(
    Personal personal,
    String id, {
    String dosenId,
    String lkmId,
  }) async {
    await _personalCollection.document(id).setData({
      'id': id,
      'name': personal.name,
      'nim': personal.nim,
      'email': personal.email,
      'phoneNumber': personal.phoneNumber,
      'prodi': personal.prodi,
      'totalSks': personal.totalSks,
      'sks': personal.sks,
      'ipk': personal.ipk,
      'dosenVerifier': dosenId ?? personal.dosenVerifier,
      'lkmVerifier': lkmId ?? personal.lkmVerifier,
    });
  }

  static Future<void> updateDispen(
    Dispen dispen,
    String id, {
    String dosenId,
    String lkmId,
  }) async {
    await _dispenCollection.document(id).setData({
      'id': id,
      'purpose': dispen.purpose,
      'beginTime': dispen.begin.millisecondsSinceEpoch,
      'endTime': dispen.end.millisecondsSinceEpoch,
      'dosenVerifier': dosenId ?? dispen.dosenVerifier,
      'lkmVerifier': lkmId ?? dispen.lkmVerifier,
    });
  }

  static Future<List<Submission>> getSubmission({String userId}) async {
    QuerySnapshot snapshot = await _submissionCollection.getDocuments();

    var documents = userId == null
        ? snapshot.documents
        : snapshot.documents
            .where((element) => element.data['userId'] == userId);

    List<Submission> submissions = [];
    for (var item in documents) {
      LetterKind letterKind;
      switch (item.data['jenisSurat']) {
        case 'SuratPengantar':
          letterKind = LetterKind.SuratPengantar;
          break;
        case 'SuratDispensasi':
          letterKind = LetterKind.SuratDispensasi;
          break;
      }
      Company company = await getCompany(item.data['companyId']);
      Personal personal = await getPersonalData(item.data['personalId']);
      Dispen dispen = await getDispen(item.data['dispenId']);

      submissions.add(Submission(
        personal: personal,
        company: company,
        dispen: dispen,
        submissionId: item.data['id'],
        userId: item.data['userId'],
        ksmFileName: item.data['ksmFileName'],
        transkripNilaiFileName: item.data['nilaiFileName'],
        nilaiDosenVerifier: item.data['nilaiDosenVerifier'],
        nilaiLkmVerifier: item.data['nilaiLkmVerifier'],
        ksmDosenVerifier: item.data['ksmDosenVerifier'],
        ksmLkmVerifier: item.data['ksmLkmVerifier'],
        suratFileName: item.data['suratFileName'],
        nilaiUrl: item.data['nilaiUrl'],
        ksmUrl: item.data['ksmUrl'],
        suratUrl: item.data['suratUrl'],
        letterKind: letterKind,
        time: DateTime.fromMillisecondsSinceEpoch(item.data['time']),
        isVerifying: letterKind == LetterKind.SuratPengantar
            ? ((personal.dosenVerifier == null ||
                        personal.lkmVerifier == null) ||
                    (company.dosenVerifier == null ||
                        company.lkmVerifier == null) ||
                    ((item.data['nilaiDosenVerifier'] == null &&
                            item.data['nilaiLkmVerifier'] == null) ||
                        (item.data['ksmDosenVerifier'] == null &&
                            item.data['ksmLkmVerifier'] == null))) &&
                !item.data['isRejected']
            : ((personal.dosenVerifier == null ||
                        personal.lkmVerifier == null) ||
                    (dispen.dosenVerifier == null ||
                        dispen.lkmVerifier == null) ||
                    ((item.data['nilaiDosenVerifier'] == null &&
                            item.data['nilaiLkmVerifier'] == null) ||
                        (item.data['ksmDosenVerifier'] == null &&
                            item.data['ksmLkmVerifier'] == null))) &&
                !item.data['isRejected'],
        isRejected: item.data['isRejected'],
        isProcessing: letterKind == LetterKind.SuratPengantar
            ? ((personal.dosenVerifier != null &&
                    personal.lkmVerifier != null) &&
                (company.dosenVerifier != null &&
                    company.lkmVerifier != null) &&
                ((item.data['nilaiDosenVerifier'] != null &&
                        item.data['nilaiLkmVerifier'] != null) &&
                    (item.data['ksmDosenVerifier'] != null &&
                        item.data['ksmLkmVerifier'] != null)) &&
                !item.data['isRejected'] &&
                item.data['suratUrl'] == null)
            : ((personal.dosenVerifier != null &&
                    personal.lkmVerifier != null) &&
                (dispen.dosenVerifier != null && dispen.lkmVerifier != null) &&
                ((item.data['nilaiDosenVerifier'] != null &&
                        item.data['nilaiLkmVerifier'] != null) &&
                    (item.data['ksmDosenVerifier'] != null &&
                        item.data['ksmLkmVerifier'] != null)) &&
                !item.data['isRejected'] &&
                item.data['suratUrl'] == null),
        isDone: letterKind == LetterKind.SuratPengantar
            ? ((personal.dosenVerifier != null &&
                        personal.lkmVerifier != null) &&
                    (company.dosenVerifier != null &&
                        company.lkmVerifier != null) &&
                    ((item.data['nilaiDosenVerifier'] != null &&
                            item.data['nilaiLkmVerifier'] != null) &&
                        (item.data['ksmDosenVerifier'] != null &&
                            item.data['ksmLkmVerifier'] != null)) &&
                    !item.data['isRejected'] &&
                    item.data['suratUrl'] != null) ||
                item.data['isRejected']
            : ((personal.dosenVerifier != null &&
                        personal.lkmVerifier != null) &&
                    (dispen.dosenVerifier != null &&
                        dispen.lkmVerifier != null) &&
                    ((item.data['nilaiDosenVerifier'] != null &&
                            item.data['nilaiLkmVerifier'] != null) &&
                        (item.data['ksmDosenVerifier'] != null &&
                            item.data['ksmLkmVerifier'] != null)) &&
                    !item.data['isRejected'] &&
                    item.data['suratUrl'] != null) ||
                item.data['isRejected'],
      ));
    }

    return submissions;
  }

  static Future<String> saveDispen(DispenData dispen) async {
    var docRef = await _dispenCollection.add({});
    await _dispenCollection.document(docRef.documentID).setData({
      'id': docRef.documentID,
      'purpose': dispen.purpose,
      'beginTime': dispen.begin.millisecondsSinceEpoch,
      'endTime': dispen.end.millisecondsSinceEpoch,
      'dosenVerifier': null,
      'lkmVerifier': null,
    });
    return docRef.documentID;
  }

  static Future<Dispen> getDispen(String dispenId) async {
    if (dispenId == null) {
      return null;
    }
    DocumentSnapshot snapshot =
        await _dispenCollection.document(dispenId).get();
    return Dispen(
      dispenId: snapshot.data['id'],
      purpose: snapshot.data['purpose'],
      begin: DateTime.fromMillisecondsSinceEpoch(snapshot.data['beginTime']),
      end: DateTime.fromMillisecondsSinceEpoch(snapshot.data['endTime']),
      dosenVerifier: snapshot.data['dosenVerifier'],
      lkmVerifier: snapshot.data['lkmVerifier'],
    );
  }

  static Future<String> saveCompany(CompanyData company) async {
    var docRef = await _companyCollection.add({});
    await _companyCollection.document(docRef.documentID).setData({
      'id': docRef.documentID,
      'companyName': company.companyName,
      'recipientName': company.recipientName,
      'recipientGrade': company.recipientGrade,
      'recipientPosition': company.recipientPosition,
      'companyPhone': company.companyPhone,
      'companyAddress': company.companyAddress,
      'companyEmail': company.companyEmail,
      'dosenVerifier': null,
      'lkmVerifier': null,
      'beginWork': company.beginWork.millisecondsSinceEpoch,
      'endWork': company.endWork.millisecondsSinceEpoch,
    });
    return docRef.documentID;
  }

  static Future<Company> getCompany(String companyId) async {
    if (companyId == null) {
      return null;
    }
    DocumentSnapshot snapshot =
        await _companyCollection.document(companyId).get();

    return Company(
      companyId: snapshot.data['id'],
      companyName: snapshot.data['companyName'],
      recipientName: snapshot.data['recipientName'],
      recipientGrade: snapshot.data['recipientGrade'],
      recipientPosition: snapshot.data['recipientPosition'],
      companyPhone: snapshot.data['companyPhone'],
      companyAddress: snapshot.data['companyAddress'],
      companyEmail: snapshot.data['companyEmail'],
      dosenVerifier: snapshot.data['dosenVerifier'],
      lkmVerifier: snapshot.data['lkmVerifier'],
      beginWork:
          DateTime.fromMillisecondsSinceEpoch(snapshot.data['beginWork']),
      endWork: DateTime.fromMillisecondsSinceEpoch(snapshot.data['endWork']),
    );
  }

  static Future<String> savePersonalData(PersonalData personalData) async {
    var docRef = await _personalCollection.add({});
    await _personalCollection.document(docRef.documentID).setData({
      'id': docRef.documentID,
      'name': personalData.name,
      'nim': personalData.nim,
      'email': personalData.email,
      'phoneNumber': personalData.phoneNumber,
      'prodi': personalData.prodi,
      'totalSks': personalData.totalSks,
      'sks': personalData.sks,
      'ipk': personalData.ipk,
      'dosenVerifier': null,
      'lkmVerifier': null,
    });

    return docRef.documentID;
  }

  static Future<Personal> getPersonalData(String personalId) async {
    DocumentSnapshot snapshot =
        await _personalCollection.document(personalId).get();

    return Personal(
      personalId: snapshot.data['id'],
      name: snapshot.data['name'],
      nim: snapshot.data['nim'],
      email: snapshot.data['email'],
      phoneNumber: snapshot.data['phoneNumber'],
      prodi: snapshot.data['prodi'],
      totalSks: snapshot.data['totalSks'],
      sks: snapshot.data['sks'],
      ipk: snapshot.data['ipk'],
      dosenVerifier: snapshot.data['dosenVerifier'],
      lkmVerifier: snapshot.data['lkmVerifier'],
    );
  }
}
