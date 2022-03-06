import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:legalis/model/resource.dart';
import 'package:legalis/state/normative_viewmodel.dart';
import 'package:legalis/theme.dart';
import 'package:provider/provider.dart';
import 'package:routemaster/routemaster.dart';

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
                    backgroundColor: AppTheme.backgroundColor.withOpacity(.75),
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
                  child: CustomScrollView(
                    physics: const BouncingScrollPhysics(),
                    slivers: [
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 80,
                              ),
                              Text(
                                viewModel.normative.data?.name ?? "",
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(
                                height: 12,
                              )
                            ],
                          ),
                        ),
                      ),
                      Builder(builder: (context) {
                        if (viewModel.normative.state ==
                            ResourceState.loading) {
                          return const SliverFillRemaining(
                            child: Center(
                              child: SizedBox(
                                height: 24,
                                width: 24,
                                child:
                                    CircularProgressIndicator(strokeWidth: 4.0),
                              ),
                            ),
                          );
                        } else if (viewModel.normative.state ==
                            ResourceState.error) {
                          return SliverFillRemaining(
                            child: Center(
                              child: Text(
                                  viewModel.normative.exception ?? "Error"),
                            ),
                          );
                        }
                        return SliverToBoxAdapter(
                          child: Column(
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 16),
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
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      const Divider(
                                        color: Colors.white24,
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          InkWell(
                                            onTap: () => Routemaster.of(context)
                                                .push(
                                                    "viewer/${viewModel.gazette?.file}"),
                                            child: Row(
                                              children: const [
                                                Icon(
                                                  Icons.open_in_browser,
                                                  color: Colors.white70,
                                                  size: 20,
                                                ),
                                                SizedBox(
                                                  width: 4,
                                                ),
                                                Text(
                                                  "ABRIR GACETA",
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
                                          Row(
                                            children: const [
                                              Icon(
                                                Icons.download_rounded,
                                                color: Colors.white70,
                                                size: 20,
                                              ),
                                              SizedBox(
                                                width: 4,
                                              ),
                                              Text(
                                                "DESCARGAR",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white70,
                                                    fontSize: 12),
                                              ),
                                            ],
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Card(
                                margin: const EdgeInsets.all(16),
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
                                                viewModel.normative.data!.state!
                                                    .toUpperCase(),
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14),
                                              ),
                                            ),
                                          ),
                                          const Expanded(child: SizedBox()),
                                          GestureDetector(
                                            onTap: () {},
                                            child: true
                                                ? const Icon(
                                                    Icons.bookmark_rounded)
                                                : const Icon(Icons
                                                    .bookmark_outline_rounded),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 24,
                                      ),
                                      Row(
                                        children: [
                                          const Text(
                                            "Tipo: ",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            viewModel
                                                    .normative.data?.normtype ??
                                                "-",
                                            style:
                                                const TextStyle(fontSize: 16),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Row(
                                        children: [
                                          const Text(
                                            "Emisor: ",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            viewModel
                                                    .normative.data?.organism ??
                                                "-",
                                            style:
                                                const TextStyle(fontSize: 16),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Row(
                                        children: [
                                          const Text(
                                            "Año: ",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            viewModel.normative.data?.year
                                                    .toString() ??
                                                "-",
                                            style:
                                                const TextStyle(fontSize: 16),
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
                              )
                            ],
                          ),
                        );
                      })
                    ],
                  ),
                ),
              )),
    );
  }
}
