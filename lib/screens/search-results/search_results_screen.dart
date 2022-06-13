import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:legalis/screens/search-results/search_results_viewmodel.dart';
import 'package:legalis/theme.dart';
import 'package:legalis/widget/normative_item.dart';
import 'package:legalis/widget/pagination.dart';
import 'package:legalis/widget/search_filters.dart';
import 'package:provider/provider.dart';
import 'package:routemaster/routemaster.dart';

class SearchResultsScreen extends StatefulWidget {
  const SearchResultsScreen({Key? key, required this.params}) : super(key: key);

  final Map<String, dynamic> params;

  @override
  State<StatefulWidget> createState() => _SearchResultsScreenState();
}

class _SearchResultsScreenState extends State<SearchResultsScreen> {
  final viewModel = SearchResultsViewModel();

  Map<String, dynamic> _params = {};

  int sortBy = 1;
  int pageSize = 5;

  int get currentPage => _params['page'] ?? 1;

  setSortBy(sort) {
    sortBy = sort;
    _params = {..._params};
    if (sortBy == 2) {
      _params['sort_by_year'] = true;
    } else {
      _params['sort_by_year'] = null;
    }
    viewModel.fetchResults(_params);
  }

  _onFilterChange(params) {
    _params = {..._params, ...params, 'page': 1};
    viewModel.fetchResults(_params);
  }

  _onPageChange(page) {
    _params = {..._params, 'page': page};
    viewModel.fetchResults(_params);
  }

  @override
  void initState() {
    super.initState();
    _params = {...widget.params};
    viewModel.fetchResults(_params);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: viewModel,
      builder: (context, _) {
        return Material(
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
            child: Consumer<SearchResultsViewModel>(
              builder: (context, value, child) {
                return Stack(
                  children: [
                    CustomScrollView(
                      physics: const BouncingScrollPhysics(),
                      slivers: [
                        SliverSafeArea(
                          sliver: SliverToBoxAdapter(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: SearchFilters(
                                    params: _params,
                                    onSubmit: (params) =>
                                        _onFilterChange(params),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: viewModel.totalResults > 0
                                      ? Row(
                                          children: [
                                            Expanded(
                                                child: Text(
                                                    "${viewModel.totalResults} resultados",
                                                    style: const TextStyle(
                                                      fontSize: 12,
                                                    ))),
                                            Row(
                                              children: [
                                                const Text(
                                                  "Mas relevantes",
                                                  style:
                                                      TextStyle(fontSize: 12),
                                                ),
                                                Radio(
                                                  visualDensity:
                                                      VisualDensity.compact,
                                                  value: 1,
                                                  groupValue: sortBy,
                                                  onChanged: (v) =>
                                                      setSortBy(v),
                                                )
                                              ],
                                            ),
                                            const SizedBox(
                                              width: 4,
                                            ),
                                            Row(
                                              children: [
                                                const Text(
                                                  "Mas recientes",
                                                  style:
                                                      TextStyle(fontSize: 12),
                                                ),
                                                Radio(
                                                    visualDensity:
                                                        VisualDensity.compact,
                                                    value: 2,
                                                    groupValue: sortBy,
                                                    onChanged: (value) {
                                                      setSortBy(value);
                                                    })
                                              ],
                                            ),
                                          ],
                                        )
                                      : const SizedBox(),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Builder(builder: (context) {
                          if (viewModel.hasErrors) {
                            return SliverFillRemaining(
                              fillOverscroll: true,
                              child: Center(
                                child: Text(viewModel.error),
                              ),
                            );
                          }
                          var results = viewModel.norms;
                          return SliverPadding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            sliver: SliverList(
                                delegate: SliverChildBuilderDelegate(
                                    (context, index) {
                              final item = results[index];
                              return NormativeItem(normative: item);
                            }, childCount: results.length)),
                          );
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
                );
              },
            ),
          ),
        );
      },
    );
  }
}
