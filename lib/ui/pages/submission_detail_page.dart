part of 'pages.dart';

class SubmissionDetailPage extends StatefulWidget {
  final Submission submission;
  final VerifyData verifyData;
  SubmissionDetailPage(this.submission, {this.verifyData});
  @override
  _SubmissionDetailPageState createState() => _SubmissionDetailPageState();
}

class _SubmissionDetailPageState extends State<SubmissionDetailPage> {
  String _previewNilaiPath;
  String _previewKsmPath;
  String _previewSuratPath;
  String _nilaiPath;
  String _ksmPath;
  String _suratPath;
  String _suratFileName;
  File _nilaiFile;
  File _ksmFile;
  File _suratFile;
  bool _isNilaiLoading = false;
  bool _isKsmLoading = false;
  bool _isSuratLoading = false;

  @override
  void initState() {
    if (widget.verifyData != null && !widget.submission.isDone) {
      _suratFile = widget.verifyData.suratFile;
      _suratFileName = widget.verifyData.suratFileName;
      _suratPath = widget.verifyData.suratPath;
    }
    super.initState();
    preparePreview().then((_) {
      if (this.mounted) {
        setState(() {
          _isKsmLoading = false;
          _isNilaiLoading = false;
          _isSuratLoading = false;
        });
      }
    });
  }

  Future<void> preparePreview() async {
    _isKsmLoading = true;
    _isNilaiLoading = true;
    _isSuratLoading = true;
    await getFileFromUrl(
      widget.submission.ksmUrl,
      widget.submission.ksmFileName,
    ).then((value) async {
      _ksmFile = value;
      _ksmPath = _ksmFile.path;
      _previewKsmPath =
          await PdfPreviewer.getPagePreview(filePath: _ksmPath, pageNumber: 1);
    });
    await getFileFromUrl(
      widget.submission.nilaiUrl,
      widget.submission.transkripNilaiFileName,
    ).then((value) async {
      _nilaiFile = value;
      _nilaiPath = _nilaiFile.path;
      _previewNilaiPath = await PdfPreviewer.getPagePreview(
          filePath: _nilaiPath, pageNumber: 1);
    });
    if (widget.submission.suratUrl != null) {
      await getFileFromUrl(
        widget.submission.suratUrl,
        widget.submission.suratFileName,
      ).then((value) async {
        _suratFile = value;
        _suratPath = _suratFile.path;
        _previewSuratPath = await PdfPreviewer.getPagePreview(
            filePath: _suratPath, pageNumber: 1);
      });
    } else {
      if (_suratFile != null) {
        _previewSuratPath = await PdfPreviewer.getPagePreview(
            filePath: _suratPath, pageNumber: 1);
      }
    }
  }

  //note:On Tap Add Surat Function
  void onTapAddSurat() async {
    if (_suratFile == null) {
      if (this.mounted) {
        setState(() {
          _isSuratLoading = true;
        });
      }
      await getFile().then((value) async {
        _suratFile = value['file'];
        _suratPath = value['path'];
        _suratFileName = value['fileName'];
        _previewSuratPath = await PdfPreviewer.getPagePreview(
            filePath: _suratPath, pageNumber: 1);
        widget.verifyData.suratFile = _suratFile;
        widget.verifyData.suratFileName = _suratFileName;
        widget.verifyData.suratPath = _suratPath;
        if (this.mounted) {
          setState(() {
            _isSuratLoading = false;
          });
        }
      });
    } else {
      context.bloc<PageBloc>().add(GoToPdfViewPage(
          _suratPath,
          GoToSubmissionDetailPage(widget.submission,
              verifyData: widget.verifyData)));
    }
  }

  void onTapDelete() {
    setState(() {
      _suratFile = null;
      _suratPath = null;
      _suratFileName = null;
      _previewSuratPath = null;
      widget.verifyData.suratFile = null;
      widget.verifyData.suratFileName = null;
      widget.verifyData.suratPath = null;
    });
  }

  //note: On Tap View Doc Function
  void _onTapPreviewer(String path) async {
    if (path != null) {
      context.bloc<PageBloc>().add(GoToPdfViewPage(
          path,
          GoToSubmissionDetailPage(widget.submission,
              verifyData: widget.verifyData)));
    }
  }

