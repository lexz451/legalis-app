import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:legalis/main.dart';
import 'package:legalis/model/gazette.dart';
import 'package:legalis/model/normative.dart';
import 'package:legalis/model/resource.dart';
import 'package:legalis/screens/recent/recent_normative_viewmodel.dart';
import 'package:legalis/theme.dart';
import 'package:legalis/widget/action_icon.dart';
import 'package:legalis/widget/normative_item.dart';
import 'package:provider/provider.dart';
import 'package:routemaster/routemaster.dart';

class RecentNormative extends StatefulWidget {
  const RecentNormative({Key? key}) : super(key: key);

  @override
  State<RecentNormative> createState() => _RecentNormativeState();
}

class _RecentNormativeState extends State<RecentNormative> {
  final viewModel = RecentNormativeViewModel();

  @override
  void initState() {
    super.initState();
    viewModel.fetchLatestGazette();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Material(
        child: CupertinoPageScaffold(
          backgroundColor: AppTheme.backgroundColor,
          navigationBar: CupertinoNavigationBar(
            border: null,
            backgroundColor: AppTheme.backgroundColor.withOpacity(.25),
            leading: GestureDetector(
              onTap: () {
                Routemaster.of(context).pop();
              },
              child: Icon(
                Icons.arrow_back_rounded,
                size: 28,
                color: AppTheme.primary,
              ),
            ),
          ),
          child: Consumer<RecentNormativeViewModel>(
            builder: (context, _, __) => Stack(
              children: [
                CustomScrollView(
                  slivers: [
                    SliverSafeArea(
                        sliver: SliverToBoxAdapter(
                      child: Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 18),
                            decoration: BoxDecoration(
                              color: AppTheme.backgroundColor.withOpacity(.25),
                            ),
                            child: Builder(builder: (context) {
                              final _gazette = viewModel.gazette.data;
                              if (_gazette == null) return const SizedBox();
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _gazette.name?.toUpperCase() ?? "",
                                    style: TextStyle(
                                        color: AppTheme.primary,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                _gazette.type?.toUpperCase() ??
                                                    "-",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14,
                                                    color: AppTheme.primary)),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            Text(
                                                _gazette.date?.toString() ??
                                                    "-",
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.normal))
                                          ],
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          ActionIcon(
                                            icon: CupertinoIcons.doc_text,
                                            onClick: () =>
                                                Routemaster.of(context).push(
                                                    "/viewer/${viewModel.gazette.data?.file}"),
                                          ),
                                          const SizedBox(
                                            width: 12,
                                          ),
                                          ActionIcon(
                                            icon: CupertinoIcons.down_arrow,
                                            onClick: () => {},
                                          )
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              );
                            }),
                          )
                        ],
                      ),
                    )),
                    Builder(
                      builder: (_) {
                        final items = viewModel.normatives;
                        return SliverPadding(
                          padding: const EdgeInsets.all(16),
                          sliver: SliverList(
                              delegate:
                                  SliverChildBuilderDelegate((context, index) {
                            final item = items[index];
                            return GestureDetector(
                              onTap: () => Routemaster.of(context)
                                  .push('/normative/${item.id}'),
                              child: Card(
                                margin: const EdgeInsets.only(
                                    left: 0, right: 0, bottom: 8),
                                elevation: 0,
                                child: Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        (item.normtype ?? "").toUpperCase(),
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: AppTheme.accent),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        item.name,
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Text(item.summary ?? "-")
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }, childCount: items.length)),
                        );
                      },
                    )
                  ],
                ),
                if (viewModel.gazette.state == ResourceState.loading)
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
