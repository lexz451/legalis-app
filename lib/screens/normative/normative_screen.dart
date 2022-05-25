import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:legalis/main.dart';
import 'package:legalis/model/resource.dart';
import 'package:legalis/screens/app_viewmodel.dart';
import 'package:legalis/screens/normative/normative_viewmodel.dart';
import 'package:legalis/theme.dart';
import 'package:legalis/widget/action_icon.dart';
import 'package:provider/provider.dart';
import 'package:routemaster/routemaster.dart';
import 'package:share_plus/share_plus.dart';

class NormativeScreen extends StatefulWidget {
  final String id;

  const NormativeScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NormativeScreenState();
}

class _NormativeScreenState extends State<NormativeScreen> {
  final viewModel = NormativeViewModel();

  @override
  void initState() {
    super.initState();
    viewModel.loadNormative(widget.id);
  }

  _share(norm) {
    Share.share('https://legalis.netlify.app/normativa/${norm.id}');
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: viewModel,
      builder: (context, _) => Consumer<NormativeViewModel>(
          builder: (context, model, _) => Material(
                child: CupertinoPageScaffold(
                  backgroundColor: AppTheme.backgroundColor,
                  navigationBar: CupertinoNavigationBar(
                    border: null,
                    backgroundColor: AppTheme.backgroundColor.withOpacity(.25),
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
                  child: Stack(
                    children: [
                      CustomScrollView(
                        primary: true,
                        physics: const BouncingScrollPhysics(),
                        slivers: [
                          if (viewModel.gazette != null)
                            SliverSafeArea(
                              sliver: SliverToBoxAdapter(
                                child: Container(
                                  margin: const EdgeInsets.only(
                                      left: 16, right: 16, top: 16),
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                      color: AppTheme.primary,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Center(
                                    child: Column(
                                      children: [
                                        Text(
                                          "Gaceta que contiene la norma"
                                              .toUpperCase(),
                                          style: const TextStyle(
                                              color: Colors.white70,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const Divider(
                                          height: 16,
                                          color: Colors.white24,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            InkWell(
                                              onTap: () =>
                                                  Routemaster.of(context).push(
                                                      "/viewer/${viewModel.gazette?.file}"),
                                              child: Row(
                                                children: const [
                                                  Icon(
                                                    CupertinoIcons.doc_text,
                                                    color: Colors.white70,
                                                    size: 20,
                                                  ),
                                                  SizedBox(
                                                    width: 4,
                                                  ),
                                                  Text(
                                                    "VER GACETA",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white70,
                                                        fontSize: 12),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 32,
                                            ),
                                            Consumer<AppViewModel>(
                                              builder:
                                                  (context, value, child) =>
                                                      FutureBuilder<bool>(
                                                future: value.isDownloaded(
                                                    viewModel.gazette?.file),
                                                builder: (context, snapshot) {
                                                  final isDownloaded =
                                                      snapshot.data != null &&
                                                          snapshot.data!;
                                                  if (isDownloaded) {
                                                    return Row(
                                                      children: [
                                                        Icon(
                                                          CupertinoIcons
                                                              .checkmark_square,
                                                          color:
                                                              AppTheme.accent,
                                                          size: 20,
                                                        ),
                                                        const SizedBox(
                                                          width: 4,
                                                        ),
                                                        Text("DESCARGADO",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: AppTheme
                                                                    .accent,
                                                                fontSize: 12))
                                                      ],
                                                    );
                                                  }
                                                  return GestureDetector(
                                                    onTap: () => value.saveFile(
                                                        "https://api-gaceta.datalis.dev/files/${viewModel.gazette?.file}",
                                                        viewModel
                                                            .gazette?.file),
                                                    child: Row(
                                                      children: const [
                                                        Icon(
                                                          CupertinoIcons
                                                              .arrow_down,
                                                          color: Colors.white70,
                                                          size: 20,
                                                        ),
                                                        SizedBox(
                                                          width: 4,
                                                        ),
                                                        Text(
                                                          "DESCARGAR",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Colors
                                                                  .white70,
                                                              fontSize: 12),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          if (viewModel.normative.state == ResourceState.error)
                            SliverFillRemaining(
                              child: Center(
                                child: Text(
                                    viewModel.normative.exception ?? "Error"),
                              ),
                            ),
                          if (viewModel.normative.data != null)
                            SliverToBoxAdapter(
                              child: Card(
                                elevation: .0,
                                margin: const EdgeInsets.only(
                                    left: 16, right: 16, top: 16),
                                child: Container(
                                  margin: const EdgeInsets.all(16),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                color: AppTheme.accent,
                                                borderRadius:
                                                    BorderRadius.circular(4)),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 18, vertical: 8),
                                            child: Center(
                                              child: Text(
                                                viewModel.normative.data?.state
                                                        ?.toUpperCase() ??
                                                    "",
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14),
                                              ),
                                            ),
                                          ),
                                          const Expanded(child: SizedBox()),
                                          Consumer<AppViewModel>(
                                            builder: (context, value, child) =>
                                                value.isBookmark(
                                                        viewModel
                                                            .normative.data!)
                                                    ? ActionIcon(
                                                        icon: Icons
                                                            .bookmark_added_rounded,
                                                        onClick: () => value
                                                            .toggleBookmark(
                                                                viewModel
                                                                    .normative
                                                                    .data!),
                                                      )
                                                    : ActionIcon(
                                                        icon: Icons
                                                            .bookmark_add_rounded,
                                                        onClick: () => value
                                                            .toggleBookmark(
                                                                viewModel
                                                                    .normative
                                                                    .data!)),
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          ActionIcon(
                                            icon: Icons.share_rounded,
                                            onClick: () => _share(
                                                viewModel.normative.data),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 24,
                                      ),
                                      Text(
                                        viewModel.normative.data?.name ?? "",
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Row(
                                        children: [
                                          const Text(
                                            "TIPO: ",
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            viewModel
                                                    .normative.data?.normtype ??
                                                "-",
                                            style:
                                                const TextStyle(fontSize: 12),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "EMISOR: ",
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Expanded(
                                              child: Text(
                                            viewModel
                                                    .normative.data?.organism ??
                                                "-",
                                            style:
                                                const TextStyle(fontSize: 12),
                                          ))
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Row(
                                        children: [
                                          const Text(
                                            "AÑO: ",
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            viewModel.normative.data?.year
                                                    .toString() ??
                                                "-",
                                            style:
                                                const TextStyle(fontSize: 12),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 24,
                                      ),
                                      Text(
                                        viewModel.normative.data?.summary ??
                                            "-",
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                      const SizedBox(
                                        height: 24,
                                      ),
                                      const Text(
                                        "Palabras clave:",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Wrap(
                                        spacing: 4,
                                        direction: Axis.horizontal,
                                        children: (viewModel
                                                    .normative.data?.keywords ??
                                                [])
                                            .map((e) => Text(
                                                  e,
                                                  style: TextStyle(
                                                      color:
                                                          AppTheme.primaryLight,
                                                      fontSize: 16),
                                                ))
                                            .toList(),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                        ],
                      ),
                      if (viewModel.isLoading)
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
              )),
    );
  }
}
