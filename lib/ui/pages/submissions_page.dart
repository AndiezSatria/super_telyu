part of 'pages.dart';

class SubmissionsPage extends StatefulWidget {
  final List<Submission> submissions;
  final VerifyData verifyData;
  final bool isVerifying;
  final bool isDone;
  final bool isRejected;
  final bool isProcessing;

  SubmissionsPage(
    this.submissions, {
    this.isVerifying = false,
    this.isDone = false,
    this.isRejected = false,
    this.isProcessing = false,
    this.verifyData,
  });
  @override
  _SubmissionsPageState createState() => _SubmissionsPageState();
}

class _SubmissionsPageState extends State<SubmissionsPage> {
  @override
  Widget build(BuildContext context) {
    List<Submission> submissions = widget.isVerifying
        ? widget.submissions
            .where((element) => element.isVerifying == widget.isVerifying)
            .toList()
        : widget.isDone || widget.isRejected
            ? widget.submissions
                .where((element) =>
                    element.isDone == widget.isDone ||
                    element.isRejected == widget.isRejected)
                .toList()
            : widget.isProcessing
                ? widget.submissions
                    .where((element) =>
                        element.isProcessing == widget.isProcessing)
                    .toList()
                : [];
    return submissions.isEmpty
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 150,
                  width: 150,
                  margin: EdgeInsets.only(bottom: 15),
                  child: Image.asset(
                    'assets/images/no_data.png',
                    fit: BoxFit.cover,
                  ),
                ),
                Text(
                  'Tidak ada data',
                  style: blackTextFont.copyWith(fontSize: 20),
                ),
              ],
            ),
          )
        : ListView(
            children: submissions.map((submission) {
              return SubmissionItem(submission, () {
                context.bloc<PageBloc>().add(GoToSubmissionDetailPage(
                    submission,
                    verifyData: widget.verifyData));
              });
            }).toList(),
          );
  }
}
