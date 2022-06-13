import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:legalis/screens/gazette-detail/gazette_viewmodel.dart';
import 'package:legalis/theme.dart';
import 'package:legalis/widget/normative_item.dart';
import 'package:provider/provider.dart';
import 'package:routemaster/routemaster.dart';

class GazetteScreen extends StatefulWidget {
  final String id;
  const GazetteScreen({required this.id, Key? key}) : super(key: key);

  @override
  State<GazetteScreen> createState() => _GazetteScreenState();
}

class _GazetteScreenState extends State<GazetteScreen> {
  final viewModel = GazetteViewModel();

  @override
  void initState() {
    super.initState();
    viewModel.fetchGazette(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: viewModel,
      builder: (context, _) => Material(
        child: Ink(
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
            child: Consumer<GazetteViewModel>(
              builder: (context, value, child) => Stack(
                children: [
                  if (viewModel.gazette != null)
                    CustomScrollView(
                      slivers: [
                        SliverSafeArea(
                            sliver: SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              children: [
                                Text(
                                  viewModel.gazette!.name ?? "",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CupertinoButton(
                                      borderRadius: BorderRadius.circular(4),
                                      minSize: 24,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 0, vertical: 0),
                                      onPressed: () => {},
                                      child: Row(
                                        children: const [
                                          Icon(
                                            CupertinoIcons.doc_text,
                                            size: 16,
                                          ),
                                          SizedBox(
                                            width: 4,
                                          ),
                                          Text(
                                            "VER DOCUMENTO",
                                            style: TextStyle(fontSize: 12),
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    CupertinoButton(
                                      borderRadius: BorderRadius.circular(4),
                                      minSize: 24,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 0, vertical: 0),
                                      onPressed: () => {},
                                      child: Row(
                                        children: const [
                                          Icon(
                                            CupertinoIcons.arrow_down,
                                            size: 16,
                                          ),
                                          SizedBox(
                                            width: 4,
                                          ),
                                          Text(
                                            "DESCARGAR",
                                            style: TextStyle(fontSize: 12),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        )),
                        SliverPadding(
                          padding: const EdgeInsets.only(
                              left: 16, right: 16, top: 16),
                          sliver: SliverToBoxAdapter(
                            child: Row(
                              children: const [
                                Text(
                                  "NORMATIVAS",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SliverPadding(
                          padding: const EdgeInsets.all(16),
                          sliver: SliverList(
                              delegate: SliverChildBuilderDelegate(
                                  (context, index) {
                            final norm = viewModel.gazette!.normatives?[index];
                            return NormativeItem(normative: norm!);
                          },
                                  childCount:
                                      viewModel.gazette!.normatives?.length ??
                                          0)),
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
          ),
        ),
      ),
    );
  }
}
