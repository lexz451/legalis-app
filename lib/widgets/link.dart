import 'package:flutter/cupertino.dart';
import 'package:legalis/theme.dart';

class Link extends StatefulWidget {
  final String text;

  Link(this.text);

  @override
  State<StatefulWidget> createState() => _LinkState();
}

class _LinkState extends State<Link> {
  Color? tempColor;

  void _onHover(PointerEvent e) {
    setState(() {
      tempColor = AppTheme.accentColor;
    });
  }

  void _onExit(PointerEvent e) {
    setState(() {
      tempColor = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: _onHover,
      onExit: _onExit,
      child: RichText(
          text: TextSpan(
              text: widget.text,
              style: TextStyle(
                  color: tempColor != null
                      ? tempColor
                      : AppTheme.textColorLight))),
    );
  }
}
