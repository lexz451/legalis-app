import 'package:legalis/model/selectable_item.dart';

class GazetteType extends SelectableItem<String> {
  String type;
  int count;

  GazetteType(this.type, this.count);

  factory GazetteType.fromMap(Map<String, dynamic> data) {
    return GazetteType(data['type'], data['count']);
  }

  @override
  int? getCount() => count;

  @override
  String getLabel() => type;

  @override
  String getValue() => type;
}
