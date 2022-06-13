import 'package:flutter/cupertino.dart';
import 'package:legalis/widget/action_icon.dart';

class InfiniteListView extends StatefulWidget {
  final List<dynamic> items;
  final Widget Function(dynamic) itemBuilder;

  const InfiniteListView(
      {required this.itemBuilder, required this.items, Key? key})
      : super(key: key);

  @override
  State<InfiniteListView> createState() => _InfiniteListViewState();
}

class _InfiniteListViewState extends State<InfiniteListView> {
  int pageSize = 10;

  List get items {
    if (widget.items.length > pageSize) {
      return widget.items.sublist(0, pageSize);
    }
    return widget.items;
  }

  showMore() {
    setState(() {
      pageSize += 10;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          primary: false,
          shrinkWrap: true,
          itemCount: items.length,
          itemBuilder: (context, index) {
            var item = items[index];
            return widget.itemBuilder(item);
          },
        ),
        if (items.length >= pageSize)
          Center(
              child: ActionIcon(
            onClick: () => showMore(),
            icon: CupertinoIcons.chevron_down,
          ))
      ],
    );
  }
}
