import 'package:flutter/material.dart';
import 'package:legalis/theme.dart';
import 'package:legalis/widget/search_box.dart';
import 'package:routemaster/routemaster.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final mainRoutes = {
    'advanced-search': 'Búsqueda Avanzada',
    'directories': 'Directorio Temático',
    'gazettes': 'Indice de Gacetas',
    'glossary': 'Glosario de Términos',
    'recent': 'Normativa Reciente',
    'popular': 'Normas populares',
  };

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
    return Scaffold(
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
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              clipBehavior: Clip.antiAlias,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 12,
                  ),
                  Image.asset(
                    "assets/images/logo.png",
                    width: 180,
                    isAntiAlias: true,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Búsqueda fácil en la Legislación Cubana",
                    style: TextStyle(color: Colors.white),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  const SearchBox(),
                  const SizedBox(
                    height: 32,
                  ),
                  for (final entry in mainRoutes.entries) _buildMenuEntry(entry)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
