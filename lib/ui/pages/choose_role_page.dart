part of 'pages.dart';

class ChooseRolePage extends StatefulWidget {
  final List<String> listJob = const [
    'Mahasiswa',
    'Dosen Wali',
    'Kemahasiswaan'
  ];
  final RegistrationData registrationData;

  ChooseRolePage(this.registrationData);

  @override
  _ChooseRolePageState createState() => _ChooseRolePageState();
}

class _ChooseRolePageState extends State<ChooseRolePage> {
  String selectedRole;

  List<Widget> generateRoleWidgets(BuildContext ctx) {
    double width = (MediaQuery.of(ctx).size.width - 2 * defaultMargin - 24) / 2;
    return widget.listJob
        .map((item) => SelectableBox(
              item,
              width: width,
              isSelected: item == selectedRole,
              onTap: () {
                if (selectedRole == item) {
                  setState(() {
                    selectedRole = null;
                  });
                } else {
                  setState(() {
                    selectedRole = item;
                  });
                }
              },
            ))
        .toList();
  }

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
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
                child: ListView(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 36,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: GestureDetector(
                            onTap: () {
                              context.bloc<PageBloc>().add(GoToSplashPage());
                            },
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        Center(
                          child: Container(
                            width: double.infinity,
                            height: 250,
                            child: Image.asset(
                              'assets/images/role_job.png',
                              // fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Pilih Salah Satu\nPekerjaanmu',
                          style: blackTextFont.copyWith(fontSize: 20),
                        ),
                        SizedBox(height: 16),
                        Wrap(
                          spacing: 24,
                          runSpacing: 24,
                          children: generateRoleWidgets(context),
                        ),
                        SizedBox(height: 30),
                        Center(
                          child: FloatingActionButton(
                            onPressed: () {
                              if (selectedRole == null) {
                                Flushbar(
                                  backgroundColor: Color(0xFFFF5C83),
                                  duration: Duration(milliseconds: 1500),
                                  flushbarPosition: FlushbarPosition.TOP,
                                  message: "Pilih salah satu pekerjaan",
                                )..show(context);
                              } else {
                                Role role;
                                for (int i = 0;
                                    i < widget.listJob.length;
                                    i++) {
                                  if (selectedRole == widget.listJob[i]) {
                                    switch (i) {
                                      case 0:
                                        role = Role.Mahasiswa;
                                        break;
                                      case 1:
                                        role = Role.DosenWali;
                                        break;
                                      case 2:
                                        role = Role.Kemahasiswaan;
                                        break;
                                    }
                                  }
                                }
                                widget.registrationData.role = role;
                                context.bloc<PageBloc>().add(
                                    GoToRegistrationPage(
                                        widget.registrationData));
                              }
                            },
                            elevation: 0,
                            backgroundColor: primaryColor,
                            child: Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(height: 50)
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
