import 'package:apptickets/pantallas/pantalla_crear_ticket_form_cookbook.dart';
import 'package:apptickets/widgets/home_elev_btn.dart';
import 'package:flutter/material.dart';
import 'package:apptickets/pantallas/pantalla_borrar_tickets.dart';
import 'package:apptickets/pantallas/pantalla_listar_tickets.dart';
import 'package:apptickets/pantallas/pantalla_actualizar_tickets.dart';

//Pantalla de inicio que aloja los botones para crear, listar, actualizar y borrar tickets
//Utilizamos Navigator y Routes para mover al usuario entre pantallas

class PantallaInicio extends StatefulWidget {
  const PantallaInicio({super.key});

  @override
  State<PantallaInicio> createState() => _PantallaInicioState();
}

class _PantallaInicioState extends State<PantallaInicio> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("App para tickets en línea"),
        ),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              HomeElevBtn(pageWidget: MyCustomForm(), btnTitle: 'Crear Ticket',),
              HomeElevBtn(pageWidget: ListarTickets(), btnTitle: 'Listar Ticket',),
              HomeElevBtn(pageWidget: ActualizarTickets(), btnTitle: 'Actualizar Ticket',),
              HomeElevBtn(pageWidget: BorrarTickets(), btnTitle: 'Borrar Ticket',),
            ],
          ),
        ));
  }
  
}
