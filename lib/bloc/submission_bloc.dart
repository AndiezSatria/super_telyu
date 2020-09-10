import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:super_telyu/models/models.dart';
import 'package:super_telyu/services/services.dart';
import 'package:super_telyu/shared/shared.dart';

part 'submission_event.dart';
part 'submission_state.dart';

class SubmissionBloc extends Bloc<SubmissionEvent, SubmissionState> {
  SubmissionBloc() : super(SubmissionState());

  @override
  Stream<SubmissionState> mapEventToState(
    SubmissionEvent event,
  ) async* {
    if (event is EnterSubmission) {
      var id = await SubmissionServices.saveSubmission(
        event.userId,
        event.submission,
      );
      await SubmissionServices.updateSubmission(
        event.submission,
        id,
        nilaiUrl: await uploadFile(event.submission.transkripNilai,
            name: addFileName(event.submission.transkripNilaiFileName)),
        ksmUrl: await uploadFile(event.submission.ksm,
            name: addFileName(event.submission.ksmFileName)),
      );

      yield SubmissionState();
    } else if (event is UploadSurat) {
      await SubmissionServices.updateSubmission(
        event.submission,
        event.submission.submissionId,
        suratUrl: await uploadFile(event.submission.surat,
            name: addFileName(event.submission.suratFileName)),
      );
      yield SubmissionState();
    }
  }
}
