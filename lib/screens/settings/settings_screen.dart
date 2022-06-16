import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:legalis/screens/settings/settings_viewmodel.dart';
import 'package:legalis/theme.dart';
import 'package:provider/provider.dart';
import 'package:routemaster/routemaster.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final viewModel = SettingsViewModel();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: viewModel,
      builder: (context, _) => Consumer<SettingsViewModel>(
        builder: (context, value, child) => Material(
          child: CupertinoPageScaffold(
            backgroundColor: AppTheme.backgroundColor,
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverSafeArea(
                  sliver: SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 16,
                          ),
                          Text(
                            "Más opciones".toUpperCase(),
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    //margin: const EdgeInsets.symmetric(horizontal: 16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        //color: Colors.black12.withOpacity(.1),
                        borderRadius: BorderRadius.circular(8)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 8,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.black12.withOpacity(.05)),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(8),
                            onTap: () => Routemaster.of(context)
                                .push("/settings/glossary"),
                            child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Row(
                                  children: const [
                                    Expanded(
                                        child: Text(
                                      "Glosario de Términos",
                                      style: TextStyle(fontSize: 14),
                                    )),
                                    Icon(
                                      CupertinoIcons.chevron_right,
                                      size: 16,
                                    )
                                  ],
                                )),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.black12.withOpacity(.05)),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(8),
                            onTap: () =>
                                Routemaster.of(context).push("/settings/help"),
                            child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Row(
                                  children: const [
                                    Expanded(
                                        child: Text(
                                      "Como buscar",
                                      style: TextStyle(fontSize: 14),
                                    )),
                                    Icon(
                                      CupertinoIcons.chevron_right,
                                      size: 16,
                                    )
                                  ],
                                )),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.black12.withOpacity(.05)),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(8),
                            onTap: () =>
                                Routemaster.of(context).push("/settings/about"),
                            child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Row(
                                  children: const [
                                    Expanded(
                                        child: Text(
                                      "Sobre Legalis",
                                      style: TextStyle(fontSize: 14),
                                    )),
                                    Icon(
                                      CupertinoIcons.chevron_right,
                                      size: 16,
                                    )
                                  ],
                                )),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.black12.withOpacity(.05)),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Row(
                              children: const [
                                Expanded(
                                    child: Text(
                                  "Contactar",
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                )),
                                Icon(
                                  CupertinoIcons.chevron_right,
                                  size: 16,
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