  //note: Button Approval
  Widget generateButtonApproval({
    double width = double.infinity,
    bool terima = false,
    bool tolak = false,
    Function onTapTerima,
    Function onTapTolak,
  }) {
    return Column(
      children: [
        Container(
          width: width,
          height: 46,
          decoration: BoxDecoration(
            border: Border.all(
                color: terima ? Colors.transparent : Color(0xFF3E9D9D)),
          ),
          child: RaisedButton(
            color: terima ? Color(0xFF3E9D9D) : Colors.white,
            child: Text(
              'Setuju',
              style: whiteTextFont.copyWith(
                fontSize: 16,
                color: terima ? Colors.white : Color(0xFF3E9D9D),
              ),
            ),
            onPressed: tolak
                ? () {}
                : () {
                    setState(() {
                      if (terima) {
                        terima = false;
                      } else {
                        terima = true;
                      }
                    });
                    onTapTerima(terima);
                  },
          ),
        ),
        SizedBox(height: 10),
        Container(
          width: width,
          height: 46,
          decoration: BoxDecoration(
            border: Border.all(
                color: tolak ? Colors.transparent : Color(0xFFFF5C83)),
          ),
          child: RaisedButton(
            color: tolak ? Color(0xFFFF5C83) : Colors.white,
            child: Text(
              'Tolak',
              style: whiteTextFont.copyWith(
                fontSize: 16,
                color: tolak ? Colors.white : Color(0xFFFF5C83),
              ),
            ),
            onPressed: terima
                ? () {}
                : () {
                    setState(() {
                      if (tolak) {
                        tolak = false;
                      } else {
                        tolak = true;
                      }
                    });
                    onTapTolak(tolak);
                  },
          ),
        ),
      ],
    );
  }

