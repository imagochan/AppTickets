import 'package:flutter/material.dart';

class CampoFecha extends StatefulWidget {
  const CampoFecha({
    super.key,
    required this.retorno,
    required this.controller,
    required this.texto,
    required this.fecha,
  });

  final TextEditingController controller;
  final String texto;
  final Function(DateTime fechaTarget) retorno;
  final DateTime fecha;

  @override
  State<CampoFecha> createState() => _CampoFechaState();
}

class _CampoFechaState extends State<CampoFecha> {
  Future<void> llamarDatePicker(DateTime fecha,
      TextEditingController controller, BuildContext context) async {
    final DateTime? dateTime = await showDatePicker(
      context: context,
      initialDate: fecha,
      firstDate: DateUtils.addMonthsToMonthDate(DateTime.now(), -60),
      lastDate: DateUtils.addMonthsToMonthDate(DateTime.now(), 60),
    );
    if (dateTime != null) {
      //setState(() {
      fecha = DateUtils.dateOnly(dateTime);
      controller.text = fecha.toString();
      widget.retorno(fecha);
      //});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        onTap: () async {
          llamarDatePicker(widget.fecha, widget.controller, context);
        },
        readOnly: true,
        controller: widget.controller,
        decoration: InputDecoration(
          hintText: widget.texto,
          labelText: widget.texto,
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


// class FormDateRangeField extends StatelessWidget {
//   const FormDateRangeField({
//     super.key,
//     required this.fechaStart,
//     required this.fechaEnd,
//     required this.controller,
//     required this.texto,
//   });

//   final DateTime fechaStart;
//   final DateTime fechaEnd;
//   final TextEditingController controller;
//   final String texto;

//   Future<void> llamarDateRangePicker(DateTime dateStart, DateTime dateEnd,
//     TextEditingController controller, BuildContext context) async {
//   final DateTimeRange? dateTimeRange = await showDateRangePicker(
//     context: context,
//     firstDate: DateUtils.addMonthsToMonthDate(DateTime.now(), -60),
//     lastDate: DateUtils.addMonthsToMonthDate(DateTime.now(), 60),
//   );
//   if (dateTimeRange != null) {
//     //setState(() {
//     dateStart = DateUtils.dateOnly(dateTimeRange.start);
//     dateEnd = DateUtils.dateOnly(dateTimeRange.end);
//     controller.text = "$dateStart-$dateEnd";
//     //});
//   }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       onTap: () async {
//         llamarDateRangePicker(fechaStart, fechaEnd, controller, context);
//       },
//       readOnly: true,
//       controller: controller,
//       decoration: InputDecoration(
//         hintText: texto,
//         labelText: texto,
//         floatingLabelBehavior: FloatingLabelBehavior.always,
//         icon: const Icon(Icons.edit_calendar),
//         border: const OutlineInputBorder(),
//       ),
//       validator: (value) {
//         if (value == null || value.isEmpty) {
//           return 'Por favor seleccione una fecha';
//         }
//         return null;
//       },
//     );
//   }
// }