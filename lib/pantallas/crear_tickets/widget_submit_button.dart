import 'package:flutter/material.dart';

class SubmitTicketButton extends StatefulWidget {
  const SubmitTicketButton({super.key, required this.submitData});

  final Function() submitData;

  @override
  State<SubmitTicketButton> createState() => _SubmitTicketButtonState();
}

class _SubmitTicketButtonState extends State<SubmitTicketButton> {
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: ElevatedButton(
          onPressed: () {
            widget.submitData();//mejor pasar submit data
          },
          child: const Text('Crear Ticket'),
        ),
      ),
    );
  }
}