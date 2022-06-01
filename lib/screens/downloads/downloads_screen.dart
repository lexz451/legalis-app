import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:legalis/model/resource.dart';
import 'package:legalis/screens/app_viewmodel.dart';
import 'package:legalis/screens/downloads/downloads_viewmodel.dart';
import 'package:legalis/theme.dart';
import 'package:legalis/widget/action_icon.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:routemaster/routemaster.dart';

class DownloadsScreen extends StatefulWidget {
  const DownloadsScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DownloadsScreenState();
}

class _DownloadsScreenState extends State<DownloadsScreen> {
  _getFileSize(File file, int decimals) {
    if (!file.existsSync()) return '-';
    int bytes = file.lengthSync();
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    var i = (log(bytes) / log(1024)).floor();
    return ((bytes / pow(1024, i)).toStringAsFixed(decimals)) +
        ' ' +
        suffixes[i];
  }

  _openDocument(BuildContext context, File file) {
    Routemaster.of(context).push("/viewer/${basename(file.path)}");
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppViewModel>(
      builder: (context, vm, child) => Material(
        child: CupertinoPageScaffold(
          backgroundColor: AppTheme.backgroundColor,
          child: Stack(
            children: [
              CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverSafeArea(
                    sliver: SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: const [
                            SizedBox(
                              height: 16,
                            ),
                            Text(
                              "DESCARGAS",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Builder(
                    builder: (context) {
                      if (vm.downloads.state == ResourceState.error) {
                        return SliverFillRemaining(
                          child: Center(
                            child: Text(vm.downloads.exception ?? "Error"),
                          ),
                        );
                      }
                      if (vm.downloads.data!.isEmpty) {
                        return SliverFillRemaining(
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [
                                Icon(
                                  CupertinoIcons.info_circle,
                                  size: 16,
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  "No existen documentos descargados",
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                      return SliverPadding(
                        padding: const EdgeInsets.all(16),
                        sliver: SliverList(
                          delegate:
                              SliverChildBuilderDelegate((context, index) {
                            final item = vm.downloads.data![index];
                            return Card(
                              elevation: 0,
                              margin: const EdgeInsets.only(
                                  left: 0, right: 0, bottom: 8),
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            basename(item.path).toUpperCase(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: AppTheme.primary,
                                                fontSize: 16),
                                          ),
                                        ),
                                        ActionIcon(
                                          icon: CupertinoIcons.doc_text,
                                          onClick: () =>
                                              _openDocument(context, item),
                                        ),
                                        const SizedBox(
                                          width: 12,
                                        ),
                                        ActionIcon(
                                            icon: CupertinoIcons.trash,
                                            onClick: () =>
                                                vm.removeDownload(item))
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Text(_getFileSize(item, 1)),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Row(
                                      children: [
                                        const Text(
                                          "ÚLTIMO ACCESO:",
                                          style: TextStyle(fontSize: 12),
                                        ),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        Text(
                                          DateFormat("MMM dd")
                                              .format(item.lastAccessedSync()),
                                          style: const TextStyle(fontSize: 12),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          }, childCount: vm.downloads.data?.length ?? 0),
                        ),
                      );
                    },
                  )
                ],
              ),
              if (vm.downloads.state == ResourceState.loading)
                Positioned(
                    top: 0,
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppTheme.primary.withOpacity(0.1),
                      ),
                      child: Center(
                        child: SpinKitPulse(
                          size: 24,
                          color: AppTheme.accent,
                        ),
                      ),
                    ))
            ],
          ),
        ),
      ),
    );
  }
}
