part of 'page_bloc.dart';

abstract class PageEvent extends Equatable {
  const PageEvent();
}

class GoToMainPage extends PageEvent {
  @override
  List<Object> get props => [];
}

class GoToSplashPage extends PageEvent {
  @override
  List<Object> get props => [];
}

class GoToLoginPage extends PageEvent {
  @override
  List<Object> get props => [];
}

class GoToChooseRolePage extends PageEvent {
  final RegistrationData registrationData;
  GoToChooseRolePage(this.registrationData);
  @override
  List<Object> get props => [registrationData];
}

class GoToRegistrationPage extends PageEvent {
  final RegistrationData registrationData;
  GoToRegistrationPage(this.registrationData);
  @override
  List<Object> get props => [registrationData];
}

class GoToAccountConfirmationPage extends PageEvent {
  final RegistrationData registrationData;
  GoToAccountConfirmationPage(this.registrationData);
  @override
  List<Object> get props => [registrationData];
}

class GoToPersonalDataPage extends PageEvent {
  final SubmissionData submissionData;
  GoToPersonalDataPage(this.submissionData);
  @override
  List<Object> get props => [submissionData];
}

class GoToCompanyDataPage extends PageEvent {
  final SubmissionData submissionData;
  GoToCompanyDataPage(this.submissionData);
  @override
  List<Object> get props => [submissionData];
}

class GoToUploadedFilePage extends PageEvent {
  final SubmissionData submissionData;
  final PageEvent pageEvent;
  GoToUploadedFilePage(this.submissionData, this.pageEvent);
  @override
  List<Object> get props => [submissionData, pageEvent];
}

class GoToPdfViewPage extends PageEvent {
  final String filePath;
  final PageEvent pageEvent;
  GoToPdfViewPage(this.filePath, this.pageEvent);
  @override
  List<Object> get props => [filePath, pageEvent];
}

class GoToSuccessPage extends PageEvent {
  final SubmissionData submissionData;
  final PageEvent pageEvent;
  final Submission submission;
  final VerifyData verifyData;
  GoToSuccessPage(this.pageEvent,
      {this.submissionData, this.verifyData, this.submission});
  @override
  List<Object> get props =>
      [this.pageEvent, this.submissionData, this.verifyData, this.submission];
}

class GoToSubmissionDetailPage extends PageEvent {
  final Submission submission;
  final VerifyData verifyData;
  GoToSubmissionDetailPage(this.submission, {this.verifyData});
  @override
  List<Object> get props => [this.submission, this.verifyData];
}

class GoToHelpPage extends PageEvent {
  @override
  List<Object> get props => [];
}

class GoToDispenDataPage extends PageEvent {
  final SubmissionData submissionData;
  GoToDispenDataPage(this.submissionData);
  @override
  List<Object> get props => [submissionData];
}
