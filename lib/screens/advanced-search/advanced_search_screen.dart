import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:legalis/di.dart';
import 'package:legalis/main.dart';
import 'package:legalis/model/search_option.dart';
import 'package:legalis/repositories/normative_repository.dart';
import 'package:legalis/screens/advanced-search/advanced_search_viewmodel.dart';
import 'package:legalis/screens/app_viewmodel.dart';
import 'package:legalis/theme.dart';
import 'package:legalis/utils/reactive_form_utils.dart';
import 'package:legalis/widget/search_filters.dart';
import 'package:provider/provider.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:routemaster/routemaster.dart';

class AdvancedSearchScreen extends StatefulWidget {
  const AdvancedSearchScreen({Key? key}) : super(key: key);

  @override
  State<AdvancedSearchScreen> createState() => _AdvancedSearchScreenState();
}

class _AdvancedSearchScreenState extends State<AdvancedSearchScreen> {
  final viewModel = AdvancedSearchViewModel();
  final normativeRepository = getIt<NormativeRepository>();

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
    'text': FormControl<String>()
  });

  //get organisms$ => _normativeRepository.getNormativeOrganisms();
  //get states$ => _normativeRepository.getNormativeStates();
  //get thematics$ => _normativeRepository.getNormativeThematics();

  _onSubmit() {
    final _values = _form.value;
    Routemaster.of(context).push('/dashboard/search-results', queryParameters: {
      'year': "${_values['year'] ?? ''}",
      'year_gte': "${_values['year_gte'] ?? ''}",
      'year_lte': "${_values['year_lte'] ?? ''}",
      'organism': "${_values['organism'] ?? ''}",
      'state': "${_values['state'] ?? ''}",
      'tematica': "${_values['tematica'] ?? ''}",
      'search_field': "${_values['search_field'] ?? ''}",
      'text': "${_values['text'] ?? ''}"
    });
  }

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
        var _range = range as RangeValues;
        var start = _range.start;
        var end = _range.end;
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
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: AppTheme.backgroundColor,
      navigationBar: CupertinoNavigationBar(
        border: null,
        backgroundColor: AppTheme.backgroundColor.withOpacity(.25),
        leading: GestureDetector(
          onTap: () {
            Routemaster.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back_rounded,
            size: 28,
            color: AppTheme.primary,
          ),
        ),
      ),
      child: Stack(
        children: [
          CustomScrollView(slivers: [
            SliverSafeArea(
                sliver: SliverToBoxAdapter(
                    child: Card(
              elevation: .0,
              margin: const EdgeInsets.all(16),
              child: ReactiveForm(
                formGroup: _form,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 8,
                      ),
                      buildLabel("Año"),
                      buildDropdownControl<int>('year', _years),
                      const SizedBox(
                        height: 8,
                      ),
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
                      buildLabel('Estado'),
                      Consumer<AppViewModel>(
                        builder: (context, vm, child) =>
                            buildAsyncRadioGroupControl<String>(
                                'state', vm.states),
                      ),
                      //buildAsyncRadioGroupControl<String>(
                      //    'state', states$),
                      const SizedBox(
                        height: 8,
                      ),
                      const Divider(
                        height: 32,
                        color: CupertinoColors.separator,
                      ),
                      buildLabel('Temática'),
                      Consumer<AppViewModel>(
                        builder: (context, vm, child) =>
                            buildAsyncRadioGroupControl<String>(
                                'tematica', vm.thematics),
                      ),
                      const Divider(
                        height: 32,
                        color: CupertinoColors.separator,
                      ),
                      buildLabel('Palabras y frases'),
                      buildRadioGroupControl<String>(
                          'search_field', _searchOptions,
                          useDefault: false),
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
                      const SizedBox(
                        height: 12,
                      ),
                    ],
                  ),
                ),
              ),
            ))),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
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
                      borderRadius: BorderRadius.circular(4),
                      minSize: 38,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 0),
                      onPressed: () => _onSubmit(),
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
                    )
                  ],
                ),
              ),
            )
          ]),
          if (viewModel.isLoading)
            Positioned(
                top: 0,
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppTheme.primary.withOpacity(0.1),
                  ),
                  child: Center(
                    child: SpinKitPulse(
                      size: 24,
                      color: AppTheme.accent,
                    ),
                  ),
                ))
        ],
      ),
    );
  }
}
