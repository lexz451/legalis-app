import 'package:legalis/model/selectable_item.dart';

class NormativeThematic extends SelectableItem<String> {
  int count;
  String name;

  NormativeThematic(this.name, this.count);

  factory NormativeThematic.fromMap(Map<String, dynamic> data) {
    return NormativeThematic(data['name'], data['count']);
  }

  @override
  int? getCount() => count;

  @override
  String getLabel() => name;

  @override
  getValue() => name;
}
