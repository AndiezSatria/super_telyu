part of 'pages.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FirebaseUser firebaseUser = Provider.of<FirebaseUser>(context);
    if (firebaseUser == null) {
      if (!(prevPageEvent is GoToSplashPage)) {
        prevPageEvent = GoToSplashPage();
        context.bloc<PageBloc>().add(prevPageEvent);
      }
    } else {
      if (!(prevPageEvent is GoToMainPage)) {
        context.bloc<UserBloc>().add(LoadUser(firebaseUser.uid));
        // context.bloc<SubmissionBloc>().add(GetSubmission(
        //       userId: firebaseUser.uid,
        //     ));
        prevPageEvent = GoToMainPage();
        context.bloc<PageBloc>().add(prevPageEvent);
      }
    }
    return BlocBuilder<PageBloc, PageState>(
        builder: (context, state) => (state is OnSplashPage)
            ? SplashPage()
            : (state is OnLoginPage)
                ? LoginPage()
                : (state is OnChooseRolePage)
                    ? ChooseRolePage(state.registrationData)
                    : (state is OnRegistrationPage)
                        ? RegistrationPage(state.registrationData)
                        : (state is OnAccountConfirmationPage)
                            ? AccountConfirmationPage(state.registrationData)
                            : (state is OnPersonalDataPage)
                                ? PersonalDataPage(state.submissionData)
                                : (state is OnCompanyDataPage)
                                    ? CompanyDataPage(state.submissionData)
                                    : (state is OnUploadedFilePage)
                                        ? UploadedFilePage(state.submissionData,
                                            state.pageEvent)
                                        : (state is OnPdfViewPage)
                                            ? PdfViewPage(
                                                path: state.filePath,
                                                pageEvent: state.pageEvent,
                                              )
                                            : (state is OnSuccessPage)
                                                ? SuccessPage(
                                                    state.pageEvent,
                                                    submissionData:
                                                        state.submissionData,
                                                    submission:
                                                        state.submission,
                                                    verifyData:
                                                        state.verifyData,
                                                  )
                                                : (state
                                                        is OnSubmissionDetailPage)
                                                    ? SubmissionDetailPage(
                                                        state.submission,
                                                        verifyData:
                                                            state.verifyData,
                                                      )
                                                    : (state is OnHelpPage)
                                                        ? HelpPage()
                                                        : (state
                                                                is OnDispenDataPage)
                                                            ? DispenDataPage(state
                                                                .submissionData)
                                                            : MainPage());
  }
}
