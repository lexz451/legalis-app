import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:legalis/model/selectable_item.dart';

class RadioGroup extends StatefulWidget {
  const RadioGroup({Key? key, required this.items}) : super(key: key);

  final List<SelectableItem> items;

  @override
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
                  title: Text(e.label),
                  groupValue: groupValue,
                  value: e.value,
                  onChanged: (value) => _setGroupValue(value),
                ))
            .toList()
      ],
    );
  }
}
