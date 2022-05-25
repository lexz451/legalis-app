import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:legalis/model/resource.dart';
import 'package:legalis/model/selectable_item.dart';
import 'package:legalis/theme.dart';
import 'package:legalis/utils/infinite_listview.dart';
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
      contentPadding: const EdgeInsets.all(12),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
    ),
  );
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
            visualDensity: VisualDensity.adaptivePlatformDensity,
            title: const Text("Todos"),
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
          visualDensity: VisualDensity.adaptivePlatformDensity,
          title: const Text("Todos"),
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
  return ReactiveDropdownField<T>(
      formControlName: control,
      hint: Text(hint),
      isExpanded: true,
      icon: const Icon(
        CupertinoIcons.chevron_down,
        size: 14,
      ),
      borderRadius: BorderRadius.circular(4),
      menuMaxHeight: 300,
      focusColor: Colors.transparent,
      decoration: InputDecoration(
        filled: true,
        isDense: true,
        isCollapsed: true,
        contentPadding: const EdgeInsets.all(10),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none),
      ),
      items: [
        for (var item in items)
          DropdownMenuItem<T>(child: Text(item.toString()), value: item)
      ]);
}

Widget buildAsyncDropdownControl<T>(String control, Resource<List<T>> resource,
    {String hint = "Seleccionar"}) {
  return Builder(
    builder: (context) {
      var isLoading = resource.state == ResourceState.loading;
      var items = resource.data ?? [];
      return ReactiveDropdownField<T>(
          formControlName: control,
          hint: Text(hint),
          isExpanded: true,
          icon: isLoading
              ? const CupertinoActivityIndicator(
                  radius: 8.0,
                  color: CupertinoColors.secondaryLabel,
                )
              : const Icon(
                  CupertinoIcons.chevron_down,
                  size: 14,
                ),
          borderRadius: BorderRadius.circular(4),
          menuMaxHeight: 300,
          focusColor: Colors.transparent,
          decoration: InputDecoration(
            filled: true,
            isDense: true,
            //isCollapsed: true,
            contentPadding: const EdgeInsets.all(10),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none),
          ),
          items: [
            for (var item in items)
              DropdownMenuItem<T>(child: Text(item.toString()), value: item)
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
