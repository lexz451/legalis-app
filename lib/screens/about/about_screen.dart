import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:legalis/model/person.dart';
import 'package:legalis/model/resource.dart';
import 'package:legalis/screens/about/about_viewmodel.dart';
import 'package:legalis/theme.dart';
import 'package:provider/provider.dart';
import 'package:routemaster/routemaster.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  final viewModel = AboutViewModel();

  @override
  void initState() {
    super.initState();
    viewModel.loadTeam();
  }

  _buildTeamInfo(Person item) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          CircleAvatar(
            radius: 48,
            backgroundImage:
                item.imagen != null ? NetworkImage(item.imagen!) : null,
            backgroundColor: Colors.black12,
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            item.name,
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            item.description ?? "-",
            textAlign: TextAlign.center,
            style: const TextStyle(),
          ),
          const SizedBox(
            height: 24,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: viewModel,
      builder: (context, child) => Consumer<AboutViewModel>(
        builder: (context, value, child) => Material(
          child: CupertinoPageScaffold(
            backgroundColor: AppTheme.backgroundColor,
            navigationBar: CupertinoNavigationBar(
              border: null,
              backgroundColor: Colors.transparent,
              leading: InkWell(
                onTap: () {
                  Routemaster.of(context).pop();
                },
                borderRadius: BorderRadius.circular(360),
                child: const Icon(
                  Icons.arrow_back_rounded,
                  size: 28,
                ),
              ),
            ),
            child: Stack(
              children: [
                CustomScrollView(
                  slivers: [
                    SliverSafeArea(
                      sliver: SliverPadding(
                        padding: const EdgeInsets.all(16),
                        sliver: SliverToBoxAdapter(
                          child: Column(
                            children: [
                              
                              Text(
                                "Legalis".toUpperCase(),
                                style: const TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
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
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              const Text(
                                "Lorem ipsum dolor sit amet. Ab laudantium porro ad veniam vero quo porro quae? Est incidunt mollitia in repudiandae ipsa qui consequatur debitis qui doloribus eligendi qui porro necessitatibus. Non velit porro 33 aliquam placeat et obcaecati sequi et explicabo ipsa. ",
                                style: TextStyle(),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(
                                height: 32,
                              ),
                              if (viewModel.team.data != null)
                                Text(
                                  "Equipo".toUpperCase(),
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              const SizedBox(
                                height: 12,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.all(16),
                      sliver: Builder(
                        builder: (context) {
                          if (viewModel.team.state == ResourceState.error) {
                            return SliverFillRemaining(
                              child: Center(
                                child:
                                    Text(viewModel.team.exception ?? "Error"),
                              ),
                            );
                          }
                          final team = viewModel.team.data ?? [];
                          return SliverList(
                            delegate: SliverChildListDelegate(
                                [...team.map((e) => _buildTeamInfo(e))]),
                          );
                        },
                      ),
                    )
                  ],
                ),
                if (viewModel.team.state == ResourceState.loading)
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
          ),
        ),
      ),
    );
  }
}
