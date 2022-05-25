import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:legalis/model/resource.dart';
import 'package:legalis/screens/glossary/glossary_viewmodel.dart';
import 'package:legalis/theme.dart';
import 'package:legalis/widget/letter_selector.dart';
import 'package:provider/provider.dart';
import 'package:routemaster/routemaster.dart';

class GlossaryScreen extends StatefulWidget {
  const GlossaryScreen({Key? key}) : super(key: key);

  @override
  _GlossaryScreenState createState() => _GlossaryScreenState();
}

class _GlossaryScreenState extends State<GlossaryScreen> {
  final viewModel = GlossaryViewModel();

  @override
  void initState() {
    super.initState();
    viewModel.loadTerms();
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
                            SliverToBoxAdapter(
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 72,
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 8),
                                    child: LetterSelector(
                                      onLetterChange: (e) => viewModel.loadTerms(letter: e)
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  )
                                ],
                              ),
                            ),
                            Builder(builder: (context) {
                              if (viewModel.terms.state ==
                                  ResourceState.error) {
                                return SliverFillRemaining(
                                  child: Center(
                                    child:
                                    Text(viewModel.terms.exception ?? "Error"),
                                  ),
                                );
                              }
                              final terms = viewModel.terms.data?.results ?? [];
                              return SliverList(
                                  delegate:
                                  SliverChildBuilderDelegate((context, index) {
                                    final item = terms[index];
                                    return Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            item.term.toUpperCase(),
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: AppTheme.primary),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Text(item.description ?? "-")
                                        ],
                                      ),
                                    );
                                  }, childCount: terms.length));
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
