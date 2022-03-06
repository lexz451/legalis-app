import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:legalis/theme.dart';
import 'package:routemaster/routemaster.dart';

class PdfViewerScreen extends StatefulWidget {
  const PdfViewerScreen({Key? key, required this.file}) : super(key: key);

  final String file;

  @override
  _PdfViewerScreenState createState() => _PdfViewerScreenState();
}

class _PdfViewerScreenState extends State<PdfViewerScreen> {
  String get file => widget.file;

  Future<PDFDocument> get document async =>
      PDFDocument.fromURL("https://api-gaceta.datalis.dev/files/$file");

  @override
  void initState() {
    super.initState();
    //viewModel.loadDocument(file);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: CupertinoPageScaffold(
        backgroundColor: AppTheme.backgroundColor,
        navigationBar: CupertinoNavigationBar(
          border: null,
          backgroundColor: Colors.white.withOpacity(.75),
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
        child: Container(
          margin: const EdgeInsets.only(top: 68),
          child: FutureBuilder(
            future: document,
            builder: (context, asyncState) {
              if (asyncState.connectionState == ConnectionState.waiting) {
                return const Center(
                    child: SizedBox(
                  height: 24,
                  width: 24,
                  child: CircularProgressIndicator(strokeWidth: 4.0),
                ));
              }
              final _doc = asyncState.data as PDFDocument;
              return PDFViewer(
                document: _doc,
                showPicker: false,
                progressIndicator: const SizedBox(
                  height: 24,
                  width: 24,
                  child: CircularProgressIndicator(strokeWidth: 4.0),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
