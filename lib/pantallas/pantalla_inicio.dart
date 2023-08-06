import 'package:flutter/material.dart';
import 'package:apptickets/pantallas/pantalla_borrar_tickets.dart';
//import 'package:apptickets/create.dart';
import 'package:apptickets/pantallas/pantalla_listar_tickets.dart';
//import 'package:apptickets/fetch.dart';
//import 'package:apptickets/update.dart';
//import 'package:apptickets/delete.dart';
import 'package:apptickets/pantallas/pantalla_crear_ticket.dart';
import 'package:apptickets/pantallas/pantalla_actualizar_tickets.dart';

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
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CrearTicket()));
                  },
                  child: const Text("Crear Ticket")),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => const ListarTickets())));
                  },
                  child: const Text("Listar Tickets")),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => const ActualizarTickets())));
                  },
                  child: const Text("Actualizar Ticket")),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => const BorrarTickets())));
                  },
                  child: const Text("Borrar Ticket")),
            ],
          ),
        ));
  }
}
