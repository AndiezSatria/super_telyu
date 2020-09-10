part of 'pages.dart';

class HelpPage extends StatefulWidget {
  @override
  _HelpPageState createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  Widget generateInformationHelp(
    String number,
    String text,
  ) {
    return Container(
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          FittedBox(
            child: Text(
              number,
              style: whiteNumberFont.copyWith(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
          ),
          SizedBox(
            width: 8,
          ),
          Expanded(
            child: Text(
              text,
              style: blackTextFont.copyWith(
                fontSize: 16,
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int _num = 0;
    return WillPopScope(
      onWillPop: () {
        context.bloc<PageBloc>().add(GoToMainPage());
        return;
      },
      child: Scaffold(
        backgroundColor: primaryColor,
        drawer: MainDrawer(),
        appBar: AppBar(
          elevation: 0,
          actions: [
            IconButton(
                icon: Icon(Icons.ac_unit, color: primaryColor),
                onPressed: null,
                color: primaryColor),
          ],
          title: Center(child: Text('Pusat Bantuan')),
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
          child: ListView(
            children: [
              Column(
                children: [
                  SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    height: 200,
                    child: Image.asset('assets/images/help.png'),
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    child: Text(
                      'Bantuan',
                      style: blackTextFont.copyWith(fontSize: 24),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    child: Text(
                      'Pembuatan Pengajuan Baru',
                      style: blackTextFont.copyWith(
                          fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                  ...helpData
                      .map((helpText) =>
                          generateInformationHelp('${++_num}', helpText))
                      .toList(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
