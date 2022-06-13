import 'package:flutter/material.dart';
import 'package:legalis/model/selectable_item.dart';

class RadioGroup extends StatefulWidget {
  const RadioGroup({Key? key, required this.items, required this.showDefault})
      : super(key: key);

  final List<SelectableItem> items;
  final bool showDefault;

  @override
  // ignore: library_private_types_in_public_api
  _RadioGroupState createState() => _RadioGroupState();
}

class _RadioGroupState extends State<RadioGroup> {
  dynamic groupValue = -1;

  List<SelectableItem> _items() {
    return widget.items;
  }

  _setGroupValue(value) {
    setState(() {
      groupValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.showDefault)
          RadioListTile(
            dense: true,
            contentPadding: const EdgeInsets.symmetric(horizontal: 4),
            visualDensity: VisualDensity.compact,
            title: const Text("Todas"),
            groupValue: groupValue,
            value: -1,
            onChanged: (value) => _setGroupValue(value),
          ),
        ..._items()
            .map((e) => RadioListTile<dynamic>(
                  dense: true,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 4),
                  visualDensity: VisualDensity.compact,
                  //title: Text(e.label),
                  groupValue: groupValue,
                  value: 0,
                  onChanged: (value) => _setGroupValue(value),
                ))
            .toList()
      ],
    );
  }
}
