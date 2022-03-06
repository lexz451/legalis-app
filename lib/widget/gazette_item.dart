import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:legalis/model/gazette.dart';
import 'package:legalis/theme.dart';

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
      margin: EdgeInsets.only(left: 16, right: 16, bottom: 8),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              gazette.name ?? "-",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primary),
            ),
            SizedBox(
              height: 4,
            ),
            Text(gazette.date ?? "-")
          ],
        ),
      ),
    );
  }
}
