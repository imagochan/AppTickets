import 'package:flutter/material.dart';

class CampoTexto extends StatelessWidget {
  const CampoTexto({
    super.key,
    required this.controller,
    required this.hintText,
    required this.labelText,
  });

  final TextEditingController controller;
  final String hintText;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          labelText: labelText,
          icon: const Icon(Icons.title),
          border: const OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor introduzca un texto';
          }
          return null;
        },
      ),
    );
  }
}
