import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:legalis/layout/widgets/normative_item.dart';
import 'package:legalis/model/response.dart';
import 'package:legalis/provider/directory_viewmodel.dart';
import 'package:legalis/theme.dart';
import 'package:provider/provider.dart';
import 'package:routemaster/routemaster.dart';

class DirectoryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DirectoryPageState();
}

class _DirectoryPageState extends State<DirectoryPage> {
  Widget _buildNormativeList() {
    return Consumer<DirectoryViewModel>(
      builder: (context, state, _) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 18),
          child: Builder(
            builder: (_) {
              if (state.normatives.state == ResponseState.LOADING) {
                return Container(
                  height: 200,
                  child: Center(
                    child: CupertinoActivityIndicator(
                      radius: 12,
                    ),
                  ),
                );
              }
              if (state.normatives.state == ResponseState.ERROR) {
                return Center(
                  child: Text(
                    state.normatives.exception!,
                    style: AppTheme.errorTextStyle,
                  ),
                );
              }
              var _normatives = state.normatives.data?.results ?? [];
              return ListView.separated(
                physics: ScrollPhysics(),
                shrinkWrap: true,
                separatorBuilder: (_, __) => SizedBox(
                  height: 8,
                ),
                itemBuilder: (context, index) {
                  var _item = _normatives[index];
                  return NormativeItem(normative: _item);
                },
                itemCount: _normatives.length,
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildDirectoryBreadcrumb() {
    return Consumer<DirectoryViewModel>(
      builder: (context, state, _) {
        return Container(
          margin: EdgeInsets.only(left: 18, right: 18, bottom: 18),
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.start,
            children: [
              Text(
                state.selectedDirectory?.name ?? "",
                style: TextStyle(
                    fontSize: 18,
                    color: AppTheme.deepBlue,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _buildSubdirectorySelector() {
    return Consumer<DirectoryViewModel>(builder: (context, value, child) {
      var _current = value.selectedDirectory;
      var _children = (_current?.children ?? []).take(10);
      return Container(
        padding: EdgeInsets.only(left: 18, right: 18, bottom: 18),
        child: Wrap(
          runSpacing: 8,
          children: [
            ..._children
                .map((e) => Container(
                      margin: EdgeInsets.only(right: 8),
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: CupertinoColors.quaternarySystemFill,
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                      child: Text(
                        e.name,
                        style: TextStyle(
                            color: AppTheme.deepBlue,
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                        textAlign: TextAlign.center,
                      ),
                    ))
                .toList()
          ],
        ),
      );
    });
  }

  Widget _buildDirectoryDialog() {
    return Container(
      padding: EdgeInsets.all(18),
      margin: EdgeInsets.only(left: 18, right: 18, top: 48, bottom: 8),
      decoration: BoxDecoration(
          color: AppTheme.deepBlue,
          borderRadius: BorderRadius.all(Radius.circular(8))),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Stack(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () => Routemaster.of(context).pop(),
                  child: Icon(
                    CupertinoIcons.clear_circled,
                    color: CupertinoColors.white,
                    size: 22,
                  ),
                ),
              )
            ],
          ),
          Expanded(child: Consumer<DirectoryViewModel>(
            builder: (context, state, _) {
              var size = MediaQuery.of(context).size;
              var itemWidth = size.width / 3;
              var itemHeight = 100;
              var _directories = state.directories.data ?? [];
              return GridView.builder(
                shrinkWrap: true,
                primary: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: itemWidth / itemHeight),
                itemBuilder: (context, index) {
                  var _item = _directories[index];
                  var _selectedColor = _item.id == state.selectedDirectory?.id
                      ? AppTheme.accentColor
                      : CupertinoColors.white;
                  return GestureDetector(
                    onTap: () {
                      state.onDirectorySelected(_item);
                      Routemaster.of(context).pop();
                    },
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          _item.icon != null
                              ? SvgPicture.string(
                                  _item.icon!,
                                  width: 24,
                                  height: 24,
                                  color: _selectedColor,
                                )
                              : Icon(
                                  CupertinoIcons.exclamationmark_circle,
                                  color: _selectedColor,
                                  size: 24,
                                ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            _item.name,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(fontSize: 12, color: _selectedColor),
                          )
                        ],
                      ),
                    ),
                  );
                },
                itemCount: _directories.length,
              );
            },
          ))
        ],
      ),
    );
  }

  Widget _buildDirectorySelector(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(18),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: AppTheme.deepBlue,
          borderRadius: BorderRadius.all(Radius.circular(8))),
      child: GestureDetector(
        onTap: () {
          showCupertinoDialog(
              useRootNavigator: false,
              context: context,
              builder: (_) {
                var _child = _buildDirectoryDialog();
                return ChangeNotifierProvider<DirectoryViewModel>.value(
                  value: Provider.of<DirectoryViewModel>(context),
                  child: _child,
                );
              });
        },
        child: Row(
          children: [
            Expanded(
                child: Text(
              "DIRECTORIOS",
              style: TextStyle(fontWeight: FontWeight.w700),
            )),
            Icon(
              CupertinoIcons.chevron_down,
              color: CupertinoColors.white,
              size: 18,
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DirectoryViewModel()..loadDirectories(),
      child: Consumer<DirectoryViewModel>(
        builder: (context, state, _) {
          return CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              leading: GestureDetector(
                onTap: () => Routemaster.of(context).pop(),
                child: Icon(
                  CupertinoIcons.chevron_left,
                  size: 20,
                ),
              ),
              middle: Text("Directorio Temático"),
            ),
            child: ListView(
              children: [
                _buildDirectorySelector(context),
                _buildDirectoryBreadcrumb(),
                _buildSubdirectorySelector(),
                _buildNormativeList()
              ],
            ),
          );
        },
      ),
    );
  }
}
