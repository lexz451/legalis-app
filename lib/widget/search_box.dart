import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchBox extends StatefulWidget {
  const SearchBox({Key? key, required this.onSubmit}) : super(key: key);

  final Function onSubmit;

  @override
  State<StatefulWidget> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  final _controller = TextEditingController();

  void _onSearchSubmit(value) {
    widget.onSubmit(value);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField.borderless(
      controller: _controller,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      clipBehavior: Clip.antiAlias,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.done,
      onSubmitted: _onSearchSubmit,
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(.25),
          borderRadius: const BorderRadius.all(Radius.circular(8))),
      placeholder: "Buscar por palabras o frases...",
      placeholderStyle: const TextStyle(color: Colors.white54),
      style: const TextStyle(color: Colors.white),
      suffix: Padding(
        padding: const EdgeInsets.only(right: 12),
        child: GestureDetector(
          onTap: () => _onSearchSubmit(_controller.value.text),
          child: const Icon(
            Icons.search_rounded,
            color: Colors.white54,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