  //note: Generate Information
  Widget generateListInformation(
    BuildContext context,
    Map<String, Object> data,
    String title,
    Map<String, String> dataApproval,
    String assetImage,
  ) {
    MediaQueryData _mediaQuery = MediaQuery.of(context);
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              spreadRadius: 1.0, color: Color(0xffebebeb), blurRadius: 3.0),
        ],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          width: 1.0,
          color: Color(0xffebebeb),
        ),
      ),
      child: DottedBorder(
        dashPattern: [5, 5],
        borderType: BorderType.RRect,
        padding: EdgeInsets.all(10),
        radius: Radius.circular(16),
        child: Column(
          children: [
            Text(
              title,
              style: blackTextFont.copyWith(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              height: 150,
              child: Image.asset(assetImage),
            ),
            SizedBox(
              height: 10,
            ),
            //note: Data Masukan
            ...data.entries
                .map((entry) => Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: (_mediaQuery.size.width -
                                  2 * defaultMargin -
                                  22) *
                              0.4,
                          child: Text(
                            '${entry.key.substring(0, 1).toUpperCase()}${entry.key.substring(1)}',
                            style: blackTextFont.copyWith(fontSize: 16),
                          ),
                        ),
                        Container(
                          width: (_mediaQuery.size.width -
                                  2 * defaultMargin -
                                  22) *
                              0.6,
                          child: Text(
                            entry.value.toString(),
                            textAlign: TextAlign.end,
                            style: whiteNumberFont.copyWith(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ))
                .toList(),
            //note: Data Approval
            ...dataApproval.entries
                .map(
                  (entry) => FutureBuilder(
                    future: UserServices.getUser(entry.value ?? ''),
                    builder: (_, snapshot) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: (_mediaQuery.size.width -
                                    2 * defaultMargin -
                                    22) *
                                0.3,
                            child: Text(
                              '${entry.key.substring(0, 1).toUpperCase()}${entry.key.substring(1)}',
                              style: blackTextFont.copyWith(fontSize: 16),
                            ),
                          ),
                          Container(
                            width: (_mediaQuery.size.width -
                                    2 * defaultMargin -
                                    22) *
                                0.7,
                            child: snapshot.hasData
                                ? Text(
                                    (snapshot.data as User).name,
                                    textAlign: TextAlign.end,
                                    style: whiteNumberFont.copyWith(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  )
                                : Text(
                                    'Belum Ada',
                                    textAlign: TextAlign.end,
                                    style: whiteNumberFont.copyWith(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                          )
                        ],
                      );
                    },
                  ),
                )
                .toList(),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        context.bloc<PageBloc>().add(GoToMainPage());
        return;
      },
      child: Scaffold(
        backgroundColor: primaryColor,
        //note: AppBar
        appBar: AppBar(
          elevation: 0,
          actions: [
            IconButton(
                icon: Icon(Icons.ac_unit, color: primaryColor),
                onPressed: null,
                color: primaryColor),
          ],
          title: Center(child: Text('Detail Pengajuan')),
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                context.bloc<PageBloc>().add(GoToMainPage());
              }),
        ),
        body: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          child: ListView(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      height: 200,
                      child: Image.asset('assets/images/detail.png'),
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Jenis Surat',
                            style: whiteNumberFont.copyWith(
                                fontSize: 16, color: Colors.black),
                          ),
                        ),
                        FittedBox(
                          child: Text(
                            '${widget.submission.letterKind.toString().substring(11, 16)} ${widget.submission.letterKind.toString().substring(16)}',
                            style: whiteNumberFont.copyWith(
                                fontSize: 16, color: Colors.black),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Dibuat',
                            style: whiteNumberFont.copyWith(
                                fontSize: 16, color: Colors.black),
                          ),
                        ),
                        FittedBox(
                          child: Text(
                            '${widget.submission.time.dateAndTimeLong}',
                            style: whiteNumberFont.copyWith(
                                fontSize: 16, color: Colors.black),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 6),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Status',
                            style: whiteNumberFont.copyWith(
                                fontSize: 16, color: Colors.black),
                          ),
                        ),
                        FittedBox(
                          child: Text(
                            widget.submission.isVerifying
                                ? 'Verifikasi'
                                : widget.submission.isProcessing
                                    ? 'Proses Pembuatan'
                                    : widget.submission.isRejected
                                        ? 'Ditolak'
                                        : 'Selesai',
                            style: whiteNumberFont.copyWith(
                                fontSize: 16, color: Colors.black),
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        FittedBox(
                          child: Container(
                            width: 35,
                            height: 35,
                            child: Icon(
                              widget.submission.isVerifying
                                  ? MdiIcons.progressCheck
                                  : widget.submission.isRejected
                                      ? Icons.error
                                      : widget.submission.isProcessing
                                          ? MdiIcons.progressDownload
                                          : Icons.check,
                              color: Colors.white,
                            ),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: widget.submission.isVerifying
                                  ? Colors.lightBlue
                                  : widget.submission.isRejected
                                      ? Colors.red
                                      : widget.submission.isProcessing
                                          ? Colors.yellow
                                          : Color(0xFF3E9D9D),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Detail Pengajuan',
                      style: blackTextFont.copyWith(fontSize: 24),
                    ),
                    generateListInformation(
                      context,
                      {
                        'nama': widget.submission.personal.name,
                        'nim': widget.submission.personal.nim,
                        'no. Handphone': widget.submission.personal.phoneNumber,
                        'program Studi': widget.submission.personal.prodi,
                        'SKS Berlangsung': widget.submission.personal.sks,
                        'total SKS': widget.submission.personal.totalSks,
                        'IPK': widget.submission.personal.ipk,
                      },
                      'Personal Data',
                      {
                        'Dosen Approval':
                            widget.submission.personal.dosenVerifier,
                        'LKM Approval': widget.submission.personal.lkmVerifier,
                      },
                      'assets/images/personal_information.png',
                    ),
                    SizedBox(
                      height: widget.verifyData != null &&
                              widget.submission.isVerifying
                          ? 10
                          : 0,
                    ),
                    widget.verifyData != null && widget.submission.isVerifying
                        ? (widget.verifyData.user.role == Role.DosenWali &&
                                widget.submission.personal.dosenVerifier ==
                                    null)
                            ? generateButtonApproval(
                                width: double.infinity,
                                terima:
                                    widget.verifyData.isDosenApprovedPersonal,
                                tolak:
                                    widget.verifyData.isDosenRejectedPersonal,
                                onTapTerima: (bool newValue) {
                                  widget.verifyData.isDosenApprovedPersonal =
                                      newValue;
                                },
                                onTapTolak: (bool newValue) {
                                  widget.verifyData.isDosenRejectedPersonal =
                                      newValue;
                                },
                              )
                            : (widget.verifyData.user.role ==
                                        Role.Kemahasiswaan &&
                                    widget.submission.personal.lkmVerifier ==
                                        null)
                                ? generateButtonApproval(
                                    width: double.infinity,
                                    terima:
                                        widget.verifyData.isLKMApprovedPersonal,
                                    tolak:
                                        widget.verifyData.isLKMRejectedPersonal,
                                    onTapTerima: (bool newValue) {
                                      widget.verifyData.isLKMApprovedPersonal =
                                          newValue;
                                    },
                                    onTapTolak: (bool newValue) {
                                      widget.verifyData.isLKMRejectedPersonal =
                                          newValue;
                                    },
                                  )
                                : SizedBox()
                        : SizedBox(),
                    widget.submission.letterKind == LetterKind.SuratPengantar
                        ? generateListInformation(
                            context,
                            {
                              'nama': widget.submission.company.companyName,
                              'alamat':
                                  widget.submission.company.companyAddress,
                              'email': widget.submission.company.companyEmail,
                              'no. Telp.':
                                  widget.submission.company.companyPhone,
                              'penerima': widget.submission.company.recipient,
                              'posisi Penerima':
                                  widget.submission.company.recipientPosition,
                              'awal Magang/KP':
                                  widget.submission.company.beginWork.dateLong,
                              'akhir Magang/KP':
                                  widget.submission.company.endWork.dateLong,
                              'durasi Magang/KP':
                                  '${widget.submission.company.endWork.difference(widget.submission.company.beginWork).inDays} Hari'
                            },
                            'Company Data',
                            {
                              'Dosen Approval':
                                  widget.submission.company.dosenVerifier,
                              'LKM Approval':
                                  widget.submission.company.lkmVerifier,
                            },
                            'assets/images/company_data.png',
                          )
                        : generateListInformation(
                            context,
                            {
                              'Tujuan Dispensasi':
                                  widget.submission.dispen.purpose,
                              'awal Dispensasi':
                                  widget.submission.dispen.begin.dateLong,
                              'akhir Dispensasi':
                                  widget.submission.dispen.end.dateLong,
                              'durasi Dispensasi':
                                  '${widget.submission.dispen.end.difference(widget.submission.dispen.begin).inDays} Hari'
                            },
                            'Dispensation Data',
                            {
                              'Dosen Approval':
                                  widget.submission.dispen.dosenVerifier,
                              'LKM Approval':
                                  widget.submission.dispen.lkmVerifier,
                            },
                            'assets/images/dispen.png',
                          ),
                    SizedBox(
                      height: widget.verifyData != null &&
                              widget.submission.isVerifying
                          ? 10
                          : 0,
                    ),
                    widget.submission.letterKind == LetterKind.SuratPengantar
                        ? widget.verifyData != null &&
                                widget.submission.isVerifying
                            ? (widget.verifyData.user.role == Role.DosenWali &&
                                    widget.submission.company.dosenVerifier ==
                                        null)
                                ? generateButtonApproval(
                                    width: double.infinity,
                                    terima: widget
                                        .verifyData.isDosenApprovedCompany,
                                    tolak: widget
                                        .verifyData.isDosenRejectedCompany,
                                    onTapTerima: (bool newValue) {
                                      widget.verifyData.isDosenApprovedCompany =
                                          newValue;
                                    },
                                    onTapTolak: (bool newValue) {
                                      widget.verifyData.isDosenRejectedCompany =
                                          newValue;
                                    },
                                  )
                                : (widget.verifyData.user.role ==
                                            Role.Kemahasiswaan &&
                                        widget.submission.company.lkmVerifier ==
                                            null)
                                    ? generateButtonApproval(
                                        width: double.infinity,
                                        terima: widget
                                            .verifyData.isLKMApprovedCompany,
                                        tolak: widget
                                            .verifyData.isLKMRejectedCompany,
                                        onTapTerima: (bool newValue) {
                                          widget.verifyData
                                              .isLKMApprovedCompany = newValue;
                                        },
                                        onTapTolak: (bool newValue) {
                                          widget.verifyData
                                              .isLKMRejectedCompany = newValue;
                                        },
                                      )
                                    : SizedBox()
                            : SizedBox()
                        : widget.verifyData != null &&
                                widget.submission.isVerifying
                            ? (widget.verifyData.user.role == Role.DosenWali &&
                                    widget.submission.dispen.dosenVerifier ==
                                        null)
                                ? generateButtonApproval(
                                    width: double.infinity,
                                    terima: widget
                                        .verifyData.isDosenApprovedCompany,
                                    tolak: widget
                                        .verifyData.isDosenRejectedCompany,
                                    onTapTerima: (bool newValue) {
                                      widget.verifyData.isDosenApprovedCompany =
                                          newValue;
                                    },
                                    onTapTolak: (bool newValue) {
                                      widget.verifyData.isDosenRejectedCompany =
                                          newValue;
                                    },
                                  )
                                : (widget.verifyData.user.role ==
                                            Role.Kemahasiswaan &&
                                        widget.submission.dispen.lkmVerifier ==
                                            null)
                                    ? generateButtonApproval(
                                        width: double.infinity,
                                        terima: widget
                                            .verifyData.isLKMApprovedCompany,
                                        tolak: widget
                                            .verifyData.isLKMRejectedCompany,
                                        onTapTerima: (bool newValue) {
                                          widget.verifyData
                                              .isLKMApprovedCompany = newValue;
                                        },
                                        onTapTolak: (bool newValue) {
                                          widget.verifyData
                                              .isLKMRejectedCompany = newValue;
                                        },
                                      )
                                    : SizedBox()
                            : SizedBox(),
                    SizedBox(height: 20),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Berkas - Berkas',
                        style: blackTextFont.copyWith(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 150,
                      child: Image.asset('assets/images/my_files.png'),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 24),
                      child: Text(
                        'Preview\nTranskrip Nilai',
                        style: blackTextFont.copyWith(fontSize: 20),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      width: double.infinity,
                      height: 30,
                      child: Text(
                        widget.submission.transkripNilaiFileName,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: blackTextFont,
                      ),
                    ),
                    TemplatePageWidget(
                      width: double.infinity,
                      height: 350,
                      isLoading: _isNilaiLoading,
                      onPickFile: () => _onTapPreviewer(_nilaiPath),
                      previewPath: _previewNilaiPath,
                      isDeletable: false,
                    ),
                    SizedBox(
                      height: widget.verifyData != null &&
                              widget.submission.isVerifying
                          ? 10
                          : 0,
                    ),
                    widget.verifyData != null && widget.submission.isVerifying
                        ? (widget.verifyData.user.role == Role.DosenWali &&
                                widget.submission.nilaiDosenVerifier == null)
                            ? generateButtonApproval(
                                width: double.infinity,
                                terima: widget
                                    .verifyData.isDosenApprovedTranskripNilai,
                                tolak: widget
                                    .verifyData.isDosenRejectedTranskripNilai,
                                onTapTerima: (bool newValue) {
                                  widget.verifyData
                                      .isDosenApprovedTranskripNilai = newValue;
                                },
                                onTapTolak: (bool newValue) {
                                  widget.verifyData
                                      .isDosenRejectedTranskripNilai = newValue;
                                },
                              )
                            : (widget.verifyData.user.role ==
                                        Role.Kemahasiswaan &&
                                    widget.submission.nilaiLkmVerifier == null)
                                ? generateButtonApproval(
                                    width: double.infinity,
                                    terima: widget
                                        .verifyData.isLKMApprovedTranskripNilai,
                                    tolak: widget
                                        .verifyData.isLKMRejectedTranskripNilai,
                                    onTapTerima: (bool newValue) {
                                      widget.verifyData
                                              .isLKMApprovedTranskripNilai =
                                          newValue;
                                    },
                                    onTapTolak: (bool newValue) {
                                      widget.verifyData
                                              .isLKMRejectedTranskripNilai =
                                          newValue;
                                    },
                                  )
                                : SizedBox()
                        : SizedBox(),
                    SizedBox(height: 20),
                    Container(
                      margin: const EdgeInsets.only(bottom: 24),
                      child: Text(
                        'Preview\nKSM',
                        style: blackTextFont.copyWith(fontSize: 20),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      width: double.infinity,
                      height: 30,
                      child: Text(
                        widget.submission.ksmFileName,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: blackTextFont,
                      ),
                    ),
                    TemplatePageWidget(
                      width: double.infinity,
                      height: 350,
                      isLoading: _isKsmLoading,
                      onPickFile: () => _onTapPreviewer(_ksmPath),
                      previewPath: _previewKsmPath,
                      isDeletable: false,
                    ),
                    SizedBox(
                      height: widget.verifyData != null &&
                              widget.submission.isVerifying
                          ? 10
                          : 0,
                    ),
                    widget.verifyData != null && widget.submission.isVerifying
                        ? (widget.verifyData.user.role == Role.DosenWali &&
                                widget.submission.ksmDosenVerifier == null)
                            ? generateButtonApproval(
                                width: double.infinity,
                                terima: widget.verifyData.isDosenApprovedKSM,
                                tolak: widget.verifyData.isDosenRejectedKSM,
                                onTapTerima: (bool newValue) {
                                  widget.verifyData.isDosenApprovedKSM =
                                      newValue;
                                },
                                onTapTolak: (bool newValue) {
                                  widget.verifyData.isDosenRejectedKSM =
                                      newValue;
                                },
                              )
                            : (widget.verifyData.user.role ==
                                        Role.Kemahasiswaan &&
                                    widget.submission.ksmLkmVerifier == null)
                                ? generateButtonApproval(
                                    width: double.infinity,
                                    terima: widget.verifyData.isLKMApprovedKSM,
                                    tolak: widget.verifyData.isLKMRejectedKSM,
                                    onTapTerima: (bool newValue) {
                                      widget.verifyData.isLKMApprovedKSM =
                                          newValue;
                                    },
                                    onTapTolak: (bool newValue) {
                                      widget.verifyData.isLKMRejectedKSM =
                                          newValue;
                                    },
                                  )
                                : SizedBox()
                        : SizedBox(),
                    SizedBox(height: 20),
                    Container(
                      margin: const EdgeInsets.only(bottom: 24),
                      child: Text(
                        'Preview\nHasil Surat',
                        style: blackTextFont.copyWith(fontSize: 20),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      width: double.infinity,
                      height: 30,
                      child: Text(
                        widget.submission.suratFileName != null
                            ? widget.submission.suratFileName
                            : _suratFileName != null
                                ? _suratFileName
                                : 'Tidak ada dokumen',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: blackTextFont,
                      ),
                    ),
                    TemplatePageWidget(
                      width: double.infinity,
                      height: 350,
                      isLoading: _isSuratLoading,
                      onDeleteFile: onTapDelete,
                      onPickFile: () {
                        if (widget.submission.suratUrl != null) {
                          _onTapPreviewer(_suratPath);
                        } else {
                          if (widget.verifyData != null &&
                              widget.submission.isProcessing) {
                            if (widget.verifyData.user.role ==
                                Role.Kemahasiswaan) {
                              onTapAddSurat();
                            }
                          }
                        }
                      },
                      previewPath: _previewSuratPath,
                      isEditable: (widget.verifyData != null &&
                              widget.submission.isProcessing)
                          ? (widget.verifyData.user.role == Role.Kemahasiswaan)
                              ? true
                              : false
                          : false,
                      isDeletable: widget.verifyData != null &&
                              widget.submission.isProcessing
                          ? true
                          : false,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    widget.verifyData != null && !widget.submission.isDone
                        ? ((widget.verifyData.user.role == Role.DosenWali &&
                                    widget.submission.personal.dosenVerifier ==
                                        null) ||
                                (widget.verifyData.user.role ==
                                        Role.Kemahasiswaan &&
                                    widget.submission.personal.lkmVerifier ==
                                        null) ||
                                (widget.submission.isProcessing &&
                                    widget.verifyData.user.role ==
                                        Role.Kemahasiswaan))
                            ? Container(
                                width: double.infinity,
                                height: 46,
                                child: RaisedButton(
                                  color: Color(0xFF3E9D9D),
                                  child: Text(
                                    'Submit',
                                    style: whiteTextFont.copyWith(
                                      fontSize: 16,
                                    ),
                                  ),
                                  onPressed: () {
                                    if (widget.submission.isProcessing &&
                                        widget.verifyData.user.role ==
                                            Role.Kemahasiswaan) {
                                      if (_suratFile == null) {
                                        Flushbar(
                                          backgroundColor: Color(0xFFFF5C83),
                                          duration:
                                              Duration(milliseconds: 1500),
                                          flushbarPosition:
                                              FlushbarPosition.BOTTOM,
                                          message:
                                              'Surat Pengantar harus diupload',
                                        )..show(context);
                                      } else {
                                        context
                                            .bloc<PageBloc>()
                                            .add(GoToSuccessPage(
                                              GoToSubmissionDetailPage(
                                                  widget.submission,
                                                  verifyData:
                                                      widget.verifyData),
                                              submission: widget.submission,
                                              verifyData: widget.verifyData,
                                            ));
                                      }
                                    } else if (widget.verifyData.user.role ==
                                        Role.DosenWali) {
                                      if (!(widget.verifyData
                                                  .isDosenApprovedPersonal ||
                                              widget.verifyData
                                                  .isDosenRejectedPersonal) ||
                                          !(widget.verifyData
                                                  .isDosenApprovedCompany ||
                                              widget.verifyData
                                                  .isDosenRejectedCompany) ||
                                          !(widget.verifyData
                                                  .isDosenApprovedTranskripNilai ||
                                              widget.verifyData
                                                  .isDosenRejectedTranskripNilai) ||
                                          !(widget.verifyData
                                                  .isDosenApprovedKSM ||
                                              widget.verifyData
                                                  .isDosenRejectedKSM)) {
                                        Flushbar(
                                          backgroundColor: Color(0xFFFF5C83),
                                          duration:
                                              Duration(milliseconds: 1500),
                                          flushbarPosition:
                                              FlushbarPosition.BOTTOM,
                                          message:
                                              'Semua record belum diverifikasi',
                                        )..show(context);
                                      } else {
                                        bool isRejected = (widget.verifyData
                                                    .isDosenRejectedCompany ||
                                                widget.verifyData
                                                    .isDosenRejectedPersonal ||
                                                widget.verifyData
                                                    .isDosenRejectedKSM ||
                                                widget.verifyData
                                                    .isDosenRejectedTranskripNilai)
                                            ? true
                                            : false;
                                        context
                                            .bloc<PageBloc>()
                                            .add(GoToSuccessPage(
                                              GoToSubmissionDetailPage(
                                                  widget.submission,
                                                  verifyData:
                                                      widget.verifyData),
                                              submission: widget.submission
                                                  .copyWith(
                                                      isRejected: isRejected),
                                              verifyData: widget.verifyData,
                                            ));
                                        print('Berhasil');
                                      }
                                    } else {
                                      if (!(widget.verifyData
                                                  .isLKMApprovedPersonal ||
                                              widget.verifyData
                                                  .isLKMRejectedPersonal) ||
                                          !(widget.verifyData
                                                  .isLKMApprovedCompany ||
                                              widget.verifyData
                                                  .isLKMRejectedCompany) ||
                                          !(widget.verifyData
                                                  .isLKMApprovedTranskripNilai ||
                                              widget.verifyData
                                                  .isLKMRejectedTranskripNilai) ||
                                          !(widget.verifyData
                                                  .isLKMApprovedKSM ||
                                              widget.verifyData
                                                  .isLKMRejectedKSM)) {
                                        Flushbar(
                                          backgroundColor: Color(0xFFFF5C83),
                                          duration:
                                              Duration(milliseconds: 1500),
                                          flushbarPosition:
                                              FlushbarPosition.BOTTOM,
                                          message:
                                              'Semua record belum diverifikasi',
                                        )..show(context);
                                      } else {
                                        bool isRejected = (widget.verifyData
                                                    .isLKMRejectedCompany ||
                                                widget.verifyData
                                                    .isLKMRejectedPersonal ||
                                                widget.verifyData
                                                    .isLKMRejectedKSM ||
                                                widget.verifyData
                                                    .isLKMRejectedTranskripNilai)
                                            ? true
                                            : false;
                                        context
                                            .bloc<PageBloc>()
                                            .add(GoToSuccessPage(
                                              GoToSubmissionDetailPage(
                                                  widget.submission,
                                                  verifyData:
                                                      widget.verifyData),
                                              submission: widget.submission
                                                  .copyWith(
                                                      isRejected: isRejected),
                                              verifyData: widget.verifyData,
                                            ));
                                        print('Berhasil');
                                      }
                                    }
                                  },
                                ),
                              )
                            : SizedBox()
                        : SizedBox(),
                    SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
