import 'package:flutter/material.dart';
import 'package:legalis/main.dart';
import 'package:legalis/screens/dashboard/dashboard_viewmodel.dart';
import 'package:legalis/theme.dart';
import 'package:legalis/widget/search_box.dart';
import 'package:provider/provider.dart';
import 'package:routemaster/routemaster.dart';
import 'package:url_launcher/url_launcher.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final viewModel = DashboardViewModel();

  final mainRoutes = {
    'advanced-search': 'Búsqueda Avanzada',
    'directories': 'Directorio Temático',
    'gazettes': 'Indice de Gacetas',
    'recent': 'Normativa Reciente',
    'popular': 'Normas más consultadas',
  };

  @override
  void initState() {
    super.initState();
    viewModel.fetchNews();
  }

  _launchUrl(item) async {
    final url = Uri.parse("https://eltoque.com/${item['slug']}");
    try {
      await launchUrl(url);
    } catch (e) {
      LOGGER.i(e);
    }
  }

  Widget _buildMenuEntry(MapEntry<String, String> entry) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Routemaster.of(context).push(entry.key);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Center(
              child: Text(
                entry.value.toUpperCase(),
                style: const TextStyle(color: Colors.white70, fontSize: 14),
              ),
            ),
          ),
        ),
        Container(
          height: 1,
          margin: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: FractionalOffset.centerLeft,
                  end: FractionalOffset.centerRight,
                  colors: [
                Colors.transparent,
                Colors.blueAccent.withOpacity(.5),
                Colors.transparent
              ],
                  stops: const [
                .0,
                .5,
                1
              ])),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DashboardViewModel>.value(
      value: viewModel,
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("assets/images/bg.jpg"))),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: FractionalOffset.topCenter,
                      end: FractionalOffset.bottomCenter,
                      colors: [
                    AppTheme.accent.withOpacity(.05),
                    AppTheme.primary.withOpacity(.5),
                    Colors.black.withOpacity(.75)
                  ],
                      stops: const [
                    0.0,
                    0.5,
                    1.0
                  ])),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: CustomScrollView(clipBehavior: Clip.antiAlias, slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 24,
                        ),
                        Image.asset(
                          "assets/images/logo.png",
                          width: 160,
                          isAntiAlias: true,
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          "Acceso fácil a la legislación cubana",
                          style: TextStyle(color: Colors.white70),
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        SearchBox(
                          onSubmit: (value) {
                            if (value != null && value.toString().isNotEmpty) {
                              Routemaster.of(context)
                                  .push('/search-results', queryParameters: {
                                'text': value.toString().trim().toLowerCase()
                              });
                            }
                          },
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        for (final entry in mainRoutes.entries)
                          _buildMenuEntry(entry),
                        const SizedBox(
                          height: 32,
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 32, top: 16),
                    child: Column(
                      children: [
                        Text(
                          "Publicado en elTOQUE Jurídico".toUpperCase(),
                          style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        Container(
                          height: 2,
                          margin: const EdgeInsets.only(top: 16),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: FractionalOffset.centerLeft,
                                  end: FractionalOffset.centerRight,
                                  colors: [
                                Colors.transparent,
                                Colors.blueAccent.withOpacity(.5),
                                Colors.transparent
                              ],
                                  stops: const [
                                .0,
                                .5,
                                1
                              ])),
                        )
                      ],
                    ),
                  ),
                ),
                Consumer<DashboardViewModel>(
                  builder: (context, value, child) {
                    final news = viewModel.news;
                    return SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      sliver: SliverList(
                          delegate:
                              SliverChildBuilderDelegate((context, index) {
                        final item = news[index];
                        return SizedBox(
                          height: 250,
                          child: Card(
                            clipBehavior: Clip.antiAlias,
                            margin: const EdgeInsets.only(bottom: 16),
                            child: GestureDetector(
                              onTap: () => _launchUrl(item),
                              child: Stack(
                                children: [
                                  FadeInImage(
                                      fadeInDuration:
                                          const Duration(milliseconds: 200),
                                      fit: BoxFit.cover,
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.height,
                                      placeholder: const AssetImage(
                                          "assets/images/placeholder.webp"),
                                      image: NetworkImage(
                                          "https://api.eltoque.com${item['feature_image']['url']}")),
                                  Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Column(
                                      children: [
                                        const Expanded(child: SizedBox()),
                                        Text(
                                          item['title'],
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }, childCount: news.length)),
                    );
                  },
                )
              ]),
            )
          ],
        ),
      ),
    );
  }
}
