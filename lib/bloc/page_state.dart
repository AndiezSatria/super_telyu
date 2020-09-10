part of 'page_bloc.dart';

abstract class PageState extends Equatable {
  const PageState();
}

class OnInitialPage extends PageState {
  @override
  List<Object> get props => [];
}

class OnMainPage extends PageState {
  @override
  List<Object> get props => [];
}

class OnSplashPage extends PageState {
  @override
  List<Object> get props => [];
}

class OnLoginPage extends PageState {
  @override
  List<Object> get props => [];
}

class OnChooseRolePage extends PageState {
  final RegistrationData registrationData;
  OnChooseRolePage(this.registrationData);
  @override
  List<Object> get props => [registrationData];
}

class OnRegistrationPage extends PageState {
  final RegistrationData registrationData;
  OnRegistrationPage(this.registrationData);
  @override
  List<Object> get props => [registrationData];
}

class OnAccountConfirmationPage extends PageState {
  final RegistrationData registrationData;
  OnAccountConfirmationPage(this.registrationData);
  @override
  List<Object> get props => [registrationData];
}

class OnPersonalDataPage extends PageState {
  final SubmissionData submissionData;
  OnPersonalDataPage(this.submissionData);
  @override
  List<Object> get props => [submissionData];
}

class OnCompanyDataPage extends PageState {
  final SubmissionData submissionData;
  OnCompanyDataPage(this.submissionData);
  @override
  List<Object> get props => [submissionData];
}

class OnUploadedFilePage extends PageState {
  final SubmissionData submissionData;
  final PageEvent pageEvent;
  OnUploadedFilePage(this.submissionData, this.pageEvent);
  @override
  List<Object> get props => [submissionData, pageEvent];
}

class OnPdfViewPage extends PageState {
  final String filePath;
  final PageEvent pageEvent;
  OnPdfViewPage(this.filePath, this.pageEvent);
  @override
  List<Object> get props => [filePath, pageEvent];
}

class OnSuccessPage extends PageState {
  final SubmissionData submissionData;
  final PageEvent pageEvent;
  final Submission submission;
  final VerifyData verifyData;
  OnSuccessPage(this.pageEvent,
      {this.submissionData, this.verifyData, this.submission});
  @override
  List<Object> get props =>
      [this.pageEvent, this.submissionData, this.verifyData, this.submission];
}

class OnSubmissionDetailPage extends PageState {
  final Submission submission;
  final VerifyData verifyData;
  OnSubmissionDetailPage(this.submission, {this.verifyData});
  @override
  List<Object> get props => [this.submission, this.verifyData];
}

class OnHelpPage extends PageState {
  @override
  List<Object> get props => [];
}

class OnDispenDataPage extends PageState {
  final SubmissionData submissionData;
  OnDispenDataPage(this.submissionData);
  @override
  List<Object> get props => [submissionData];
}