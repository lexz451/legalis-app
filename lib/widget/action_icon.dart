import 'package:flutter/material.dart';
import 'package:legalis/theme.dart';

class ActionIcon extends StatefulWidget {
  const ActionIcon({Key? key, required this.icon, this.onClick})
      : super(key: key);

  final IconData icon;
  final Function? onClick;

  @override
  _ActionIconState createState() => _ActionIconState();
}

class _ActionIconState extends State<ActionIcon> {
  IconData get icon => widget.icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
          color: AppTheme.accent.withOpacity(0.05),
          borderRadius: BorderRadius.circular(360)),
      child: InkWell(
        onTap: () => widget.onClick?.call(),
        borderRadius: BorderRadius.circular(360),
        child: Center(
          child: Icon(
            icon,
            size: 18,
            color: AppTheme.accent,
          ),
        ),
      ),
    );
  }
}
