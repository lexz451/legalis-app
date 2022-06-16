abstract class SelectableItem<T> {
  String getLabel();
  T getValue();
  int? getCount();

  @override
  String toString() => getLabel();
}
