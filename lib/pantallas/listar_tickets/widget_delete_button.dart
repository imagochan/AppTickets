import 'package:flutter/material.dart';
import 'package:apptickets/modelos/modelo_ticket.dart';

import '../../servicios/api.dart';

class DeleteButtonWidget extends StatefulWidget {
  const DeleteButtonWidget({super.key, 
  required this.miTicket, 
  required this.retorno, 
  // required this.index
  });

  final Ticket miTicket;
  final Function() retorno;
  // final int index;

  @override
  State<DeleteButtonWidget> createState() => _DeleteButtonWidgetState();
}

class _DeleteButtonWidgetState extends State<DeleteButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      //Al pulsar el botón de borrado
      //llamamos a la API de borrado enviandole el id del ticket a borrar
      onPressed: () async {
        await Api.deleteTicket(widget.miTicket.id);
        //tdata.removeAt(index);
        //Refrescamos la pantalla luego de borrar el ticket
        // widget.retorno(widget.index);
        //setState(() {}); tengo que reconstruir en un callback
        widget.retorno();
      },
      icon: const Icon(Icons.delete),
    );
  }
}

