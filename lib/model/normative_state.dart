import 'package:legalis/model/selectable_item.dart';

class NormativeState extends SelectableItem<String> {
  String state;
  int count;
  NormativeState(this.state, this.count);

  factory NormativeState.fromMap(Map<String, dynamic> data) {
    return NormativeState(data['state'], data['count']);
  }

  @override
  String getLabel() => state;

  @override
  String getValue() => state;

  @override
  int? getCount() => count;
}
