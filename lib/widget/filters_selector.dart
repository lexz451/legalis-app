import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:legalis/model/gazette_type.dart';
import 'package:legalis/model/selectable_item.dart';
import 'package:legalis/model/topic.dart';
import 'package:legalis/theme.dart';
import 'package:legalis/widget/radiogroup.dart';

class FiltersSelector extends StatefulWidget {
  const FiltersSelector({Key? key, this.gazetteTypes, this.topics})
      : super(key: key);

  final List<GazetteType>? gazetteTypes;
  final List<Topic>? topics;

  @override
  // ignore: library_private_types_in_public_api
  _FiltersSelectorState createState() => _FiltersSelectorState();
}

class _FiltersSelectorState extends State<FiltersSelector> {
  final _years = [for (var i = 1990; i < DateTime.now().year + 1; i++) i];
  RangeValues _rangeYearValues =
      RangeValues(1995, DateTime.now().year.toDouble());

  List<SelectableItem> _mapGazetteTypes() => [];
  /*widget.gazetteTypes
          ?.map((e) => SelectableItem(e.type, e.type))
          .toList() ??
      [];*/

  List<SelectableItem> _mapTopics() => [];
  //widget.topics?.map((e) => SelectableItem(e.name, e.name)).toList() ?? [];

  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
        child: Card(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      elevation: .5,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        child: ExpandablePanel(
          theme: const ExpandableThemeData(
              hasIcon: false,
              useInkWell: false,
              alignment: Alignment.center,
              iconPadding: EdgeInsets.all(0),
              headerAlignment: ExpandablePanelHeaderAlignment.center),
          header: Center(
              child: Column(
            children: [
              Text("Filtros de búsqueda".toUpperCase(),
                  style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 14,
                      fontWeight: FontWeight.w500)),
              Icon(
                Icons.keyboard_arrow_down_rounded,
                color: AppTheme.accent,
              )
            ],
          )),
          collapsed: const SizedBox(),
          expanded: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Divider(
                color: Colors.black38,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                "Tipos de Edición".toUpperCase(),
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
              ),
              const SizedBox(
                height: 8,
              ),
              RadioGroup(
                items: _mapGazetteTypes(),
                showDefault: true,
              ),
              const Divider(
                color: Colors.black12,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                "Año de publicación".toUpperCase(),
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
              ),
              const SizedBox(
                height: 14,
              ),
              const Text(
                "Seleccione el año",
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8)),
                child: DropdownButton<int>(
                    isExpanded: true,
                    menuMaxHeight: 300,
                    underline: const SizedBox(),
                    isDense: true,
                    hint: const Text("Seleccionar"),
                    items: [
                      ..._years
                          .map((e) => DropdownMenuItem<int>(
                                value: e,
                                child: Text(e.toString()),
                              ))
                          .toList()
                    ],
                    onChanged: (value) {}),
              ),
              const SizedBox(
                height: 8,
              ),
              const Text(
                "Seleccione el período",
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
              RangeSlider(
                values: _rangeYearValues,
                min: _years[0].toDouble(),
                max: _years[_years.length - 1].toDouble(),
                divisions: _years[_years.length - 1] - _years[0],
                labels: RangeLabels(_rangeYearValues.start.round().toString(),
                    _rangeYearValues.end.round().toString()),
                onChanged: (values) {
                  setState(() {
                    _rangeYearValues = values;
                  });
                },
              ),
              const Divider(
                color: Colors.black12,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                "Temáticas".toUpperCase(),
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
              ),
              const SizedBox(
                height: 8,
              ),
              RadioGroup(
                items: _mapTopics(),
                showDefault: true,
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
