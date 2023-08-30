import 'package:apptickets/providers/page_navigator.dart';
import 'package:flutter/material.dart';

class HomeElevBtn extends StatelessWidget {
  final Widget pageWidget;
  final String btnTitle;
  const HomeElevBtn({
    super.key,
    required this.pageWidget,
    required this.btnTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
          onPressed: () {
            cambiarPantalla(pageWidget, context);
          },
          child: Text(btnTitle)),
    );
  }
}
