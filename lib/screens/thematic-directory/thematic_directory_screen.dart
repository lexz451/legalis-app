import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:legalis/model/directory.dart';
import 'package:legalis/model/resource.dart';
import 'package:legalis/screens/thematic-directory/thematic_directory_viewmodel.dart';
import 'package:legalis/theme.dart';
import 'package:legalis/widget/directory_selector.dart';
import 'package:legalis/widget/normative_item.dart';
import 'package:legalis/widget/pagination.dart';
import 'package:provider/provider.dart';
import 'package:routemaster/routemaster.dart';

class Directories extends StatefulWidget {
  const Directories({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DirectoriesState();
}

class _DirectoriesState extends State<Directories> {
  final viewModel = DirectoriesViewModel();

  Widget _buildBreadCrumb(List<Directory> breadcrumb) {
    return SizedBox(
      height: 24,
      width: MediaQuery.of(context).size.width,
      child: Wrap(
        direction: Axis.horizontal,
        alignment: WrapAlignment.start,
        runAlignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: breadcrumb.map((e) {
          final isFirst = breadcrumb.indexOf(e) == 0;
          final item = e;
          return GestureDetector(
            onTap: () {
              viewModel.setCurrentDirectory(item, isChild: !isFirst);
            },
            child: Builder(builder: (_) {
              if (isFirst) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.string(item.icon!,
                        width: 18, height: 18, color: AppTheme.primary),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      item.name!,
                      style: TextStyle(
                          fontSize: 14,
                          color: AppTheme.primary,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                );
              }
              return Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4),
                    child: Icon(
                      CupertinoIcons.chevron_right,
                      size: 12,
                    ),
                  ),
                  Text(
                    item.name!,
                    style: TextStyle(
                        fontSize: 14,
                        color: AppTheme.primary,
                        fontWeight: FontWeight.bold),
                  )
                ],
              );
            }),
          );
        }).toList(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    viewModel.loadDirectories();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DirectoriesViewModel>.value(
        value: viewModel,
        builder: (context, _) =>
            Consumer<DirectoriesViewModel>(builder: (context, _, __) {
              return Material(
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
                  child: Stack(
                    children: [
                      CustomScrollView(
                        physics: const BouncingScrollPhysics(),
                        slivers: [
                          SliverSafeArea(
                            sliver: SliverToBoxAdapter(
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    DirectorySelector(
                                      selected: viewModel.currentDirectory,
                                      onDirectorySelected: (item) {
                                        viewModel.setCurrentDirectory(item);
                                      },
                                      directories:
                                          viewModel.directories.data ?? [],
                                    ),
                                    const SizedBox(
                                      height: 24,
                                    ),
                                    _buildBreadCrumb(viewModel.breadcrumb),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Builder(builder: (context) {
                                      final subDirs = viewModel
                                              .currentDirectory?.children ??
                                          [];
                                      //return SizedBox();
                                      if (subDirs.isEmpty) {
                                        return const SizedBox();
                                      }
                                      return SizedBox(
                                        height: 32,
                                        child: ListView(
                                          physics:
                                              const BouncingScrollPhysics(),
                                          scrollDirection: Axis.horizontal,
                                          children: subDirs
                                              .map((e) => InkWell(
                                                    onTap: (() {
                                                      viewModel
                                                          .setCurrentDirectory(
                                                              e,
                                                              isChild: true);
                                                    }),
                                                    child: Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              right: 8),
                                                      child: Center(
                                                          child: Text(
                                                        e.name!,
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            color: AppTheme
                                                                .accent),
                                                      )),
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 16),
                                                      decoration: BoxDecoration(
                                                          color: AppTheme.accent
                                                              .withOpacity(.05),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      360)),
                                                    ),
                                                  ))
                                              .toList(),
                                        ),
                                      );
                                    })
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Builder(builder: (context) {
                            if (viewModel.normatives.state ==
                                ResourceState.error) {
                              return SliverFillRemaining(
                                child: Center(
                                  child: Text(viewModel.directories.exception ??
                                      "Error"),
                                ),
                              );
                            }
                            final normatives =
                                viewModel.normatives.data?.results ?? [];
                            return SliverPadding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              sliver: SliverList(
                                  delegate: SliverChildBuilderDelegate(
                                      (context, index) {
                                final norm = normatives[index];
                                return NormativeItem(
                                  normative: norm,
                                );
                              }, childCount: normatives.length)),
                            );
                          }),
                          if (viewModel.normatives.data?.totalCount != null &&
                              viewModel.normatives.data!.totalCount > 5)
                            SliverToBoxAdapter(
                              child: Pagination(
                                totalResults:
                                    viewModel.normatives.data?.totalCount ?? 0,
                                currentPage: viewModel.currentPage,
                                onPageChange: (page) =>
                                    viewModel.setCurrentPage(page),
                                pageSize: 5,
                              ),
                            )
                        ],
                      ),
                      if (viewModel.normatives.state == ResourceState.loading)
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
              );
            }));
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }
}
