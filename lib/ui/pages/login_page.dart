part of 'pages.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isEmailValid = false;
  bool isPasswordValid = false;
  bool isSigningIn = false;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.bloc<PageBloc>().add(GoToSplashPage());
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
              body: ListView(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: defaultMargin),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 30),
                        Container(
                          width: 120,
                          height: 120,
                          child: Image.asset(
                            'assets/images/telu.png',
                          ),
                        ),
                        SizedBox(height: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Selamat Datang,',
                              style: blackTextFont.copyWith(fontSize: 18),
                            ),
                            Text(
                              'Telyutizen',
                              style: blackTextFont.copyWith(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        TextField(
                          onChanged: (text) {
                            setState(() {
                              isEmailValid = EmailValidator.validate(text);
                            });
                          },
                          controller: emailController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            labelText: 'Alamat Email',
                            hintText: 'Alamat Email',
                          ),
                        ),
                        SizedBox(height: 8),
                        TextField(
                          onChanged: (text) {
                            setState(() {
                              isPasswordValid = text.length >= 6;
                            });
                          },
                          controller: passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            labelText: 'Password',
                            hintText: 'Password',
                          ),
                        ),
                        SizedBox(height: 6),
                        Row(
                          children: <Widget>[
                            Text(
                              "Lupa Password? ",
                              style: blackTextFont.copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey),
                            ),
                            GestureDetector(
                              onTap: () async {
                                if (isEmailValid) {
                                  try {
                                    await AuthServices.resetPassword(
                                            emailController.text)
                                        .then((_) => Flushbar(
                                              duration: Duration(seconds: 4),
                                              flushbarPosition:
                                                  FlushbarPosition.TOP,
                                              backgroundColor:
                                                  Color(0xFF3E9D9D),
                                              message:
                                                  'Pesan reset password telah dikirim',
                                            )..show(context));
                                  }  catch (e) {
                                    Flushbar(
                                      duration: Duration(seconds: 4),
                                      flushbarPosition: FlushbarPosition.TOP,
                                      backgroundColor: Color(0xFFFF5C83),
                                      message: e.toString(),
                                    )..show(context);
                                  }
                                } else {
                                  Flushbar(
                                    duration: Duration(seconds: 4),
                                    flushbarPosition: FlushbarPosition.TOP,
                                    backgroundColor: Color(0xFFFF5C83),
                                    message: 'Email tidak valid',
                                  )..show(context);
                                }
                              },
                              child: Text(
                                "Dapatkan Sekarang",
                                style: blackTextFont.copyWith(
                                    color: primaryColor,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        ),
                        Center(
                          child: Container(
                            margin: EdgeInsets.only(top: 40, bottom: 40),
                            child: isSigningIn
                                ? SpinKitCircle(
                                    color: primaryColor,
                                  )
                                : FloatingActionButton(
                                    elevation: 0,
                                    onPressed: isEmailValid && isPasswordValid
                                        ? () async {
                                            setState(() {
                                              isSigningIn = true;
                                            });

                                            SignInSignUpResult result =
                                                await AuthServices.signIn(
                                                    emailController.text,
                                                    passwordController.text);
                                            if (result.user == null) {
                                              setState(() {
                                                isSigningIn = false;
                                              });

                                              Flushbar(
                                                duration: Duration(seconds: 4),
                                                flushbarPosition:
                                                    FlushbarPosition.TOP,
                                                backgroundColor:
                                                    Color(0xFFFF5C83),
                                                message: result.message,
                                              )..show(context);
                                            }
                                          }
                                        : null,
                                    backgroundColor:
                                        isEmailValid && isPasswordValid
                                            ? primaryColor
                                            : Color(0xFFE4E4E4),
                                    child: Icon(
                                      Icons.arrow_forward,
                                      color: isEmailValid && isPasswordValid
                                          ? Colors.white
                                          : Color(0xFFBEBEBE),
                                    ),
                                  ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Belum mempunyai akun? ",
                              style: blackTextFont.copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey),
                            ),
                            GestureDetector(
                              onTap: () {
                                context.bloc<PageBloc>().add(
                                    GoToChooseRolePage(RegistrationData()));
                              },
                              child: Text(
                                "Daftar Sekarang",
                                style: blackTextFont.copyWith(
                                    color: primaryColor,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 50,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
