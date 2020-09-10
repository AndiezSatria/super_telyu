part of 'pages.dart';

class UploadedFilePage extends StatefulWidget {
  final SubmissionData submissionData;
  final PageEvent pageEvent;
  UploadedFilePage(this.submissionData, this.pageEvent);
  @override
  _UploadedFilePageState createState() => _UploadedFilePageState();
}

class _UploadedFilePageState extends State<UploadedFilePage> {
  File _transkripNilai;
  String _nilaiPath;
  String _transkripNilaiFileName;
  String _nilaiPreviewPath;
  bool _isNilaiLoading = false;

  File _ksm;
  String _ksmPath;
  String _ksmFileName;
  String _ksmPreviewPath;
  bool _isKsmLoading = false;

  int _pageNumber = 1;

  @override
  void initState() {
    super.initState();
    _transkripNilai = widget.submissionData.transkripNilai;
    _transkripNilaiFileName = widget.submissionData.transkripNilaiFileName;
    _nilaiPath = widget.submissionData.transkripNilaiPath;
    _ksm = widget.submissionData.ksm;
    _ksmFileName = widget.submissionData.ksmFileName;
    _ksmPath = widget.submissionData.ksmPath;

    if ((_nilaiPath != null && _nilaiPath != '') ||
        (_ksmPath != null && _ksmPath != '')) {
      _getPreviewPath().then((_) {
        setState(() {
          _isKsmLoading = false;
          _isNilaiLoading = false;
        });
      });
    }
  }

  Future<void> _getPreviewPath() async {
    _isKsmLoading = true;
    _isNilaiLoading = true;
    _ksmPreviewPath = await PdfPreviewer.getPagePreview(
        filePath: _ksmPath, pageNumber: _pageNumber);
    _nilaiPreviewPath = await PdfPreviewer.getPagePreview(
        filePath: _nilaiPath, pageNumber: _pageNumber);
  }

  void _onTapTranskripNilai() async {
    if (_transkripNilai == null) {
      setState(() {
        _isNilaiLoading = true;
      });
      await getFile().then((value) async {
        _transkripNilai = value['file'];
        _nilaiPath = value['path'];
        _transkripNilaiFileName = value['fileName'];
        _nilaiPreviewPath = await PdfPreviewer.getPagePreview(
            filePath: _nilaiPath, pageNumber: _pageNumber);
        widget.submissionData.transkripNilai = _transkripNilai;
        widget.submissionData.transkripNilaiFileName = _transkripNilaiFileName;
        widget.submissionData.transkripNilaiPath = _nilaiPath;
      });

      setState(() {
        _isNilaiLoading = false;
      });
    } else {
      context.bloc<PageBloc>().add(GoToPdfViewPage(_nilaiPath,
          GoToUploadedFilePage(widget.submissionData, widget.pageEvent)));
    }
  }

  void _onDeleteNilai() {
    setState(() {
      _transkripNilai = null;
      _nilaiPath = null;
      _transkripNilaiFileName = null;
      _nilaiPreviewPath = null;
      widget.submissionData.transkripNilai = _transkripNilai;
      widget.submissionData.transkripNilaiFileName = _transkripNilaiFileName;
      widget.submissionData.transkripNilaiPath = _nilaiPath;
    });
  }

  void _onTapKsm() async {
    if (_ksm == null) {
      setState(() {
        _isKsmLoading = true;
      });
      await getFile().then((value) async {
        _ksm = value['file'];
        _ksmPath = value['path'];
        _ksmFileName = value['fileName'];
        _ksmPreviewPath = await PdfPreviewer.getPagePreview(
            filePath: _ksmPath, pageNumber: _pageNumber);

        widget.submissionData.ksm = _ksm;
        widget.submissionData.ksmFileName = _ksmFileName;
        widget.submissionData.ksmPath = _ksmPath;
      });

      setState(() {
        _isKsmLoading = false;
      });
    } else {
      context.bloc<PageBloc>().add(GoToPdfViewPage(_ksmPath,
          GoToUploadedFilePage(widget.submissionData, widget.pageEvent)));
    }
  }

  void _onDeleteKsm() {
    setState(() {
      _ksm = null;
      _ksmPath = null;
      _ksmFileName = null;
      _ksmPreviewPath = null;
      widget.submissionData.ksm = _ksm;
      widget.submissionData.ksmFileName = _ksmFileName;
      widget.submissionData.ksmPath = _ksmPath;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        context.bloc<PageBloc>().add(widget.pageEvent);
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
            title: Center(child: Text('Pengajuan Surat')),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                context.bloc<PageBloc>().add(widget.pageEvent);
              },
            ),
          ),
          body: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
            child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 200,
                      margin: const EdgeInsets.only(top: 30, bottom: 24),
                      child: Image.asset(
                        'assets/images/my_files.png',
                        // fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 24),
                      child: Text(
                        'Upload\nTranskrip Nilai',
                        style: blackTextFont.copyWith(fontSize: 20),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      width: double.infinity,
                      height: 30,
                      child: Text(
                        _transkripNilaiFileName != null &&
                                _transkripNilaiFileName != ''
                            ? _transkripNilaiFileName
                            : 'Tidak ada file',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: blackTextFont,
                      ),
                    ),
                    TemplatePageWidget(
                      width: double.infinity,
                      height: 350,
                      isLoading: _isNilaiLoading,
                      onPickFile: _onTapTranskripNilai,
                      previewPath: _nilaiPreviewPath,
                      onDeleteFile: _onDeleteNilai,
                      isEditable: true,
                      isDeletable: true,
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 30, bottom: 24),
                      child: Text(
                        'Upload KSM',
                        style: blackTextFont.copyWith(fontSize: 20),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      width: double.infinity,
                      height: 30,
                      child: Text(
                        _ksmFileName != null && _ksmFileName != ''
                            ? _ksmFileName
                            : 'Tidak ada file',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: blackTextFont,
                      ),
                    ),
                    TemplatePageWidget(
                      width: double.infinity,
                      height: 350,
                      isLoading: _isKsmLoading,
                      onPickFile: _onTapKsm,
                      previewPath: _ksmPreviewPath,
                      onDeleteFile: _onDeleteKsm,
                      isEditable: true,
                      isDeletable: true,
                    ),
                    SizedBox(height: 36),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: 250,
                        height: 46,
                        child: RaisedButton(
                          color: Color(0xFF3E9D9D),
                          elevation: 0,
                          child: Text(
                            'Submit',
                            style: whiteTextFont.copyWith(fontSize: 18),
                          ),
                          onPressed: (_ksm != null && _transkripNilai != null)
                              ? () {
                                  context.bloc<PageBloc>().add(GoToSuccessPage(
                                        GoToUploadedFilePage(
                                            widget.submissionData,
                                            widget.pageEvent),
                                        submissionData: widget.submissionData,
                                      ));
                                }
                              : null,
                        ),
                      ),
                    ),
                    SizedBox(height: 50)
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
