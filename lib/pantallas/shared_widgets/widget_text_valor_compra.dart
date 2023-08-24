import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ValorCompraWidget extends StatelessWidget {
  const ValorCompraWidget({
    super.key,
    required this.valorCompraController,
    required this.hintText,
    required this.labelText,
  });

  final TextEditingController valorCompraController;
  final String hintText;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: valorCompraController,
        inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))],
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        decoration: InputDecoration(
          hintText: hintText,
          labelText: labelText,
          icon: const Icon(Icons.money),
          border: const OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor introduzca un numero decimal';
          }
          return null;
        },
      ),
    );
  }
}
