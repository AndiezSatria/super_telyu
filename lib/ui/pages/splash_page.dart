part of 'pages.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: primaryColor,
        ),
        SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            body: Container(
              padding: EdgeInsets.all(defaultMargin),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 200,
                    height: 200,
                    child: Image.asset(
                      'assets/images/telu.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 16, bottom: 30),
                    width: double.infinity,
                    child: Text(
                      'Super Telyu',
                      style: blackTextFont.copyWith(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: Text(
                      'Membuat Surat Pengantar\nMenjadi Lebih Tenang',
                      style: blackTextFont.copyWith(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    width: 250,
                    height: 46,
                    decoration: BoxDecoration(),
                    margin: EdgeInsets.only(top: 70, bottom: 16),
                    child: RaisedButton(
                      child: Text(
                        "Mulai",
                        style: whiteTextFont.copyWith(fontSize: 16),
                      ),
                      color: Theme.of(context).primaryColor,
                      onPressed: () {
                        context
                            .bloc<PageBloc>()
                            .add(GoToChooseRolePage(RegistrationData()));
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Sudah punya akun? ",
                        style: blackTextFont.copyWith(
                            color: Colors.grey, fontWeight: FontWeight.w400),
                      ),
                      GestureDetector(
                        onTap: () {
                          context.bloc<PageBloc>().add(GoToLoginPage());
                        },
                        child: Text(
                          "Masuk",
                          style: blackTextFont.copyWith(color: primaryColor),
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
