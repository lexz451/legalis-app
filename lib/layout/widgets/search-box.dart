import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:legalis/theme.dart';

class SearchBox extends StatelessWidget {
  const SearchBox({
    required this.controller,
    required this.focusNode,
    Key? key
  }) : super(key: key);

  final TextEditingController controller;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(decoration: BoxDecoration(
      color: AppTheme.searchBoxBackground,
      borderRadius: BorderRadius.circular(10)
    ),
    child: Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 6,
        vertical: 8
      ),
      child: Row(
        children: [
          Expanded(child: CupertinoTextField(
            cursorColor: AppTheme.textColorLight,
            placeholderStyle: TextStyle(
              color: AppTheme.textColorLight.withOpacity(0.5),
              fontSize: 14,
            ),
            placeholder: "Buscar por palabras o expresiones...",
            controller: controller,
            focusNode: focusNode,
            decoration: null,
          )),
          GestureDetector(
            onTap: controller.clear,
            child: const Icon(
              CupertinoIcons.search,
              color: Colors.white,
            ),
          )
        ],
      ),
    ),);
  }
}