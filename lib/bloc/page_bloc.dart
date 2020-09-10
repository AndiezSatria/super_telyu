import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:super_telyu/models/models.dart';

part 'page_event.dart';
part 'page_state.dart';

class PageBloc extends Bloc<PageEvent, PageState> {
  PageBloc() : super(OnInitialPage());

  @override
  Stream<PageState> mapEventToState(
    PageEvent event,
  ) async* {
    if (event is GoToMainPage) {
      yield OnMainPage();
    } else if (event is GoToSplashPage) {
      yield OnSplashPage();
    } else if (event is GoToLoginPage) {
      yield OnLoginPage();
    } else if (event is GoToChooseRolePage) {
      yield OnChooseRolePage(event.registrationData);
    } else if (event is GoToRegistrationPage) {
      yield OnRegistrationPage(event.registrationData);
    } else if (event is GoToAccountConfirmationPage) {
      yield OnAccountConfirmationPage(event.registrationData);
    } else if (event is GoToPersonalDataPage) {
      yield OnPersonalDataPage(event.submissionData);
    } else if (event is GoToCompanyDataPage) {
      yield OnCompanyDataPage(event.submissionData);
    } else if (event is GoToUploadedFilePage) {
      yield OnUploadedFilePage(event.submissionData, event.pageEvent);
    } else if (event is GoToPdfViewPage) {
      yield OnPdfViewPage(event.filePath, event.pageEvent);
    } else if (event is GoToSuccessPage) {
      yield OnSuccessPage(event.pageEvent,
          submissionData: event.submissionData,
          submission: event.submission,
          verifyData: event.verifyData);
    } else if (event is GoToSubmissionDetailPage) {
      yield OnSubmissionDetailPage(event.submission,
          verifyData: event.verifyData);
    } else if (event is GoToHelpPage) {
      yield OnHelpPage();
    } else if (event is GoToDispenDataPage) {
      yield OnDispenDataPage(event.submissionData);
    }
  }
}
