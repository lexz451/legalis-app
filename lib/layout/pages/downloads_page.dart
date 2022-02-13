import 'package:flutter/cupertino.dart';
import 'package:legalis/theme.dart';

class DownloadsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DownloadsPageState();
}

class _DownloadsPageState extends State<DownloadsPage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Container(
        padding: EdgeInsets.all(18),
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 32,
            ),
            Text(
              "Mis descargas".toUpperCase(),
              style: TextStyle(
                  color: AppTheme.deepBlue,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
