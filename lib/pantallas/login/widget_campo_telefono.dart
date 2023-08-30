import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CampoTelefono extends StatelessWidget {
  const CampoTelefono(
      {super.key,
      required this.telefonoController,
      required this.hintText,
      required this.labelText});

  final TextEditingController telefonoController;
  final String hintText;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: telefonoController,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        icon: const Icon(Icons.phone),
        border: const OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor introduzca un número de teléfono';
        }
        if (value.length != 8) {
          return 'El número de teléfono debe ser 8 dígitos';
        }
        return null;
      },
    );
  }
}
