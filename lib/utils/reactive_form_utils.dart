import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:legalis/model/resource.dart';
import 'package:legalis/model/selectable_item.dart';
import 'package:legalis/theme.dart';
import 'package:legalis/utils/infinite_listview.dart';
import 'package:legalis/utils/selectable_value_accesor.dart';
import 'package:path/path.dart';
import 'package:reactive_flutter_typeahead/reactive_flutter_typeahead.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_range_slider/reactive_range_slider.dart';

String truncateWithEllipsis(int cutoff, String myString) {
  return (myString.length <= cutoff)
      ? myString
      : '${myString.substring(0, cutoff)}...';
}

Widget buildInputControl<T>(String control, {String hint = ""}) {
  return ReactiveTextField(
    formControlName: control,
    decoration: InputDecoration(
      hintText: hint, filled: true,
      isDense: true,
      //isCollapsed: true,
      contentPadding: const EdgeInsets.all(14),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
    ),
  );
}

final typeaheadVA = DefaultValueAccessor();

Widget buildTypeaheadControl<T>(
    String control, Resource<List<SelectableItem<T>>> resource) {
  return Builder(builder: (context) {
    final items = resource.data ?? [];
    final isLoading = resource.state == ResourceState.loading;
    if (isLoading) {
      return const Padding(
        padding: EdgeInsets.all(8),
        child: Center(
          child: CupertinoActivityIndicator(
            radius: 8.0,
            color: CupertinoColors.secondaryLabel,
          ),
        ),
      );
    }
    final formGroup = ReactiveForm.of(context) as FormGroup;
    final formControl = formGroup.control(control);
    return ReactiveTypeAhead<T, SelectableItem<T>>(
        formControlName: control,
        stringify: (item) => item.getLabel(),
        valueAccessor: SelectableValueAccesor<T>(data: items),
        getImmediateSuggestions: false,
        textFieldConfiguration: TextFieldConfiguration(
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              hintText: "Buscar...",
              filled: true,
              isDense: true,
              suffixIcon: formControl.isNotNull
                  ? GestureDetector(
                      onTap: () => formControl.reset(),
                      child: const Icon(
                        CupertinoIcons.clear,
                        size: 14,
                      ),
                    )
                  : const Icon(
                      CupertinoIcons.search,
                      size: 16,
                    ),
              //isCollapsed: true,
              contentPadding: const EdgeInsets.all(12),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none),
            )),
        noItemsFoundBuilder: (context) => const Center(
              child: Text("No se encontraron resultados"),
            ),
        suggestionsBoxDecoration: SuggestionsBoxDecoration(
            elevation: 1.0,
            borderRadius: BorderRadius.circular(5),
            constraints: const BoxConstraints(maxHeight: 300)),
        loadingBuilder: (context) {
          return SpinKitPulse(
            size: 24,
            color: AppTheme.accent,
          );
        },
        itemBuilder: (context, item) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(truncateWithEllipsis(100, item.getLabel()),
                      style: const TextStyle(fontSize: 14)),
                ),
                const SizedBox(
                  width: 4,
                ),
                Text(
                  item.getCount().toString(),
                  style: TextStyle(fontSize: 12, color: AppTheme.accent),
                )
              ],
            ),
          );
        },
        suggestionsCallback: (query) {
          if (query.isNotEmpty) {
            final lower = query.toLowerCase();
            return items
                .where((e) => e.getLabel().toLowerCase().contains(lower))
                .toList()
              ..sort((a, b) => a
                  .getLabel()
                  .toLowerCase()
                  .indexOf(lower)
                  .compareTo(b.getLabel().toLowerCase().indexOf(lower)));
          }
          return items;
        });
  });
}

Widget buildAsyncRadioGroupControl<T>(
    String control, Resource<List<SelectableItem<T>>> resource) {
  return Builder(
    builder: (context) {
      var items = resource.data ?? [];
      var isLoading = resource.state == ResourceState.loading;
      if (isLoading) {
        return const Padding(
          padding: EdgeInsets.all(8),
          child: Center(
            child: CupertinoActivityIndicator(
              radius: 8.0,
              color: CupertinoColors.secondaryLabel,
            ),
          ),
        );
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          ReactiveRadioListTile<T?>(
            activeColor: AppTheme.accent,
            dense: true,
            controlAffinity: ListTileControlAffinity.leading,
            contentPadding: const EdgeInsets.symmetric(horizontal: 4),
            visualDensity: VisualDensity.compact,
            title: const Text(
              "Todos",
              style: TextStyle(fontSize: 14),
            ),
            value: null,
            formControlName: control,
          ),
          InfiniteListView(
            items: items,
            itemBuilder: (item) {
              return ReactiveRadioListTile<T>(
                activeColor: AppTheme.accent,
                dense: true,
                contentPadding: const EdgeInsets.symmetric(horizontal: 4),
                visualDensity: VisualDensity.compact,
                formControlName: control,
                value: item.getValue(),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(truncateWithEllipsis(100, item.getLabel()),
                          style: const TextStyle(fontSize: 14)),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      item.getCount().toString(),
                      style: TextStyle(fontSize: 12, color: AppTheme.accent),
                    )
                  ],
                ),
              );
            },
          )
        ],
      );
    },
  );
}

