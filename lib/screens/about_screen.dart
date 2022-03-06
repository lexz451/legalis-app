import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:legalis/app.dart';
import 'package:legalis/model/person.dart';
import 'package:legalis/model/resource.dart';
import 'package:legalis/state/about_viewmodel.dart';
import 'package:legalis/theme.dart';
import 'package:provider/provider.dart';
import 'package:routemaster/routemaster.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
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
    return Column(
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
            child: CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.all(16),
                  sliver: SliverToBoxAdapter(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 75,
                        ),
                        const Text(
                          "Sobre Legalis",
                          style: TextStyle(
                              fontSize: 32, fontWeight: FontWeight.bold),
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
                        const Text(
                          "Equipo",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 12,
                        )
                      ],
                    ),
                  ),
                ),
                Builder(
                  builder: (context) {
                    if (viewModel.team.state == ResourceState.loading) {
                      return const SliverFillRemaining(
                        child: Center(
                          child: SizedBox(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator(strokeWidth: 4.0),
                          ),
                        ),
                      );
                    } else if (viewModel.team.state == ResourceState.error) {
                      return SliverFillRemaining(
                        child: Center(
                          child: Text(viewModel.team.exception ?? "Error"),
                        ),
                      );
                    }
                    final _team = viewModel.team.data ?? [];
                    return SliverList(
                      delegate: SliverChildListDelegate(
                          [..._team.map((e) => _buildTeamInfo(e))]),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
