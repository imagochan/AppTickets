import 'package:flutter/material.dart';

class FormDateField extends StatelessWidget {
  const FormDateField({
    super.key,
    required this.fechaStart,
    required this.fechaEnd,
    required this.controller,
    required this.llamarDatePicker,
    required this.texto,
  });

  final DateTime fechaStart;
  final DateTime fechaEnd;
  final TextEditingController controller;
  final Function llamarDatePicker;
  final String texto;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: () async {
        llamarDatePicker(fechaStart, fechaEnd, controller);
      },
      readOnly: true,
      controller: controller,
      decoration: InputDecoration(
        hintText: texto,
        labelText: texto,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        icon: const Icon(Icons.edit_calendar),
        border: const OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor seleccione una fecha';
        }
        return null;
      },
    );
  }
}
