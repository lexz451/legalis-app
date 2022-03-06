import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:legalis/model/resource.dart';
import 'package:legalis/state/app_viewmodel.dart';
import 'package:legalis/state/bookmarks_viewmodel.dart';
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
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 52,
                      ),
                      const Text(
                        "Favoritos",
                        style: TextStyle(
                            fontSize: 32, fontWeight: FontWeight.bold),
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
                      delegate: SliverChildBuilderDelegate((context, index) {
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
        ),
      ),
    );
  }
}
