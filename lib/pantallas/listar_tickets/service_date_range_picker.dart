import 'package:flutter/material.dart';

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
