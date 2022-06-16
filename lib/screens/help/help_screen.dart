import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:legalis/model/resource.dart';
import 'package:legalis/screens/help/help_viewmodel.dart';
import 'package:legalis/theme.dart';
import 'package:provider/provider.dart';
import 'package:routemaster/routemaster.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HelpScreenState createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  final viewModel = HelpViewModel();

  @override
  void initState() {
    super.initState();
    viewModel.fetchItems();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: viewModel,
      builder: (context, _) => Consumer<HelpViewModel>(
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
                child: const Icon(
                  Icons.arrow_back_rounded,
                  size: 28,
                ),
              ),
            ),
            child: Stack(
              children: [
                CustomScrollView(
                  slivers: [
                    SliverSafeArea(
                      sliver: SliverToBoxAdapter(
                        child: Builder(
                          builder: (BuildContext context) {
                            if (viewModel.items.state == ResourceState.error) {
                              return Center(
                                child:
                                    Text(viewModel.items.exception.toString()),
                              );
                            } else if (!viewModel.isLoading) {
                              var items = viewModel.items.data ?? [];
                              return Column(
                                children: [
                                  ListView.builder(
                                      primary: false,
                                      shrinkWrap: true,
                                      padding: const EdgeInsets.all(16),
                                      itemCount: items.length,
                                      itemBuilder:
                                          (BuildContext context, index) {
                                        var item = items[index];
                                        return Container(
                                          margin:
                                              const EdgeInsets.only(bottom: 18),
                                          padding:
                                              const EdgeInsets.only(bottom: 18),
                                          decoration: const BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                      color: CupertinoColors
                                                          .separator))),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                item['title']
                                                    .toString()
                                                    .toUpperCase(),
                                                // style: AppTheme.listItemTitleTextStyle,
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    color: AppTheme.primary,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16),
                                              ),
                                              const SizedBox(
                                                height: 4,
                                              ),
                                              Text(
                                                item['text'],
                                                // style: AppTheme.listItemBodyTextStyle,
                                                textAlign: TextAlign.start,
                                              )
                                            ],
                                          ),
                                        );
                                      })
                                ],
                              );
                            }
                            return const SizedBox();
                          },
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
        ),
      ),
    );
  }
}
