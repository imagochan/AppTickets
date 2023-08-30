import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CampoCorreoElectronico extends StatelessWidget {
  const CampoCorreoElectronico(
      {super.key,
      required this.correoElectronicoController,
      required this.hintText,
      required this.labelText});

  final TextEditingController correoElectronicoController;
  final String hintText;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: correoElectronicoController,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))
        ],
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          hintText: hintText,
          labelText: labelText,
          icon: const Icon(Icons.email),
          border: const OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor introduzca un correo electrónico';
          }
          return null;
        },
      ),
    );
  }
}
