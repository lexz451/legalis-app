// ignore_for_file: unnecessary_const

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:legalis/model/resource.dart';
import 'package:legalis/state/gazettes_viewmodel.dart';
import 'package:legalis/theme.dart';
import 'package:legalis/widget/filters_selector.dart';
import 'package:legalis/widget/gazette_item.dart';
import 'package:provider/provider.dart';
import 'package:routemaster/routemaster.dart';

class GazettesScreen extends StatefulWidget {
  const GazettesScreen({Key? key}) : super(key: key);

  @override
  _GazettesScreenState createState() => _GazettesScreenState();
}

class _GazettesScreenState extends State<GazettesScreen> {
  final viewModel = GazettesViewModel();

  @override
  void initState() {
    super.initState();
    viewModel.loadFilterData();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: viewModel,
      builder: (context, _) => Consumer<GazettesViewModel>(
          builder: (context, value, child) => Material(
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
                    slivers: [
                      SliverPadding(
                        padding: const EdgeInsets.all(8),
                        sliver: SliverToBoxAdapter(
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 80,
                              ),
                              Text(
                                "Indice de Gaceta",
                                style: TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                    color: AppTheme.primary),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Builder(builder: (context) {
                        if (viewModel.filtersLoading) {
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
                        }
                        return SliverList(
                            delegate: SliverChildListDelegate([
                          FiltersSelector(
                            gazetteTypes: viewModel.gazetteTypes,
                            topics: viewModel.normativeTopics,
                          ),
                          const SizedBox(
                            height: 18,
                          )
                        ]));
                      }),
                      if (!viewModel.filtersLoading)
                        Builder(builder: (context) {
                          if (viewModel.gazettes.state ==
                              ResourceState.loading) {
                            return const SliverFillRemaining(
                              child: Center(
                                  child: SizedBox(
                                height: 24,
                                width: 24,
                                child:
                                    CircularProgressIndicator(strokeWidth: 4.0),
                              )),
                            );
                          } else if (viewModel.gazettes.state ==
                              ResourceState.error) {
                            return SliverFillRemaining(
                              child: Center(
                                  child: Text(
                                      viewModel.gazettes.exception ?? "Error")),
                            );
                          }
                          final _gazettes =
                              viewModel.gazettes.data?.results ?? [];
                          return SliverList(
                              delegate:
                                  SliverChildBuilderDelegate((context, index) {
                            final item = _gazettes[index];
                            return GazetteItem(
                              gazette: item,
                            );
                          }, childCount: _gazettes.length));
                        })
                    ],
                  ),
                ),
              )),
    );
  }
}
