import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:legalis/main.dart';
import 'package:legalis/model/search_option.dart';
import 'package:legalis/screens/app_viewmodel.dart';
import 'package:legalis/theme.dart';
import 'package:legalis/utils/reactive_form_utils.dart';
import 'package:provider/provider.dart';
import 'package:reactive_forms/reactive_forms.dart';

// ignore: must_be_immutable
class SearchFilters extends StatefulWidget {
  final Function? onSubmit;
  final Map<String, dynamic> params;

  bool showGazetteTypeFilter;
  bool showNormativeStateFilter;
  bool showTextFilter;

  SearchFilters(
      {required this.onSubmit,
      required this.params,
      this.showGazetteTypeFilter = false,
      this.showNormativeStateFilter = true,
      this.showTextFilter = true,
      Key? key})
      : super(key: key);

  @override
  State<SearchFilters> createState() => _SearchFiltersState();
}

class _SearchFiltersState extends State<SearchFilters> {
  final _years = [for (var i = 1990; i < DateTime.now().year + 1; i++) i];

  final _searchOptions = [
    SearchOption("En el nombre", "name"),
    SearchOption("En el texto", "text"),
    SearchOption("En el sumario", "summary")
  ];

  final _form = FormGroup({
    'year': FormControl<int>(),
    'yearRange': FormControl<RangeValues>(),
    'year_gte': FormControl<int>(),
    'year_lte': FormControl<int>(),
    'organism': FormControl<String>(),
    'state': FormControl<String>(),
    'tematica': FormControl<String>(),
    'search_field': FormControl<String>(value: 'name'),
    'inclusive_search': FormControl<String>(),
    'exclusive_search': FormControl<String>(),
    'text': FormControl<String>(),
    'type': FormControl<String>()
  });

  final _controller = ExpandableController(initialExpanded: false);

  @override
  void initState() {
    super.initState();
    _form.control('year').valueChanges.listen((year) {
      _form.control('yearRange').reset(emitEvent: false);
      _form.control('year_lte').reset();
      _form.control('year_gte').reset();
    });
    _form.control('yearRange').valueChanges.listen((range) {
      if (range != null) {
        var r = range as RangeValues;
        var start = r.start;
        var end = r.end;
        _form.control('year_lte').updateValue(start);
        _form.control('year_gte').updateValue(end);
      }
      if (_form.control('year').value != null) {
        _form.control('year').reset(emitEvent: false);
      }
    });
    _form.control('inclusive_search').valueChanges.listen((value) {
      _form.control("text").updateValue('"$value"');
    });
    _form.control('exclusive_search').valueChanges.listen((value) {
      _form.control("text").updateValue("$value");
    });
    _form.control('tematica').patchValue(widget.params['tematica']);
  }

  _onSubmit() {
    LOGGER.d("Advanced filters form submitted");
    //LOGGER.d(_form.value);
    _controller.toggle();
    widget.onSubmit!(_form.value);
  }

  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
        child: Card(
      margin: const EdgeInsets.all(0),
      elevation: 0,
      child: Padding(
          padding: const EdgeInsets.all(8),
          child: ExpandablePanel(
            controller: _controller,
            theme: ExpandableThemeData(
                hasIcon: false,
                inkWellBorderRadius: BorderRadius.circular(2),
                alignment: Alignment.center,
                iconPadding: const EdgeInsets.all(0),
                headerAlignment: ExpandablePanelHeaderAlignment.center),
            header: Center(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    const Text(
                      "FILTROS DE BÚSQUEDA",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Icon(CupertinoIcons.chevron_down,
                        size: 14, color: AppTheme.accent)
                  ],
                ),
              ),
            ),
            collapsed: const SizedBox(
              height: 0,
            ),
            expanded: ReactiveForm(
              formGroup: _form,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Divider(
                      color: CupertinoColors.separator,
                    ),
                    buildLabel("Año"),
                    buildDropdownControl<int>('year', _years),
                    buildLabel("Período"),
                    buildRangeControl('yearRange',
                        min: _years[0].toDouble(),
                        max: _years[_years.length - 1].toDouble(),
                        divisions: _years[_years.length - 1] - _years[0]),
                    const Divider(
                      height: 32,
                      color: CupertinoColors.separator,
                    ),
                    buildLabel("Emisor"),
                    Consumer<AppViewModel>(
                      builder: (context, vm, child) =>
                          buildAsyncDropdownControl<String>(
                              'organism', vm.organisms),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const Divider(
                      height: 32,
                      color: CupertinoColors.separator,
                    ),
                    if (widget.showNormativeStateFilter)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildLabel('Estado'),
                          Consumer<AppViewModel>(
                            builder: (context, vm, child) =>
                                buildAsyncRadioGroupControl<String>(
                                    'state', vm.states),
                          ),
                          const Divider(
                            height: 32,
                            color: CupertinoColors.separator,
                          ),
                        ],
                      ),
                    if (widget.showGazetteTypeFilter)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildLabel('Edición'),
                          Consumer<AppViewModel>(
                            builder: (context, vm, child) =>
                                buildAsyncRadioGroupControl<String>(
                                    'type', vm.editions),
                          ),
                          const Divider(
                            height: 32,
                            color: CupertinoColors.separator,
                          ),
                        ],
                      ),
                    buildLabel('Temática'),
                    // Consumer<AppViewModel>(
                    //   builder: (context, vm, child) =>
                    //       buildAsyncRadioGroupControl<String>(
                    //           'tematica', vm.thematics),
                    // ),
                    Consumer<AppViewModel>(
                      builder: (context, vm, child) =>
                          buildTypeaheadControl("tematica", vm.thematics),
                    ),

                    const Divider(
                      height: 32,
                      color: CupertinoColors.separator,
                    ),
                    if (widget.showTextFilter)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildLabel('Palabras y frases'),
                          buildRadioGroupControl<String>(
                              'search_field', _searchOptions),
                          const SizedBox(
                            height: 8,
                          ),
                          buildInputControl('inclusive_search',
                              hint: "Con esta palabra o frase"),
                          const SizedBox(
                            height: 12,
                          ),
                          buildInputControl('exclusive_search',
                              hint: "Con alguna de estas palabras"),
                        ],
                      ),
                    const SizedBox(
                      height: 12,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CupertinoButton(
                              minSize: 38,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 0),
                              child: const Text(
                                "LIMPIAR FILTROS",
                                style: TextStyle(fontSize: 14),
                              ),
                              onPressed: () => _form.reset()),
                          CupertinoButton.filled(
                              minSize: 38,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 0),
                              child: Row(
                                children: const [
                                  Icon(
                                    CupertinoIcons.search,
                                    size: 20,
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    "BUSCAR",
                                    style: TextStyle(fontSize: 14),
                                  )
                                ],
                              ),
                              onPressed: () => _onSubmit())
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )),
    ));
  }
}
