import 'package:flutter/material.dart';

class BotonEnviarTicket extends StatefulWidget {
  const BotonEnviarTicket(
      {super.key, required this.submitData, required this.esCrearOActualizar});

  final Function() submitData;
  final bool esCrearOActualizar;

  @override
  State<BotonEnviarTicket> createState() => _BotonEnviarTicketState();
}

class _BotonEnviarTicketState extends State<BotonEnviarTicket> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: ElevatedButton(
          onPressed: () {
            widget.submitData(); //mejor pasar submit data
          },
          child: Text(
              widget.esCrearOActualizar ? 'Crear Ticket' : 'Actualizar Ticket'),
        ),
      ),
    );
  }
}
