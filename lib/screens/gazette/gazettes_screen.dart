// ignore_for_file: unnecessary_const

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:legalis/model/resource.dart';
import 'package:legalis/screens/gazette/gazettes_viewmodel.dart';
import 'package:legalis/theme.dart';
import 'package:legalis/widget/gazette_item.dart';
import 'package:legalis/widget/pagination.dart';
import 'package:legalis/widget/search_filters.dart';
import 'package:provider/provider.dart';
import 'package:routemaster/routemaster.dart';

class GazettesScreen extends StatefulWidget {
  const GazettesScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _GazettesScreenState createState() => _GazettesScreenState();
}

class _GazettesScreenState extends State<GazettesScreen> {
  final viewModel = GazettesViewModel();

  final pageSize = 5;

  Map<String, dynamic> _params = {'page': 1, 'page_size': 5};

  int get currentPage => _params['page'] ?? 1;

  _onFiltersChange(params) {
    _params = {..._params, ...params, 'page': 1};
    viewModel.loadGazettes(params: _params);
  }

  _onPageChange(page) {
    _params = {..._params, 'page': page};
    viewModel.loadGazettes(params: _params);
  }

  @override
  void initState() {
    super.initState();
    viewModel.loadFilterData();
    viewModel.loadGazettes(params: _params);
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
                        slivers: [
                          SliverSafeArea(
                            sliver: Builder(builder: (context) {
                              return SliverPadding(
                                padding: const EdgeInsets.all(16),
                                sliver: SliverToBoxAdapter(
                                  child: SearchFilters(
                                    onSubmit: (params) =>
                                        _onFiltersChange(params),
                                    params: _params,
                                    showGazetteTypeFilter: true,
                                    showNormativeStateFilter: false,
                                    showTextFilter: false,
                                  ),
                                ),
                              );
                            }),
                          ),
                          Builder(builder: (context) {
                            if (viewModel.gazettes.state ==
                                ResourceState.error) {
                              return SliverFillRemaining(
                                child: Center(
                                    child: Text(viewModel.gazettes.exception ??
                                        "Error")),
                              );
                            }
                            final gazettes =
                                viewModel.gazettes.data?.results ?? [];
                            return SliverList(
                                delegate: SliverChildBuilderDelegate(
                                    (context, index) {
                              final item = gazettes[index];
                              return GazetteItem(
                                gazette: item,
                              );
                            }, childCount: gazettes.length));
                          }),
                          if (viewModel.totalResults > 0 &&
                              viewModel.totalResults > pageSize)
                            SliverToBoxAdapter(
                              child: Pagination(
                                  totalResults: viewModel.totalResults,
                                  pageSize: pageSize,
                                  onPageChange: _onPageChange,
                                  currentPage: currentPage),
                            )
                        ],
                      ),
                      if (viewModel.gazettes.state == ResourceState.loading)
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
