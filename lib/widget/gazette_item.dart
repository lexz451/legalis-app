import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:legalis/model/gazette.dart';
import 'package:legalis/theme.dart';
import 'package:legalis/widget/action_icon.dart';
import 'package:routemaster/routemaster.dart';

class GazetteItem extends StatefulWidget {
  const GazetteItem({Key? key, required this.gazette}) : super(key: key);

  final Gazette gazette;

  @override
  State<StatefulWidget> createState() => _GazetteItem();
}

class _GazetteItem extends State<GazetteItem> {
  Gazette get gazette => widget.gazette;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              (gazette.name ?? "-").toUpperCase(),
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primary),
            ),
            const SizedBox(
              height: 4,
            ),
            Row(
              children: [
                Text(
                  gazette.date ?? "-",
                  style: const TextStyle(fontSize: 12),
                ),
                const Text(" / "),
                Text(
                  (gazette.type ?? "-").toUpperCase(),
                  style: const TextStyle(fontSize: 12),
                ),
                const Text(" / "),
                Row(
                  children: [
                    const Icon(
                      CupertinoIcons.arrow_down,
                      size: 14,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      (gazette.downloadCount ?? 0).toString(),
                      style: const TextStyle(fontSize: 12),
                    )
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(child: Builder(
                  builder: (context) {
                    if (gazette.normatives == null ||
                        gazette.normatives!.isEmpty) {
                      return Text(
                        "Sin normativas".toUpperCase(),
                        style: const TextStyle(
                            fontSize: 12, color: Colors.black12),
                      );
                    } else {
                      final n = gazette.normatives!.length;
                      return Text(
                        "$n ${n > 1 ? 'Normativas' : 'Normativa'}"
                            .toUpperCase(),
                        style: TextStyle(fontSize: 12, color: AppTheme.accent),
                      );
                    }
                  },
                )),
                ActionIcon(
                  icon: Icons.open_in_new,
                  onClick: () =>
                      Routemaster.of(context).push("/gazette/${gazette.id}"),
                ),
                const SizedBox(
                  width: 16,
                ),
                const ActionIcon(icon: CupertinoIcons.doc_text),
                const SizedBox(
                  width: 16,
                ),
                const ActionIcon(icon: CupertinoIcons.arrow_down),
              ],
            )
          ],
        ),
      ),
    );
  }
}
