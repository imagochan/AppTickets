import 'package:flutter/material.dart';
import 'package:node_tutorials/borrar_ticket.dart';
//import 'package:node_tutorials/create.dart';
import 'package:node_tutorials/fetch_ticket.dart';
//import 'package:node_tutorials/fetch.dart';
//import 'package:node_tutorials/update.dart';
import 'package:node_tutorials/delete.dart';
import 'package:node_tutorials/create_ticket.dart';
import 'package:node_tutorials/update_tickets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
                            builder: ((context) => const ReadTickets())));
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
                            builder: ((context) => const UpdateTickets())));
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
                            builder: ((context) =>
                                const PantallaBorrarTicket())));
                  },
                  child: const Text("Borrar Ticket")),
            ],
          ),
        ));
  }
}
