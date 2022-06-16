import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:legalis/model/resource.dart';
import 'package:legalis/screens/glossary/glossary_viewmodel.dart';
import 'package:legalis/theme.dart';
import 'package:legalis/widget/letter_selector.dart';
import 'package:provider/provider.dart';
import 'package:routemaster/routemaster.dart';
import 'package:sticky_grouped_list/sticky_grouped_list.dart';

class GlossaryScreen extends StatefulWidget {
  const GlossaryScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _GlossaryScreenState createState() => _GlossaryScreenState();
}

class _GlossaryScreenState extends State<GlossaryScreen> {
  final viewModel = GlossaryViewModel();

  final _controller = GroupedItemScrollController();

  @override
  void initState() {
    super.initState();
    viewModel.loadTerms();
  }

  _scrollTo(String e) {
    try {
      final el = viewModel.terms.data?.results
          .firstWhere((element) => element.term.substring(0, 1) == e);
      if (el != null) {
        final index = viewModel.terms.data!.results.indexOf(el);
        _controller.jumpTo(index: index);
      }
      // ignore: empty_catches
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: viewModel,
      builder: (context, _) => Consumer<GlossaryViewModel>(
          builder: (context, value, child) => Material(
                child: CupertinoPageScaffold(
                    backgroundColor: AppTheme.backgroundColor,
                    navigationBar: CupertinoNavigationBar(
                      border: null,
                      backgroundColor: Colors.transparent,
                      leading: InkWell(
                        onTap: () {
                          Routemaster.of(context).pop();
                        },
                        borderRadius: BorderRadius.circular(360),
                        child: const Icon(
                          Icons.arrow_back_rounded,
                          size: 28,
                        ),
                      ),
                    ),
                    child: Stack(
                      children: [
                        CustomScrollView(
                          physics: const BouncingScrollPhysics(),
                          slivers: [
                            SliverSafeArea(
                              sliver: SliverToBoxAdapter(
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 4),
                                      child: LetterSelector(
                                          onLetterChange: (e) => _scrollTo(e)),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Builder(builder: (context) {
                              if (viewModel.terms.state ==
                                  ResourceState.error) {
                                return SliverFillRemaining(
                                  child: Center(
                                    child: Text(
                                        viewModel.terms.exception ?? "Error"),
                                  ),
                                );
                              }
                              final terms = viewModel.terms.data?.results ?? [];
                              return SliverFillRemaining(
                                child: StickyGroupedListView<dynamic, String>(
                                  physics: const BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  elements: terms,
                                  itemScrollController: _controller,
                                  groupBy: (element) =>
                                      element.term.substring(0, 1),
                                  groupSeparatorBuilder:
                                      (dynamic groupByValue) => Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    padding: const EdgeInsets.only(
                                        top: 4, bottom: 4, left: 8),
                                    decoration: BoxDecoration(
                                        //backgroundBlendMode: BlendMode.multiply,
                                        color: HexColor("#dfe5e8"),
                                        borderRadius: BorderRadius.circular(2)),
                                    height: 24,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          groupByValue.term.substring(0, 1),
                                          style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ),
                                  itemBuilder: (context, dynamic element) =>
                                      Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          element.term.toUpperCase(),
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Text(element.description ?? "-")
                                      ],
                                    ),
                                  ),
                                  itemComparator: (item1, item2) =>
                                      item1.id.compareTo(item2.id), // optional
                                  //useStickyGroupSeparators: true, // optional
                                  floatingHeader: true, // optional
                                  order: StickyGroupedListOrder.ASC, // optional
                                ),
                              );
                            })
                          ],
                        ),
                        if (viewModel.terms.state == ResourceState.loading)
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
                    )),
              )),
    );
  }
}
