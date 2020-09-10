part of 'pages.dart';

class RegistrationPage extends StatefulWidget {
  final RegistrationData registrationData;

  RegistrationPage(this.registrationData);
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController nomorIndukController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController retypePasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.registrationData.name;
    emailController.text = widget.registrationData.email;
    nomorIndukController.text = widget.registrationData.nomorInduk;
  }

  @override
  Widget build(BuildContext context) {
    Widget generateTextField(String title, TextEditingController controller,
        {bool isPassword = false}) {
      return TextField(
        obscureText: isPassword,
        controller: controller,
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
        flushbarPosition: FlushbarPosition.TOP,
        message: title,
      )..show(context);
    }

    return WillPopScope(
      onWillPop: () async {
        context
            .bloc<PageBloc>()
            .add(GoToChooseRolePage(widget.registrationData));
        return;
      },
      child: Stack(
        children: [
          Container(
            color: primaryColor,
          ),
          SafeArea(
            child: Scaffold(
              backgroundColor: Colors.white,
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
                child: ListView(
                  children: [
                    Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 20, bottom: 22),
                          height: 56,
                          child: Stack(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.centerLeft,
                                child: GestureDetector(
                                  onTap: () {
                                    context.bloc<PageBloc>().add(
                                        GoToChooseRolePage(
                                            widget.registrationData));
                                  },
                                  child: Icon(
                                    Icons.arrow_back,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Center(
                                child: Text(
                                  "Buat Akun\nBarumu",
                                  style: blackTextFont.copyWith(fontSize: 20),
                                  textAlign: TextAlign.center,
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          width: 90,
                          height: 104,
                          child: Stack(
                            children: <Widget>[
                              Container(
                                width: 90,
                                height: 90,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: (widget.registrationData
                                                .profilePicture ==
                                            null)
                                        ? AssetImage(
                                            "assets/images/user_pic.png")
                                        : FileImage(widget
                                            .registrationData.profilePicture),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: GestureDetector(
                                  onTap: () async {
                                    (widget.registrationData.profilePicture ==
                                            null)
                                        ? widget.registrationData
                                            .profilePicture = await getImage()
                                        : widget.registrationData
                                            .profilePicture = null;
                                    setState(() {});
                                  },
                                  child: Container(
                                    height: 28,
                                    width: 28,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: AssetImage((widget
                                                    .registrationData
                                                    .profilePicture ==
                                                null)
                                            ? "assets/images/btn_add_photo.png"
                                            : "assets/images/btn_del_photo.png"),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 36),
                        generateTextField('Nama', nameController),
                        SizedBox(height: 16),
                        generateTextField('Alamat Email', emailController),
                        SizedBox(height: 16),
                        generateTextField(
                            (widget.registrationData.role == Role.Mahasiswa)
                                ? 'NIM'
                                : 'NIDN',
                            nomorIndukController),
                        SizedBox(height: 16),
                        generateTextField('Password', passwordController,
                            isPassword: true),
                        SizedBox(height: 16),
                        generateTextField(
                            'Password Ulang', retypePasswordController,
                            isPassword: true),
                        SizedBox(height: 30),
                        FloatingActionButton(
                          onPressed: () {
                            if (!(nameController.text.trim() != "" &&
                                emailController.text.trim() != "" &&
                                passwordController.text.trim() != "" &&
                                retypePasswordController.text.trim() != "" &&
                                nomorIndukController.text.trim() != "")) {
                              generateErrorMessage("Mohon isi semua bagan");
                            } else if (passwordController.text !=
                                retypePasswordController.text) {
                              generateErrorMessage(
                                  "Password tidak cocok dengan password ulang");
                            } else if (passwordController.text.length < 6) {
                              generateErrorMessage(
                                  "Panjang minimum password 6 karakter");
                            } else if (!EmailValidator.validate(
                                emailController.text)) {
                              generateErrorMessage(
                                  "Format alamat email yang Anda masukkan salah");
                            } else {
                              widget.registrationData.name =
                                  nameController.text;
                              widget.registrationData.email =
                                  emailController.text;
                              widget.registrationData.password =
                                  passwordController.text;
                              widget.registrationData.nomorInduk =
                                  nomorIndukController.text;
                              context.bloc<PageBloc>().add(
                                  GoToAccountConfirmationPage(
                                      widget.registrationData));
                            }
                          },
                          child: Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          ),
                          backgroundColor: primaryColor,
                          elevation: 0,
                        ),
                        SizedBox(height: 50),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
