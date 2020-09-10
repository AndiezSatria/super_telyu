part of 'submission_bloc.dart';

abstract class SubmissionEvent extends Equatable {
  const SubmissionEvent();
}

class EnterSubmission extends SubmissionEvent {
  final String userId;
  final Submission submission;

  EnterSubmission(this.submission, this.userId);

  @override
  List<Object> get props => [userId, submission];
}

class UploadSurat extends SubmissionEvent {
  final Submission submission;

  UploadSurat(this.submission);
  @override
  List<Object> get props => [submission];
}
