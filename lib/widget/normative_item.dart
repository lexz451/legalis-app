import 'package:flutter/material.dart';
import 'package:legalis/model/normative.dart';
import 'package:legalis/state/app_viewmodel.dart';
import 'package:legalis/state/normative_item_viewmodel.dart';
import 'package:legalis/theme.dart';
import 'package:legalis/widget/action_icon.dart';
import 'package:provider/provider.dart';
import 'package:routemaster/routemaster.dart';

class NormativeItem extends StatefulWidget {
  const NormativeItem(
      {Key? key,
      required this.normative,
      this.showRemove = false,
      this.showBookmark = true})
      : super(key: key);

  final Normative normative;
  final bool? showRemove;
  final bool? showBookmark;

  @override
  State<StatefulWidget> createState() => _NormativeItemState();
}

class _NormativeItemState extends State<NormativeItem> {
  Normative get normative => widget.normative;

  bool get showBookmark => widget.showBookmark ?? false;
  bool get showRemove => widget.showRemove ?? false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppViewModel>(
      builder: (context, value, child) => Card(
        elevation: 0.5,
        margin: const EdgeInsets.only(bottom: 8),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: widget.normative.state == "Activa"
                            ? AppTheme.accent
                            : AppTheme.primary,
                        borderRadius: BorderRadius.circular(4)),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: Center(
                      child: Text(
                        widget.normative.state?.toUpperCase() ?? "",
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12),
                      ),
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  value.isSaved(normative)
                      ? ActionIcon(
                          icon: Icons.bookmark_rounded,
                          onClick: () => value.toggleIsSaved(normative),
                        )
                      : ActionIcon(
                          icon: Icons.bookmark_outline_rounded,
                          onClick: () => value.toggleIsSaved(normative)),
                  const SizedBox(
                    width: 8,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: ActionIcon(icon: Icons.share),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () => Routemaster.of(context)
                    .push("normatives/" + widget.normative.id),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      widget.normative.name,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      widget.normative.summary ?? "-",
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        const Text(
                          "Emisor:",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          widget.normative.organism ?? "-",
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Row(
                      children: [
                        const Text(
                          "Año:",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          widget.normative.year.toString(),
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    const Text(
                      "Palabras clave:",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Wrap(
                      spacing: 2,
                      direction: Axis.vertical,
                      clipBehavior: Clip.antiAlias,
                      children: widget.normative.keywords
                          .map((e) => Text(
                                e,
                                overflow: TextOverflow.ellipsis,
                                textWidthBasis: TextWidthBasis.parent,
                                style: TextStyle(
                                    color: AppTheme.primaryLight, fontSize: 11),
                              ))
                          .toList(),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
