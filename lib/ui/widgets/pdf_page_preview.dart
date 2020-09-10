part of 'widgets.dart';

class PdfPagePreview extends StatefulWidget {
  final String imgPath;
  final bool isDeletable;
  final Function onDeleteFile;
  PdfPagePreview({@required this.imgPath, this.isDeletable, this.onDeleteFile});
  _PdfPagePreviewState createState() => new _PdfPagePreviewState();
}

class _PdfPagePreviewState extends State<PdfPagePreview> {
  bool imgReady = false;
  ImageProvider provider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadPreview(needsRepaint: true);
  }

  @override
  void didUpdateWidget(PdfPagePreview oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.imgPath != widget.imgPath) {
      _loadPreview(needsRepaint: true);
    }
  }

  void _loadPreview({@required bool needsRepaint}) {
    if (needsRepaint) {
      imgReady = false;
      provider = FileImage(File(widget.imgPath));
      final resolver = provider.resolve(createLocalImageConfiguration(context));
      resolver.addListener(ImageStreamListener((imgInfo, alreadyPainted) {
        imgReady = true;
        if (!alreadyPainted) setState(() {});
      }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: imgReady
          ? Stack(
              children: [
                if (widget.isDeletable)
                  GestureDetector(
                    onTap: widget.onDeleteFile,
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        width: 30,
                        height: 30,
                        margin: const EdgeInsets.all(10),
                        child: Image.asset('assets/images/btn_del_photo.png'),
                      ),
                    ),
                  ),
                Center(
                  child: Image(
                    image: provider,
                  ),
                ),
              ],
            )
          : CircularProgressIndicator(
              strokeWidth: 2.0,
              value: null,
              valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
            ),
    );
  }
}
