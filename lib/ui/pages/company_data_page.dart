part of 'pages.dart';

class CompanyDataPage extends StatefulWidget {
  final SubmissionData submissionData;
  CompanyDataPage(this.submissionData);
  @override
  _CompanyDataPageState createState() => _CompanyDataPageState();
}

class _CompanyDataPageState extends State<CompanyDataPage> {
  CompanyData _data;

  DateTime selectedBeginDate;
  DateTime selectedEndDate;

  List<String> _listGrade = const [
    'Bapak',
    'Ibu',
  ];

  List<DropdownMenuItem> generateItems(List<String> listGrade) {
    List<DropdownMenuItem> items = [];
    for (var item in listGrade) {
      items.add(DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: blackTextFont.copyWith(fontSize: 16),
        ),
      ));
    }
    return items;
  }

  Widget generateDatePicker(
    String title,
    DateTime selectedDate,
    Function onTapDatePicker,
  ) {
    return Container(
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                Text(
                  '$title : ',
                  style: blackTextFont,
                ),
                SizedBox(
                  width: 2,
                ),
                Text(
                  selectedDate == null
                      ? 'Belum dipilih'
                      : '${selectedDate.dateLong}',
                  style: blackTextFont,
                )
              ],
            ),
          ),
          FittedBox(
            child: Align(
              alignment: Alignment.centerLeft,
              child: FlatButton(
                onPressed: onTapDatePicker,
                child: Text(
                  'Pilih Tanggal',
                  style: blackTextFont.copyWith(
                      fontWeight: FontWeight.bold, color: primaryColor),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  TextEditingController companyNameController = TextEditingController();
  TextEditingController companyEmailController = TextEditingController();
  TextEditingController companyPhoneController = TextEditingController();
  TextEditingController companyAddressController = TextEditingController();
  TextEditingController recipientNameController = TextEditingController();
  TextEditingController recipientPositionController = TextEditingController();
  String selectedGrade;

  @override
  void initState() {
    super.initState();
    _data = widget.submissionData.companyData;
    companyNameController.text = _data.companyName;
    companyEmailController.text = _data.companyEmail;
    companyPhoneController.text = _data.companyPhone;
    companyAddressController.text = _data.companyAddress;
    recipientNameController.text = _data.recipientName;
    recipientPositionController.text = _data.recipientPosition;
  }

  Widget generateTextField(String title, TextEditingController controller,
      {bool isPassword = false, TextInputType inputType, Function onChange}) {
    return TextField(
      obscureText: isPassword,
      controller: controller,
      keyboardType: inputType,
      onChanged: onChange,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        labelText: title,
        hintText: title,
      ),
    );
  }

  Widget generateErrorMessage(String title) {
    return Flushbar(
      backgroundColor: Color(0xFFFF5C83),
      duration: Duration(milliseconds: 1500),
      flushbarPosition: FlushbarPosition.BOTTOM,
      message: title,
    )..show(context);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        context
            .bloc<PageBloc>()
            .add(GoToPersonalDataPage(widget.submissionData));
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
                context
                    .bloc<PageBloc>()
                    .add(GoToPersonalDataPage(widget.submissionData));
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
            padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
            width: double.infinity,
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
                        'assets/images/company_data.png',
                        // fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 24),
                      child: Text(
                        'Data\nPerusahaan',
                        style: blackTextFont.copyWith(fontSize: 20),
                      ),
                    ),
                    generateTextField('Nama Perusahaan', companyNameController),
                    SizedBox(height: 10),
                    generateTextField(
                        'Email Perusahaan', companyEmailController),
                    SizedBox(height: 10),
                    generateTextField('Alamat', companyAddressController),
                    SizedBox(height: 10),
                    generateTextField('Nomor Telepon', companyPhoneController,
                        inputType: TextInputType.phone),
                    SizedBox(height: 10),
                    generateDatePicker('Mulai', selectedBeginDate, () {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2020, DateTime.now().month - 1),
                        lastDate: selectedEndDate ??
                            DateTime(DateTime.now().year + 1),
                      ).then((pickedDate) {
                        if (pickedDate == null) {
                          return;
                        }
                        setState(() {
                          selectedBeginDate = pickedDate;
                        });
                      });
                    }),
                    SizedBox(
                      height: 10,
                    ),
                    generateDatePicker('Berakhir', selectedEndDate, () {
                      showDatePicker(
                        context: context,
                        initialDate: selectedBeginDate ?? DateTime.now(),
                        firstDate: selectedBeginDate ?? DateTime.now(),
                        lastDate: DateTime(DateTime.now().year + 1),
                      ).then((pickedDate) {
                        if (pickedDate == null) {
                          return;
                        }
                        setState(() {
                          selectedEndDate = pickedDate;
                        });
                      });
                    }),
                    Container(
                      margin: const EdgeInsets.only(top: 30, bottom: 24),
                      child: Text(
                        'Data\nPenerima Surat',
                        style: blackTextFont.copyWith(fontSize: 20),
                      ),
                    ),
                    generateTextField('Nama Penerima', recipientNameController),
                    SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: DropdownButton(
                        isExpanded: true,
                        value: selectedGrade,
                        items: generateItems(_listGrade),
                        onChanged: (item) {
                          print(item);
                          setState(() {
                            selectedGrade = item;
                          });
                        },
                        hint: Text('Gelar'),
                      ),
                    ),
                    SizedBox(height: 10),
                    generateTextField(
                        'Jabatan/Posisi', recipientPositionController),
                    SizedBox(height: 36),
                    Align(
                      alignment: Alignment.center,
                      child: FloatingActionButton(
                        backgroundColor: primaryColor,
                        elevation: 0,
                        child: Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          if (!(companyNameController.text.trim() != "" &&
                              companyEmailController.text.trim() != "" &&
                              companyPhoneController.text.trim() != "" &&
                              companyAddressController.text.trim() != "" &&
                              recipientNameController.text.trim() != "" &&
                              recipientPositionController.text.trim() != "" &&
                              selectedGrade != null)) {
                            generateErrorMessage("Mohon isi semua bagan");
                          } else if (!EmailValidator.validate(
                              companyEmailController.text)) {
                            generateErrorMessage(
                                "Format alamat email yang dimasukkan salah");
                          } else if (selectedBeginDate == null ||
                              selectedEndDate == null) {
                            generateErrorMessage(
                                "Tanggal mulai dan berakhir harus diisi");
                          } else {
                            print(companyNameController.text);
                            _data.companyName = companyNameController.text;
                            _data.companyEmail = companyEmailController.text;
                            _data.companyPhone = companyPhoneController.text;
                            _data.companyAddress =
                                companyAddressController.text;
                            _data.recipientName = recipientNameController.text;
                            _data.recipientPosition =
                                recipientPositionController.text;
                            _data.recipientGrade = selectedGrade;
                            _data.beginWork = selectedBeginDate;
                            _data.endWork = selectedEndDate;
                            widget.submissionData.companyData = _data;
                            print(
                                widget.submissionData.companyData.companyName);
                            context.bloc<PageBloc>().add(GoToUploadedFilePage(
                                widget.submissionData,
                                GoToCompanyDataPage(widget.submissionData)));
                          }
                        },
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
