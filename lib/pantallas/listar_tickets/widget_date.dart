import 'package:flutter/material.dart';

Future<void> llamarDatePicker(
        DateTime date, TextEditingController controller, BuildContext context) async {
      final DateTime? dateTime = await showDatePicker(
        context: context,
        initialDate: date,
        firstDate: DateTime.now(),
        lastDate: DateTime(2030),
      );
      if (dateTime != null) {
        //setState(() {
        date = DateUtils.dateOnly(dateTime);
        controller.text = date.toString();
        //});
      }
    }

Future<void> llamarDateRangePicker(DateTime dateStart, DateTime dateEnd,
    TextEditingController controller, BuildContext context) async {
  final DateTimeRange? dateTimeRange = await showDateRangePicker(
    context: context,
    //initialDate: date,
    firstDate: DateTime.now(),
    lastDate: DateTime(2030),
  );
  if (dateTimeRange != null) {
    //setState(() {
    dateStart = DateUtils.dateOnly(dateTimeRange.start);
    dateEnd = DateUtils.dateOnly(dateTimeRange.end);
    controller.text = "$dateStart-$dateEnd";
    //});
  }
}

class FormDateRangeField extends StatelessWidget {
  const FormDateRangeField({
    super.key,
    required this.fechaStart,
    required this.fechaEnd,
    required this.controller,
    required this.texto,
  });

  final DateTime fechaStart;
  final DateTime fechaEnd;
  final TextEditingController controller;
  final String texto;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: () async {
        llamarDateRangePicker(fechaStart, fechaEnd, controller,context);
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

class FormDateField extends StatelessWidget {
  const FormDateField({
    super.key,
    required this.fecha,
    required this.controller,
    required this.texto,
  });

  final DateTime fecha;
  final TextEditingController controller;
  final String texto;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        onTap: () async {
          llamarDatePicker(fecha, controller,context);
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
      ),
    );
  }
}