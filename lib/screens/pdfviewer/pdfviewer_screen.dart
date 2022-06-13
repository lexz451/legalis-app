import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:legalis/di.dart';
import 'package:legalis/main.dart';
import 'package:legalis/repositories/download_repository.dart';
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
  // ignore: library_private_types_in_public_api
  _PdfViewerScreenState createState() => _PdfViewerScreenState();
}

class _PdfViewerScreenState extends State<PdfViewerScreen> {
  final apiService = getIt<APIService>();
  final downloadRepository = getIt<DownloadRepository>();

  String get fileId => widget.file;
  String get fileUrl => "https://api-gaceta.datalis.dev/files/$fileId";
  Future<File?> get file => downloadRepository.getDownloadedFile(fileId);

  final PdfViewerController _controller = PdfViewerController();

  @override
  void initState() {
    super.initState();
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
              child: FutureBuilder<File?>(
            future: file,
            builder: (context, snapshot) {
              LOGGER.d("Loading pdf file");
              if (snapshot.hasData) {
                final file = snapshot.data;
                if (file != null) {
                  LOGGER.d("Pdf file loaded from downloads");
                  return SfPdfViewer.file(
                    file,
                    controller: _controller,
                  );
                } else {
                  LOGGER.d(
                      "Pdf file not found in downloads, fetching from network");
                  return SfPdfViewer.network(
                    fileUrl,
                    controller: _controller,
                  );
                }
              }
              return const SizedBox();
            },
          ))),
    );
  }
}
