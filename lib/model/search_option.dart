import 'package:legalis/model/selectable_item.dart';

class SearchOption extends SelectableItem<String> {
  String label;
  String value;

  SearchOption(this.label, this.value);

  @override
  int? getCount() => null;

  @override
  String getLabel() => label;

  @override
  getValue() => value;
}
