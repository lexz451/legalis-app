import 'package:flutter/cupertino.dart';
import 'package:legalis/model/normative.dart';
import 'package:legalis/theme.dart';

class NormativeItem extends StatefulWidget {
  const NormativeItem(
      {required this.normative, this.onRemove, this.onBookmark, Key? key})
      : super(key: key);

  final Normative normative;
  final Function? onRemove;
  final Function? onBookmark;

  @override
  State<StatefulWidget> createState() => _NormativeItemState();
}

class _NormativeItemState extends State<NormativeItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(bottom: 18),
      //constraints: BoxConstraints(minHeight: 280),
      padding: EdgeInsets.only(left: 18, right: 18, bottom: 18),
      decoration: BoxDecoration(
          color: CupertinoColors.quaternarySystemFill,
          borderRadius: BorderRadius.all(Radius.circular(4))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              widget.normative.state != null
                  ? Container(
                      width: 100,
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppTheme.accentColor,
                      ),
                      child: Center(
                        child: Text(
                          widget.normative.state!.toUpperCase(),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  : SizedBox(),
              Expanded(child: SizedBox()),
              widget.onRemove != null
                  ? Container(
                      margin: EdgeInsets.only(top: 8),
                      child: GestureDetector(
                        onTap: () => widget.onRemove!(),
                        child: Icon(
                          CupertinoIcons.delete,
                          size: 18,
                        ),
                      ),
                    )
                  : SizedBox()
            ],
          ),
          SizedBox(
            height: 18,
          ),
          Text(
            widget.normative.name,
            style: TextStyle(
                color: AppTheme.accentColor,
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            widget.normative.gazette ?? "-",
            style: TextStyle(color: CupertinoColors.secondaryLabel),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            widget.normative.summary ?? "-",
            softWrap: true,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: AppTheme.textColorDark),
          ),
          SizedBox(
            height: 16,
          ),
          Row(
            children: [
              Text(
                "Fecha:",
                style: TextStyle(
                    color: CupertinoColors.secondaryLabel, fontSize: 12),
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                widget.normative.year.toString(),
                style: TextStyle(color: AppTheme.textColorDark, fontSize: 12),
              )
            ],
          ),
          SizedBox(
            height: 4,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Emisor:",
                style: TextStyle(
                    color: CupertinoColors.secondaryLabel,
                    fontSize: 12,
                    overflow: TextOverflow.ellipsis),
              ),
              SizedBox(
                width: 8,
              ),
              Flexible(
                  child: Text(
                widget.normative.organism ?? "-",
                style: TextStyle(
                  color: AppTheme.textColorDark,
                  fontSize: 12,
                ),
                maxLines: 2,
              ))
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Wrap(
            spacing: 8,
            children: widget.normative.keywords
                .map((e) => Text(
                      e,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: AppTheme.deepBlue),
                    ))
                .toList(),
          )
        ],
      ),
    );
  }
}
