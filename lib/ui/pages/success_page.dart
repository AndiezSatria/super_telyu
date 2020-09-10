part of 'pages.dart';

class SuccessPage extends StatefulWidget {
  final SubmissionData submissionData;
  final PageEvent pageEvent;
  final Submission submission;
  final VerifyData verifyData;
  SuccessPage(
    this.pageEvent, {
    this.submissionData,
    this.submission,
    this.verifyData,
  });
  @override
  _SuccessPageState createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        context.bloc<PageBloc>().add(GoToMainPage());
        return;
      },
      child: Scaffold(
        backgroundColor: primaryColor,
        appBar: AppBar(
          elevation: 0,
          actions: [
            IconButton(
                icon: Icon(Icons.ac_unit, color: primaryColor),
                onPressed: null,
                color: primaryColor),
          ],
          title: Center(child: Text('Sukses!')),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              context.bloc<PageBloc>().add(GoToMainPage());
            },
          ),
        ),
        body: FutureBuilder(
          future: (widget.submissionData != null)
              ? processingEnterSubmission(context)
              : (widget.submission.isVerifying)
                  ? processingVerifySubmission(context)
                  : processUploadSuratFile(context),
          builder: (_, snapshot) => (snapshot.connectionState ==
                  ConnectionState.done)
              ? Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  width: double.infinity,
                  child: ListView(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            width: double.infinity,
                            height: 300,
                            child: Image.asset((widget.submissionData != null)
                                ? 'assets/images/done_submit.png'
                                : (widget.submission.isVerifying)
                                    ? 'assets/images/done_verifying.png'
                                    : 'assets/images/done_processing.png'),
                          ),
                          Text(
                            (widget.submissionData != null)
                                ? 'Hore!\nPengajuanmu berhasil direkam'
                                : (widget.submission.isVerifying)
                                    ? 'Berhasil!\nKamu telah memberi verifikasi'
                                    : 'Selesai!\nSurat Pengantar sudah diunggah!',
                            textAlign: TextAlign.center,
                            style: blackTextFont.copyWith(fontSize: 24),
                          ),
                          SizedBox(height: 20),
                          Container(
                            width: 250,
                            height: 46,
                            child: RaisedButton(
                              color: primaryColor,
                              child: Text(
                                'Kembali ke Home',
                                style: whiteTextFont.copyWith(fontSize: 16),
                              ),
                              onPressed: () {
                                context.bloc<PageBloc>().add(GoToMainPage());
                              },
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              : Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 120,
                        child: Image.asset('assets/images/uploading.png'),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Mengunggah...',
                        style: blackTextFont.copyWith(fontSize: 16),
                      ),
                      SizedBox(height: 4),
                      SpinKitWave(
                        size: 50,
                        color: primaryColor,
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  Future<void> processingEnterSubmission(BuildContext context) async {
    await SubmissionServices.savePersonalData(
            widget.submissionData.personalData)
        .then((personalId) async {
      if (widget.submissionData.letterKind == LetterKind.SuratDispensasi) {
        await SubmissionServices.saveDispen(widget.submissionData.dispenData)
            .then((dispenId) => widget.submissionData.dispenData.id = dispenId);
      } else {
        await SubmissionServices.saveCompany(widget.submissionData.companyData)
            .then((companyId) =>
                widget.submissionData.companyData.id = companyId);
      }
      widget.submissionData.personalData.id = personalId;
      Submission submission = widget.submissionData.convertToSubmission(
        widget.submissionData.personalData.convertToPersonal(),
        company: (widget.submissionData.letterKind == LetterKind.SuratPengantar)
            ? widget.submissionData.companyData.convertToCompany()
            : null,
        dispen: (widget.submissionData.letterKind == LetterKind.SuratDispensasi)
            ? widget.submissionData.dispenData.convertToDispen()
            : null,
      );

      submission = submission.copyWith(time: DateTime.now(), isRejected: false);

      var id = await SubmissionServices.saveSubmission(
        submission.userId,
        submission,
      );
      await SubmissionServices.updateSubmission(
        submission,
        id,
        nilaiUrl: await uploadFile(submission.transkripNilai,
            name: addFileName(submission.transkripNilaiFileName)),
        ksmUrl: await uploadFile(submission.ksm,
            name: addFileName(submission.ksmFileName)),
      );

      // context.bloc<SubmissionBloc>().add(EnterSubmission(
      //     submission.copyWith(time: DateTime.now(), isRejected: false),
      //     submission.userId));
    });
  }

  Future<void> processingVerifySubmission(BuildContext context) async {
    String userId = widget.verifyData.user.id;
    if (widget.submission.letterKind == LetterKind.SuratPengantar) {
      await SubmissionServices.updateCompany(
        widget.submission.company,
        widget.submission.company.companyId,
        dosenId:
            (widget.verifyData.user.role == Role.DosenWali) ? userId : null,
        lkmId:
            (widget.verifyData.user.role == Role.Kemahasiswaan) ? userId : null,
      );
    } else if (widget.submission.letterKind == LetterKind.SuratDispensasi) {
      await SubmissionServices.updateDispen(
        widget.submission.dispen,
        widget.submission.dispen.dispenId,
        dosenId:
            (widget.verifyData.user.role == Role.DosenWali) ? userId : null,
        lkmId:
            (widget.verifyData.user.role == Role.Kemahasiswaan) ? userId : null,
      );
    }
    await SubmissionServices.updatePersonalData(
      widget.submission.personal,
      widget.submission.personal.personalId,
      dosenId: (widget.verifyData.user.role == Role.DosenWali) ? userId : null,
      lkmId:
          (widget.verifyData.user.role == Role.Kemahasiswaan) ? userId : null,
    );
    await SubmissionServices.updateSubmission(
      widget.submission,
      widget.submission.submissionId,
      dosenId: (widget.verifyData.user.role == Role.DosenWali) ? userId : null,
      lkmId:
          (widget.verifyData.user.role == Role.Kemahasiswaan) ? userId : null,
    );
  }

  Future<void> processUploadSuratFile(BuildContext context) async {
    // context.bloc<SubmissionBloc>().add(UploadSurat(widget.submission.copyWith(
    //       surat: widget.verifyData.suratFile,
    //       suratFileName: widget.verifyData.suratFileName,
    //       suratFilePath: widget.verifyData.suratPath,
    //     )));
    var submission = widget.submission.copyWith(
      surat: widget.verifyData.suratFile,
      suratFileName: widget.verifyData.suratFileName,
      suratFilePath: widget.verifyData.suratPath,
    );
    await SubmissionServices.updateSubmission(
      submission,
      submission.submissionId,
      suratUrl: await uploadFile(submission.surat,
          name: addFileName(submission.suratFileName)),
    );
  }
}
