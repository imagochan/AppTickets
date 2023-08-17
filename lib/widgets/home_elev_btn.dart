import 'package:flutter/material.dart';

class HomeElevBtn extends StatelessWidget {
  final Function onPressed;
  const HomeElevBtn({
    super.key,
    required this.onPressed,
    });
  

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
                  onPressed: () {
                    _cambiarPantalla(const MyCustomForm());
                  },
                  child: const Text("Crear Ticket")),;
  }
}