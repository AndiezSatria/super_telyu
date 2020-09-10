part of 'pages.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  VerifyData verifyData;

  Widget generateSubmissionPage(
    BuildContext context, {
    String userId,
    bool isVerifiying = false,
    bool isDone = false,
    bool isRejected = false,
    bool isProcessing = false,
  }) {
    return FutureBuilder(
      future: SubmissionServices.getSubmission(
        userId: userId,
      ),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return SubmissionsPage(
            snapshot.data,
            isVerifying: isVerifiying,
            verifyData: verifyData,
            isDone: isDone,
            isRejected: isRejected,
            isProcessing: isProcessing,
          );
        } else {
          return Center(
            child: SpinKitFadingCircle(
              size: 50,
              color: primaryColor,
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        drawer: MainDrawer(),
        appBar: AppBar(
          elevation: 0,
          actions: [
            IconButton(
                icon: Icon(Icons.ac_unit, color: primaryColor),
                onPressed: null,
                color: primaryColor),
          ],
          title: Center(child: Text("Super Telyu")),
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(
                  Icons.verified_user,
                ),
                text: 'Verifikasi',
              ),
              Tab(
                icon: Icon(
                  MdiIcons.progressUpload,
                ),
                text: 'Proses',
              ),
              Tab(
                icon: Icon(
                  Icons.done,
                ),
                text: 'Selesai',
              ),
            ],
          ),
        ),
        body: BlocBuilder<UserBloc, UserState>(builder: (_, state) {
          if (state is UserLoaded) {
            if (state.user.role != Role.Mahasiswa) {
              verifyData = VerifyData(user: state.user);
            }
            if (imageFileToUpload != null) {
              uploadFile(imageFileToUpload).then((downloadUrl) {
                imageFileToUpload = null;
                context
                    .bloc<UserBloc>()
                    .add(UpdateData(profileImage: downloadUrl));
              });
            }
            return TabBarView(
              children: [
                generateSubmissionPage(
                  context,
                  userId:
                      state.user.role == Role.Mahasiswa ? state.user.id : null,
                  isVerifiying: true,
                ),
                generateSubmissionPage(
                  context,
                  userId:
                      state.user.role == Role.Mahasiswa ? state.user.id : null,
                  isProcessing: true,
                ),
                generateSubmissionPage(
                  context,
                  userId:
                      state.user.role == Role.Mahasiswa ? state.user.id : null,
                  isDone: true,
                  isRejected: true,
                ),
              ],
            );
          } else {
            return Center(
              child: SpinKitFadingCircle(
                size: 50,
                color: primaryColor,
              ),
            );
          }
        }),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserLoaded) {
              if (state.user.role == Role.Mahasiswa) {
                return FloatingActionButton(
                  elevation: 5,
                  backgroundColor: primaryColor,
                  splashColor: accentColor1,
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    context
                        .bloc<PageBloc>()
                        .add(GoToPersonalDataPage(SubmissionData(
                          userId: state.user.id,
                          id: randomAlphaNumeric(8),
                          personalData: PersonalData(
                            randomAlphaNumeric(8),
                            state.user.name,
                            state.user.nomorInduk,
                            state.user.email,
                            '',
                            '',
                            0,
                            0,
                            0.0,
                          ),
                        )));
                  },
                );
              } else {
                return SizedBox();
              }
            } else {
              return SizedBox();
            }
          },
        ),
      ),
    );
  }
}
