import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:legalis/model/normative.dart';
import 'package:legalis/model/resource.dart';
import 'package:legalis/screens/popular/popular_normatives_viewmodel.dart';
import 'package:legalis/theme.dart';
import 'package:legalis/widget/normative_item.dart';
import 'package:provider/provider.dart';
import 'package:routemaster/routemaster.dart';

class PopularNormativeScreen extends StatefulWidget {
  const PopularNormativeScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _PopularNormativeScreenState createState() => _PopularNormativeScreenState();
}

class _PopularNormativeScreenState extends State<PopularNormativeScreen> {
  final viewModel = PopularNormativeViewModel();

  @override
  void initState() {
    super.initState();
    viewModel.fetchPopularNorms();
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
          child: Consumer<PopularNormativeViewModel>(
            builder: (context, value, child) => Stack(
              children: [
                CustomScrollView(
                  slivers: [
                    SliverSafeArea(
                      sliver: Builder(builder: (_) {
                        final items = viewModel.popular.data ?? [];
                        return SliverPadding(
                          padding: const EdgeInsets.all(16),
                          sliver: SliverList(
                              delegate:
                                  SliverChildBuilderDelegate((context, index) {
                            final item = items[index];
                            return NormativeItem(normative: item);
                          }, childCount: items.length)),
                        );
                      }),
                    )
                  ],
                ),
                if (viewModel.popular.state == ResourceState.loading)
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
