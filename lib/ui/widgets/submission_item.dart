part of 'widgets.dart';

class SubmissionItem extends StatefulWidget {
  final Submission submission;
  final Function onTap;
  SubmissionItem(this.submission, this.onTap);
  @override
  _SubmissionItemState createState() => _SubmissionItemState();
}

class _SubmissionItemState extends State<SubmissionItem>
    with AutomaticKeepAliveClientMixin<SubmissionItem> {
  Color _bgColor;
  @override
  void initState() {
    const availableColor = [
      Color(0xFFff4b5c),
      Color(0xFFec0101),
      Color(0xFFff7171),
      Color(0xFFdd2c00),
      Color(0xFF810000),
    ];
    _bgColor = availableColor[Random().nextInt(availableColor.length)];
    super.initState();
  }

  @mustCallSuper
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GestureDetector(
      onTap: widget.onTap,
      child: Card(
        elevation: 2,
        margin: EdgeInsets.fromLTRB(5, 10, 5, 0),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: _bgColor,
            radius: 30,
            child: Padding(
              padding: EdgeInsets.all(6.0),
              child: FittedBox(
                child: Text(
                  '${widget.submission.personal.name.substring(0, 2)}',
                  style: whiteTextFont,
                ),
              ),
            ),
          ),
          title: Text(
            '${widget.submission.personal.name}',
            style: blackTextFont,
          ),
          subtitle: Text(DateFormat.yMMMd().format(widget.submission.time)),
          trailing: Container(
            width: 35,
            height: 35,
            child: Icon(
              widget.submission.isVerifying
                  ? MdiIcons.progressCheck
                  : widget.submission.isRejected
                      ? Icons.error
                      : widget.submission.isProcessing
                          ? MdiIcons.progressDownload
                          : Icons.check,
              color: Colors.white,
            ),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: widget.submission.isVerifying
                  ? Colors.lightBlue
                  : widget.submission.isRejected
                      ? Colors.red
                      : widget.submission.isProcessing
                          ? Colors.yellow
                          : Color(0xFF3E9D9D),
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
