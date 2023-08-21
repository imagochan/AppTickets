import 'package:apptickets/pantallas/listar_tickets/widget_selection_button.dart';
import 'package:flutter/material.dart';
import 'package:apptickets/servicios/api.dart';

class ListarTickets extends StatefulWidget {
  const ListarTickets({super.key});

  @override
  State<ListarTickets> createState() => _ListarTicketsState();
}

class _ListarTicketsState extends State<ListarTickets> {
  //Declaramos nuestras variables a utilizar que pasaremos a la API

  num? valorCompraStart;
  num? valorCompraEnd;
  DateTime fechaCreacionStart = DateUtils.addDaysToDate(DateTime.now(), 6);
  DateTime fechaCreacionEnd = DateUtils.addDaysToDate(DateTime.now(), 8);
  DateTime fechaPublicacionStart = DateUtils.addDaysToDate(DateTime.now(), 6);
  DateTime fechaPublicacionEnd = DateUtils.addDaysToDate(DateTime.now(), 8);
  String? dropdownValue;
  String? unNombre;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
          //Llamamos a la API de recolectar tickets de forma asíncrona
          future: Api.getTicket(
              dropdownValue,
              unNombre,
              DateTime.now(),
              DateTime.now(),
              fechaPublicacionStart,
              fechaPublicacionEnd,
              fechaCreacionStart,
              fechaCreacionEnd,
              valorCompraStart,
              valorCompraEnd),
          //Construimos dependiendo del estado de la snapshot
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return const Text("hubo un error");
            }
            if (snapshot.hasData) {
              return Column(
                //mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: double.infinity,
                    height: 100.0,
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                    ),
                    child: const Center(
                      child: SelectionButton(),
                    ),
                  ),
                  Expanded(
                      child: ListView.builder(
                    itemBuilder: (context, index) {
                      return SizedBox(
                        width: double.infinity,
                        height: 100.0,
                        child: Text(index.toString()),
                      );
                    },
                    itemCount: 25,
                    shrinkWrap: false,
                  ))
                ],
              );
            }
            return const Text(
                "No hay conexión con el servidor"); //can be improved
          }),
    );
  }
}
