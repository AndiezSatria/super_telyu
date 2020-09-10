part of 'pages.dart';

class PdfViewPage extends StatefulWidget {
  final String path;
  final PageEvent pageEvent;

  const PdfViewPage({Key key, this.path,this.pageEvent})
      : super(key: key);
  @override
  _PdfViewPageState createState() => _PdfViewPageState();
}

class _PdfViewPageState extends State<PdfViewPage> {
  int _totalPages = 0;
  int _currentPage = 0;
  bool pdfReady = false;
  PDFViewController _pdfViewController;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        context.bloc<PageBloc>().add(widget.pageEvent);
        return;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('PDF View'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              context.bloc<PageBloc>().add(widget.pageEvent);
            },
          ),
        ),
        body: Stack(
          children: <Widget>[
            PDFView(
              filePath: widget.path,
              autoSpacing: true,
              enableSwipe: true,
              pageSnap: true,
              swipeHorizontal: true,
              nightMode: false,
              onError: (e) {
                print(e);
              },
              onRender: (_pages) {
                setState(() {
                  _totalPages = _pages;
                  pdfReady = true;
                });
              },
              onViewCreated: (PDFViewController vc) {
                _pdfViewController = vc;
              },
              onPageChanged: (int page, int total) {
                setState(() {
                  _currentPage = page;
                });
              },
              onPageError: (page, e) {},
            ),
            !pdfReady
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Offstage()
          ],
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FloatingActionButton(
              backgroundColor: primaryColor,
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: _currentPage > 0
                  ? () {
                      _currentPage -= 1;
                      _pdfViewController.setPage(_currentPage);
                    }
                  : null,
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              'Page ${_currentPage + 1}',
              style: blackTextFont.copyWith(fontSize: 16),
            ),
            SizedBox(
              width: 8,
            ),
            FloatingActionButton(
              backgroundColor: Colors.green,
              child: Icon(
                Icons.arrow_forward,
                color: Colors.white,
              ),
              onPressed: _currentPage + 1 < _totalPages
                  ? () {
                      _currentPage += 1;
                      _pdfViewController.setPage(_currentPage);
                    }
                  : null,
            )
          ],
        ),
      ),
    );
  }
}
