part of 'pages.dart';

class PersonalDataPage extends StatefulWidget {
  final SubmissionData submissionData;

  PersonalDataPage(this.submissionData);
  @override
  _PersonalDataPageState createState() => _PersonalDataPageState();
}

class _PersonalDataPageState extends State<PersonalDataPage> {
  PersonalData _data;

  List<String> _listProdi = const [
    'D3 Teknologi Komputer',
    'D3 Rekayasa Perangkat Lunak Aplikasi',
    'D3 Teknologi Telekomunikasi',
    'D3 Manajemen Pemasaran',
    'D3 Perhotelan',
    'D3 Sistem Informasi',
    'D3 Sistem Informasi Akuntansi',
    'S1 Terapan Teknologi Rekayasa Multimedia',
  ];

  List<String> listLetterKind = const ['Surat Pengantar', 'Surat Dispensasi'];

  List<DropdownMenuItem> generateItems(List<String> listProdi) {
    List<DropdownMenuItem> items = [];
    for (var item in listProdi) {
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

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController nimController = TextEditingController();
  TextEditingController sksController = TextEditingController();
  TextEditingController totalSksController = TextEditingController();
  TextEditingController ipkController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _data = widget.submissionData.personalData;
    nameController.text = _data.name;
    emailController.text = _data.email;
    nimController.text = _data.nim;
    phoneNumberController.text = _data.phoneNumber;
    sksController.text = _data.sks.toString();
    totalSksController.text = _data.totalSks.toString();
    ipkController.text = _data.ipk.toString();
  }

  Widget generateTextField(String title, TextEditingController controller,
      {bool isPassword = false,
      TextInputType inputType,
      Function onChange,
      bool isEnable = true}) {
    return TextField(
      enabled: isEnable,
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

  List<Widget> generateLetterKindWidgets(BuildContext ctx) {
    double width = (MediaQuery.of(ctx).size.width - 2 * defaultMargin - 24) / 2;
    return listLetterKind
        .map((item) => SelectableBox(
              item,
              width: width,
              isSelected: item == selectedLetterKind,
              onTap: () {
                if (selectedLetterKind == item) {
                  setState(() {
                    selectedLetterKind = null;
                  });
                } else {
                  setState(() {
                    selectedLetterKind = item;
                  });
                }
              },
            ))
        .toList();
  }

  Widget generateErrorMessage(String title) {
    return Flushbar(
      backgroundColor: Color(0xFFFF5C83),
      duration: Duration(milliseconds: 1500),
      flushbarPosition: FlushbarPosition.BOTTOM,
      message: title,
    )..show(context);
  }

  String selectedProdi;
  String selectedLetterKind;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
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
          title: Center(child: Text('Pengajuan Surat')),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              context.bloc<PageBloc>().add(GoToMainPage());
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
                  //note: Header
                  Container(
                    width: double.infinity,
                    height: 200,
                    margin: const EdgeInsets.only(top: 30, bottom: 24),
                    child: Image.asset(
                      'assets/images/personal_information.png',
                      // fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 24),
                    child: Text(
                      'Pilih Jenis\nSurat',
                      style: blackTextFont.copyWith(fontSize: 20),
                    ),
                  ),
                  Wrap(
                    spacing: 24,
                    runSpacing: 24,
                    children: generateLetterKindWidgets(context),
                  ),
                  SizedBox(height: 18),
                  Container(
                    margin: const EdgeInsets.only(bottom: 24),
                    child: Text(
                      'Pengisian Data\nPribadi',
                      style: blackTextFont.copyWith(fontSize: 20),
                    ),
                  ),
                  generateTextField('Nama', nameController, isEnable: false),
                  SizedBox(height: 10),
                  generateTextField('NIM', nimController, isEnable: false),
                  SizedBox(height: 10),
                  generateTextField('Email', emailController, isEnable: false),
                  SizedBox(height: 10),
                  generateTextField('Nomor Handphone', phoneNumberController,
                      inputType: TextInputType.phone),
                  SizedBox(height: 10),
                  DropdownButton(
                    value: selectedProdi,
                    items: generateItems(_listProdi),
                    onChanged: (item) {
                      setState(() {
                        selectedProdi = item;
                      });
                    },
                    hint: Text('Program Studi'),
                  ),
                  SizedBox(height: 10),
                  generateTextField(
                    'SKS Berjalan',
                    sksController,
                    inputType: TextInputType.number,
                  ),
                  SizedBox(height: 10),
                  generateTextField('Total SKS', totalSksController,
                      inputType: TextInputType.number),
                  SizedBox(height: 10),
                  generateTextField('IPK', ipkController,
                      inputType: TextInputType.number),
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
                        if (!(nameController.text.trim() != "" &&
                            emailController.text.trim() != "" &&
                            nameController.text.trim() != "" &&
                            phoneNumberController.text.trim() != "" &&
                            sksController.text.trim() != "" &&
                            totalSksController.text.trim() != "" &&
                            ipkController.text.trim() != "" &&
                            selectedProdi != null &&
                            nimController.text.trim() != "")) {
                          generateErrorMessage("Mohon isi semua bagan");
                        } else if (!EmailValidator.validate(
                            emailController.text)) {
                          generateErrorMessage(
                              "Format alamat email yang dimasukkan salah");
                        } else if (selectedLetterKind == null) {
                          generateErrorMessage('Pilih salah satu jenis surat');
                        } else if (int.parse(sksController.text) > 24 ||
                            int.parse(sksController.text) < 0) {
                          generateErrorMessage('SKS harus diisi dengan benar');
                        } else if (int.parse(totalSksController.text) > 160 ||
                            int.parse(totalSksController.text) < 0) {
                          generateErrorMessage(
                              'Total SKS harus diisi dengan benar');
                        } else if (double.parse(ipkController.text) > 4 ||
                            double.parse(ipkController.text) < 0) {
                          generateErrorMessage('IPK harus diisi dengan benar');
                        } else {
                          _data.name = nameController.text;
                          _data.email = emailController.text;
                          _data.phoneNumber = phoneNumberController.text;
                          _data.nim = nimController.text;
                          _data.sks = int.parse(sksController.text);
                          _data.totalSks = int.parse(totalSksController.text);
                          _data.ipk = double.parse(ipkController.text);
                          _data.prodi = selectedProdi;
                          widget.submissionData.personalData = _data;
                          var selectedLetter;
                          switch (selectedLetterKind) {
                            case 'Surat Pengantar':
                              selectedLetter = LetterKind.SuratPengantar;
                              break;
                            case 'Surat Dispensasi':
                              selectedLetter = LetterKind.SuratDispensasi;
                              break;
                          }
                          widget.submissionData.letterKind = selectedLetter;
                          if (selectedLetter == LetterKind.SuratPengantar) {
                            widget.submissionData.companyData =
                                CompanyData(id: randomAlphaNumeric(8));
                            context.bloc<PageBloc>().add(
                                GoToCompanyDataPage(widget.submissionData));
                          } else if (selectedLetter ==
                              LetterKind.SuratDispensasi) {
                            widget.submissionData.dispenData =
                                DispenData(id: randomAlphaNumeric(8));
                            context
                                .bloc<PageBloc>()
                                .add(GoToDispenDataPage(widget.submissionData));
                          }
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 50)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
