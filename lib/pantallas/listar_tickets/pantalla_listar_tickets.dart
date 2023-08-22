import 'package:apptickets/modelos/modelo_bundle_filtro.dart';
import 'package:apptickets/pantallas/listar_tickets/widget_list_ticket.dart';
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
  DateTime? fechaCreacionStart;
  DateTime? fechaCreacionEnd;
  DateTime? fechaPublicacionStart;
  DateTime? fechaPublicacionEnd;
  String? dropdownValue;
  String? unNombre;

  BundleFiltros? miBundleFiltros;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
          //Llamamos a la API de recolectar tickets de forma asíncrona
          future: Api.getTicket(
              dropdownValue,
              unNombre,
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
                      child: SelectionButton(unBundleFiltros: miBundleFiltros),
                    ),
                  ),
                  Expanded(
                      child: ListTicketWidget(
                    aSnapshot: snapshot,
                  )
                      //   ListView.builder(
                      // itemBuilder: (context, index) {
                      //   return SizedBox(
                      //     width: double.infinity,
                      //     height: 100.0,
                      //     child: Text(index.toString()),
                      //   );
                      // },
                      // itemCount: 25,
                      // shrinkWrap: false,
                      // )
                      )
                ],
              );
            }
            return const Text(
                "No hay conexión con el servidor"); //can be improved
          }),
    );
  }
}
