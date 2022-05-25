import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:legalis/model/resource.dart';
import 'package:legalis/screens/app_viewmodel.dart';
import 'package:legalis/screens/bookmarks/bookmarks_viewmodel.dart';
import 'package:legalis/theme.dart';
import 'package:legalis/widget/normative_item.dart';
import 'package:provider/provider.dart';

class Bookmarks extends StatefulWidget {
  const Bookmarks({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BookmarksState();
}

class _BookmarksState extends State<Bookmarks> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppViewModel>(
      builder: (context, value, child) => Material(
        child: CupertinoPageScaffold(
          backgroundColor: AppTheme.backgroundColor,
          child: Stack(
            children: [
              CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: const [
                          SizedBox(
                            height: 16,
                          ),
                          Text(
                            "FAVORITOS",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Builder(
                    builder: (context) {
                      if (value.bookmarks.state == ResourceState.loading) {
                        return const SliverFillRemaining(
                          child: Center(
                              child: SizedBox(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator(strokeWidth: 4.0),
                          )),
                        );
                      } else if (value.bookmarks.state == ResourceState.error) {
                        return SliverFillRemaining(
                          child: Center(
                            child: Text(value.bookmarks.exception ?? "Error"),
                          ),
                        );
                      }

                      return SliverPadding(
                        padding: const EdgeInsets.all(16),
                        sliver: SliverList(
                          delegate:
                              SliverChildBuilderDelegate((context, index) {
                            final item = value.bookmarks.data![index];
                            return NormativeItem(
                              normative: item,
                              showRemove: true,
                              showBookmark: false,
                            );
                          }, childCount: value.bookmarks.data?.length ?? 0),
                        ),
                      );
                    },
                  )
                ],
              ),
              if (value.bookmarks.state == ResourceState.loading)
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
    );
  }
}
