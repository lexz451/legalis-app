import 'package:legalis/model/selectable_item.dart';
import 'package:reactive_forms/reactive_forms.dart';

class SelectableValueAccesor<T>
    extends ControlValueAccessor<T, SelectableItem<T>> {
  final List<SelectableItem<T>> data;

  SelectableValueAccesor({required this.data}) : super();

  @override
  SelectableItem<T>? modelToViewValue(T? modelValue) {
    return modelValue == null
        ? null
        : data.firstWhere((e) => e.getValue() == modelValue);
  }

  @override
  T? viewToModelValue(SelectableItem<T>? viewValue) {
    return viewValue?.getValue();
  }
}
