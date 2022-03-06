import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:legalis/theme.dart';

class LetterSelector extends StatefulWidget {
  const LetterSelector({Key? key}) : super(key: key);

  @override
  _LetterSelectorState createState() => _LetterSelectorState();
}

class _LetterSelectorState extends State<LetterSelector> {
  final _letters = [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M',
    'N',
    'Ñ',
    'O',
    'P',
    'Q',
    'R',
    'S',
    'T',
    'U',
    'V',
    'W',
    'X',
    'Y',
    'Z'
  ];

  String _selected = 'A';

  _setLetter(e) {
    setState(() {
      _selected = e;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(.05),
          borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.all(16),
      child: Wrap(
          spacing: 14,
          runSpacing: 4,
          alignment: WrapAlignment.center,
          children: [
            ..._letters.map((e) => InkWell(
                  onTap: () => _setLetter(e),
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    child: Text(
                      e,
                      style: TextStyle(
                          decoration: e == _selected
                              ? TextDecoration.underline
                              : TextDecoration.none,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: e == _selected
                              ? AppTheme.accent
                              : Colors.black38),
                    ),
                  ),
                ))
          ]),
    );
  }
}
