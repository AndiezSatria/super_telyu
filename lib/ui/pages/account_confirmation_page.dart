part of 'pages.dart';

class AccountConfirmationPage extends StatefulWidget {
  final RegistrationData registrationData;

  AccountConfirmationPage(this.registrationData);

  @override
  _AccountConfirmationPageState createState() =>
      _AccountConfirmationPageState();
}

class _AccountConfirmationPageState extends State<AccountConfirmationPage> {
  bool isSigningUp = false;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(color: primaryColor),
        SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
              child: ListView(
                children: [
                  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 20, bottom: 90),
                        height: 56,
                        child: Stack(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.centerLeft,
                              child: GestureDetector(
                                onTap: () {
                                  context.bloc<PageBloc>().add(
                                      GoToRegistrationPage(
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
                                "Konfirmasi\nAkun Baru",
                                style: blackTextFont.copyWith(fontSize: 20),
                                textAlign: TextAlign.center,
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: 160,
                        height: 160,
                        margin: const EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image:
                                (widget.registrationData.profilePicture == null)
                                    ? AssetImage('assets/images/user_pic.png')
                                    : FileImage(
                                        widget.registrationData.profilePicture),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Text(
                        'Selamat Datang, Telyutizen',
                        style: blackTextFont.copyWith(
                            fontSize: 16, fontWeight: FontWeight.w300),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        width: double.infinity,
                        child: Text(
                          widget.registrationData.name,
                          textAlign: TextAlign.center,
                          style: blackTextFont.copyWith(fontSize: 20),
                        ),
                      ),
                      Text(
                        (widget.registrationData.role == Role.Mahasiswa)
                            ? 'Mahasiswa'
                            : (widget.registrationData.role == Role.DosenWali)
                                ? 'Dosen Wali'
                                : 'Kemahasiswaan',
                        style: blackTextFont.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                            color: Colors.black),
                      ),
                      Text(
                        widget.registrationData.nomorInduk,
                        style: whiteNumberFont.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                            color: Colors.black),
                      ),
                      SizedBox(
                        height: 110,
                      ),
                      (isSigningUp)
                          ? SpinKitFadingCircle(
                              color: Color(0xFF3E9D9D),
                              size: 45,
                            )
                          : SizedBox(
                              width: 250,
                              height: 45,
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                color: Color(0xFF3E9D9D),
                                child: Text(
                                  "Buat Akunku",
                                  style: whiteTextFont.copyWith(fontSize: 16),
                                ),
                                onPressed: () async {
                                  setState(() {
                                    isSigningUp = true;
                                  });
                                  SignInSignUpResult result =
                                      await AuthServices.signUp(
                                          widget.registrationData.email,
                                          widget.registrationData.password,
                                          widget.registrationData.name,
                                          widget.registrationData.nomorInduk,
                                          widget.registrationData.role);

                                  imageFileToUpload =
                                      widget.registrationData.profilePicture;

                                  if (result.user == null) {
                                    setState(() {
                                      isSigningUp = false;
                                    });
                                    Flushbar(
                                      backgroundColor: Color(0xFFFF5C83),
                                      duration: Duration(milliseconds: 1500),
                                      flushbarPosition: FlushbarPosition.TOP,
                                      message: result.message,
                                    )..show(context);
                                  }
                                },
                              ),
                            )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
