part of 'pages.dart';

class DispenDataPage extends StatefulWidget {
  final SubmissionData submissionData;

  DispenDataPage(this.submissionData);
  @override
  _DispenDataPageState createState() => _DispenDataPageState();
}

class _DispenDataPageState extends State<DispenDataPage> {
  DispenData _data;

  DateTime selectedBeginDate;
  DateTime selectedEndDate;

  TextEditingController purposeController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _data = widget.submissionData.dispenData;
    purposeController.text = widget.submissionData.dispenData.purpose;
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
                      'assets/images/dispen.png',
                      // fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 24),
                    child: Text(
                      'Data\nDispensasi',
                      style: blackTextFont.copyWith(fontSize: 20),
                    ),
                  ),
                  generateTextField('Tujuan Dispensasi', purposeController),
                  SizedBox(
                    height: 18,
                  ),
                  generateDatePicker('Mulai', selectedBeginDate, () {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate:
                          selectedEndDate ?? DateTime(DateTime.now().year + 1),
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
                  SizedBox(
                    height: 36,
                  ),
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
                        if (!(purposeController.text.trim() != '') ||
                            selectedBeginDate == null ||
                            selectedEndDate == null) {
                          generateErrorMessage('Mohon isi semua bagan');
                        } else if (selectedBeginDate.isAfter(selectedEndDate)) {
                          generateErrorMessage(
                              'Tanggal mulai melebihi tanggal akhir');
                        } else {
                          _data.purpose = purposeController.text;
                          _data.begin = selectedBeginDate;
                          _data.end = selectedEndDate;
                          widget.submissionData.dispenData = _data;
                          context.bloc<PageBloc>().add(GoToUploadedFilePage(
                              widget.submissionData,
                              GoToDispenDataPage(widget.submissionData)));
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 50)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
