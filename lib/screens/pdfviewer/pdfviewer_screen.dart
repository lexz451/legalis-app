import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:legalis/di.dart';
import 'package:legalis/services/api_service.dart';
import 'package:legalis/theme.dart';
import 'package:routemaster/routemaster.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewerScreen extends StatefulWidget {
  const PdfViewerScreen({Key? key, required this.file, required this.startpage})
      : super(key: key);

  final String file;
  final int startpage;

  @override
  _PdfViewerScreenState createState() => _PdfViewerScreenState();
}

class _PdfViewerScreenState extends State<PdfViewerScreen> {
  final apiService = getIt<APIService>();

  String get file => widget.file;
  final PdfViewerController _controller = PdfViewerController();

  @override
  void initState() {
    super.initState();
    _controller.jumpToPage(widget.startpage);
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
            child: SfPdfViewer.network(
              "https://api-gaceta.datalis.dev/files/$file",
              controller: _controller,
            ),
          )),
    );
  }
}
