import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:legalis/model/resource.dart';
import 'package:legalis/state/glossary_viewmodel.dart';
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
                    child: CustomScrollView(
                      physics: const BouncingScrollPhysics(),
                      slivers: [
                        SliverToBoxAdapter(
                          child: Column(
                            children: const [
                              SizedBox(
                                height: 80,
                              ),
                              Text(
                                "Glosario",
                                style: TextStyle(
                                    fontSize: 32, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                child: LetterSelector(),
                              ),
                              SizedBox(
                                height: 12,
                              )
                            ],
                          ),
                        ),
                        Builder(builder: (context) {
                          if (viewModel.terms.state == ResourceState.loading) {
                            return const SliverFillRemaining(
                              child: Center(
                                  child: SizedBox(
                                height: 24,
                                width: 24,
                                child:
                                    CircularProgressIndicator(strokeWidth: 4.0),
                              )),
                            );
                          } else if (viewModel.terms.state ==
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
                    )),
              )),
    );
  }
}