Widget buildRadioGroupControl<T>(String control, List<SelectableItem<T>> items,
    {paginated = false, useDefault = true}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    mainAxisSize: MainAxisSize.max,
    children: [
      if (useDefault)
        ReactiveRadioListTile<T?>(
          activeColor: AppTheme.accent,
          dense: true,
          controlAffinity: ListTileControlAffinity.leading,
          contentPadding: const EdgeInsets.symmetric(horizontal: 4),
          visualDensity: VisualDensity.compact,
          title: const Text(
            "Todos",
            style: TextStyle(fontSize: 14),
          ),
          value: null,
          formControlName: control,
        ),
      InfiniteListView(
        items: items,
        itemBuilder: (item) {
          return ReactiveRadioListTile<T>(
            activeColor: AppTheme.accent,
            dense: true,
            contentPadding: const EdgeInsets.symmetric(horizontal: 4),
            visualDensity: VisualDensity.compact,
            formControlName: control,
            value: item.getValue(),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(truncateWithEllipsis(100, item.getLabel()),
                      style: const TextStyle(fontSize: 14)),
                ),
                const SizedBox(
                  width: 4,
                ),
                if (item.getCount() != null)
                  Text(
                    item.getCount().toString(),
                    style: TextStyle(fontSize: 12, color: AppTheme.accent),
                  )
              ],
            ),
          );
        },
      )
    ],
  );
}

Widget buildDropdownControl<T>(String control, Iterable<T> items,
    {String hint = "Seleccionar"}) {
  return Builder(
    builder: (context) {
      final formGroup = ReactiveForm.of(context) as FormGroup;
      final formControl = formGroup.control(control);
      return ReactiveDropdownField<T>(
          formControlName: control,
          hint: Text(hint),
          isExpanded: true,
          icon: formControl.isNotNull
              ? GestureDetector(
                  onTap: () => formControl.reset(),
                  child: const Icon(
                    CupertinoIcons.clear,
                    size: 14,
                  ),
                )
              : const Icon(
                  CupertinoIcons.chevron_down,
                  size: 14,
                ),
          borderRadius: BorderRadius.circular(4),
          menuMaxHeight: 300,
          focusColor: AppTheme.accent,
          decoration: InputDecoration(
            filled: true,
            isDense: true,
            contentPadding: const EdgeInsets.all(12),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none),
          ),
          items: [
            for (var item in items)
              DropdownMenuItem<T>(value: item, child: Text(item.toString()))
          ]);
    },
  );
}

Widget buildAsyncDropdownControl<T>(String control, Resource<List<T>> resource,
    {String hint = "Seleccionar"}) {
  return Builder(
    builder: (context) {
      final formGroup = ReactiveForm.of(context) as FormGroup;
      final formControl = formGroup.control(control);
      var isLoading = resource.state == ResourceState.loading;
      var items = resource.data ?? [];
      return ReactiveDropdownField<T>(
          formControlName: control,
          hint: Text(hint),
          isExpanded: true,
          icon: formControl.isNotNull
              ? GestureDetector(
                  onTap: () => formControl.reset(),
                  child: const Icon(
                    CupertinoIcons.clear,
                    size: 14,
                  ),
                )
              : const Icon(
                  CupertinoIcons.chevron_down,
                  size: 14,
                ),
          borderRadius: BorderRadius.circular(4),
          readOnly: isLoading,
          menuMaxHeight: 300,
          focusColor: AppTheme.accent,
          decoration: InputDecoration(
            filled: true,
            isDense: true,
            //isCollapsed: true,
            contentPadding: const EdgeInsets.all(12),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none),
          ),
          items: [
            for (var item in items)
              DropdownMenuItem<T>(value: item, child: Text(item.toString()))
          ]);
    },
  );
}

Widget buildRangeControl(String control,
    {double min = 0, double max = 0, int divisions = 1}) {
  return ReactiveRangeSlider<RangeValues>(
    activeColor: AppTheme.accent,
    inactiveColor: CupertinoColors.lightBackgroundGray,
    formControlName: control,
    min: min,
    max: max,
    divisions: divisions,
    labelBuilder: (values) => RangeLabels(
      values.start.round().toString(),
      values.end.round().toString(),
    ),
    decoration:
        const InputDecoration(isCollapsed: true, border: InputBorder.none),
  );
}

Widget buildLabel(String label) {
  return Column(
    children: [
      const SizedBox(
        height: 8,
      ),
      Text(
        label,
        style: const TextStyle(
            fontSize: 12, color: CupertinoColors.secondaryLabel),
      ),
      const SizedBox(
        height: 4,
      ),
    ],
  );
}
