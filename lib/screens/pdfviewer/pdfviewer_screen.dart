import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:legalis/di.dart';
import 'package:legalis/main.dart';
import 'package:legalis/services/api_service.dart';
import 'package:legalis/theme.dart';
import 'package:legalis/widget/action_icon.dart';
import 'package:routemaster/routemaster.dart';

class PdfViewerScreen extends StatefulWidget {
  const PdfViewerScreen({Key? key, required this.file}) : super(key: key);

  final String file;

  @override
  _PdfViewerScreenState createState() => _PdfViewerScreenState();
}

class _PdfViewerScreenState extends State<PdfViewerScreen> {
  final apiService = getIt<APIService>();

  String get file => widget.file;

  PDFDocument? _document;
  bool _isLoading = true;

  loadDocument() async {
    _isLoading = true;
    _document = await PDFDocument.fromURL(
        "https://api-gaceta.datalis.dev/files/$file",
        cacheManager: CacheManager(Config('pdfViewer',
            stalePeriod: const Duration(days: 2), maxNrOfCacheObjects: 5)));
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    loadDocument();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: CupertinoPageScaffold(
          backgroundColor: AppTheme.backgroundColor,
          navigationBar: CupertinoNavigationBar(
            border: null,
            backgroundColor: Colors.white.withOpacity(.25),
            leading: InkWell(
              onTap: () {
                Routemaster.of(context).pop();
              },
              borderRadius: BorderRadius.circular(360),
              child: Icon(
                Icons.arrow_back_rounded,
                size: 28,
                color: AppTheme.primary,
              ),
            ),
          ),
          child: SafeArea(
            child: Container(
              constraints: const BoxConstraints.expand(),
              child: _isLoading
                  ? const SizedBox()
                  : PDFViewer(
                      document: _document!,
                      showPicker: false,
                      navigationBuilder: (context, page, totalPages, jumpToPage,
                          animateToPage) {
                        return Card(
                          elevation: 0,
                          clipBehavior: Clip.antiAlias,
                          margin: const EdgeInsets.all(8),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ActionIcon(
                                  icon: CupertinoIcons.chevron_left_2,
                                  onClick: () => jumpToPage(page: 0),
                                ),
                                if (page != null)
                                  ActionIcon(
                                    icon: CupertinoIcons.chevron_left,
                                    onClick: () => jumpToPage(page: page - 2),
                                  ),
                                if (page != null)
                                  ActionIcon(
                                    icon: CupertinoIcons.chevron_right,
                                    onClick: () => jumpToPage(page: page),
                                  ),
                                if (totalPages != null)
                                  ActionIcon(
                                    icon: CupertinoIcons.chevron_right_2,
                                    onClick: () =>
                                        jumpToPage(page: totalPages - 1),
                                  )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          )),
    );
  }
}
