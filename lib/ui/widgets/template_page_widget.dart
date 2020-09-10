part of 'widgets.dart';

class TemplatePageWidget extends StatefulWidget {
  final double width;
  final double height;
  final bool isLoading;
  final String previewPath;
  final Function onPickFile;
  final bool isDeletable;
  final Function onDeleteFile;
  final bool isEditable;

  TemplatePageWidget(
      {@required this.width,
      @required this.height,
      this.isLoading,
      this.previewPath,
      this.isDeletable = false,
      this.onDeleteFile,
      this.isEditable = false,
      this.onPickFile})
      : assert(width > 0.0 && height > 0.0);
  TemplatePageState createState() => TemplatePageState();
}

class TemplatePageState extends State<TemplatePageWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPickFile ?? () {},
      child: Container(
        child: Center(
          child: widget.previewPath != null
              ? PdfPagePreview(
                  imgPath: widget.previewPath,
                  isDeletable: widget.isDeletable,
                  onDeleteFile: widget.onDeleteFile,
                )
              : widget.isLoading
                  ? CircularProgressIndicator(
                      strokeWidth: 2.0,
                      value: null,
                      valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                    )
                  : Stack(
                      children: [
                        Container(
                          width: widget.width,
                          height: widget.height,
                          child: DottedBorder(
                            strokeCap: StrokeCap.round,
                            dashPattern: [5, 5],
                            borderType: BorderType.RRect,
                            radius: Radius.circular(12),
                            color: Colors.black,
                            child: SizedBox(),
                          ),
                        ),
                        Container(
                          width: widget.width,
                          height: widget.height,
                          child: widget.isEditable
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 80,
                                      height: 80,
                                      margin: const EdgeInsets.only(bottom: 8),
                                      child: Image.asset(
                                        'assets/images/add_file.png',
                                      ),
                                    ),
                                    Text(
                                      'Pilih File',
                                      style:
                                          blackTextFont.copyWith(fontSize: 16),
                                    )
                                  ],
                                )
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 70,
                                      height: 70,
                                      margin: const EdgeInsets.only(bottom: 8),
                                      child: Image.asset(
                                        'assets/images/no_preview.png',
                                      ),
                                    ),
                                    Text(
                                      'Tidak ada preview',
                                      style:
                                          blackTextFont.copyWith(fontSize: 16),
                                    )
                                  ],
                                ),
                        )
                      ],
                    ),
        ),
        height: widget.height,
        width: widget.width,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                spreadRadius: 1.0, color: Color(0xffebebeb), blurRadius: 3.0),
          ],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            width: 1.0,
            color: Color(0xffebebeb),
          ),
          shape: BoxShape.rectangle,
        ),
      ),
    );
  }
}
