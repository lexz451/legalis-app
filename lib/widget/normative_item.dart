import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/parser.dart';
import 'package:legalis/model/normative.dart';
import 'package:legalis/screens/app_viewmodel.dart';
import 'package:legalis/theme.dart';
import 'package:legalis/widget/action_icon.dart';
import 'package:provider/provider.dart';
import 'package:routemaster/routemaster.dart';
import 'package:share_plus/share_plus.dart';

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

  _share() {
    //TODO "Remove static url, use env"
    Share.share('https://legalis.netlify.app/normativa/${normative.id}');
  }

  String? _parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String? parsedString =
        parse(document.body?.text).documentElement?.text;

    return parsedString;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppViewModel>(
      builder: (context, vm, child) => Card(
        elevation: 0,
        margin: const EdgeInsets.only(bottom: 8),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (normative.state != null)
                    Container(
                      decoration: BoxDecoration(
                          color: widget.normative.state == "Activa"
                              ? AppTheme.accent
                              : AppTheme.primary,
                          borderRadius: BorderRadius.circular(4)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 8),
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
                  vm.isBookmark(normative)
                      ? ActionIcon(
                          icon: Icons.bookmark_added_rounded,
                          onClick: () => vm.toggleBookmark(normative),
                        )
                      : ActionIcon(
                          icon: Icons.bookmark_add_rounded,
                          onClick: () => vm.toggleBookmark(normative)),
                  const SizedBox(
                    width: 8,
                  ),
                  ActionIcon(
                    icon: Icons.share_rounded,
                    onClick: () => _share,
                  )
                ],
              ),
              GestureDetector(
                onTap: () => Routemaster.of(context)
                    .push("/normative/${widget.normative.id}"),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      _parseHtmlString(widget.normative.name) ?? "",
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
                        Expanded(
                            child: Text(
                          widget.normative.organism ?? "-",
                          style: const TextStyle(fontSize: 12),
                        )),
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
                      "Tématicas:",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Wrap(
                      spacing: 8,
                      runSpacing: 4,
                      direction: Axis.horizontal,
                      clipBehavior: Clip.antiAlias,
                      children: widget.normative.tags
                          .map((e) => Text(
                                e,
                                overflow: TextOverflow.ellipsis,
                                textWidthBasis: TextWidthBasis.parent,
                                style: TextStyle(
                                    color: AppTheme.primaryLight,
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline),
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
