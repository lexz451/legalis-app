import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:legalis/state/search_results_viewmodel.dart';
import 'package:legalis/theme.dart';
import 'package:legalis/widget/filters_selector.dart';
import 'package:legalis/widget/normative_item.dart';
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

  Map<String, dynamic> get params => widget.params;

  @override
  void initState() {
    super.initState();
    viewModel.fetchResults(params);
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
            child: Consumer<SearchResultsViewModel>(
              builder: (context, value, child) {
                return CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 75,
                          ),
                          Text(
                            "Resultados de la búsqueda",
                            style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: AppTheme.primary),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          FiltersSelector(),
                          const SizedBox(
                            height: 8,
                          ),
                        ],
                      ),
                    ),
                    Builder(builder: (context) {
                      if (viewModel.isLoading) {
                        return const SliverFillRemaining(
                          fillOverscroll: true,
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
                            delegate:
                                SliverChildBuilderDelegate((context, index) {
                          final item = results[index];
                          return NormativeItem(normative: item);
                        }, childCount: results.length)),
                      );
                    })
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
