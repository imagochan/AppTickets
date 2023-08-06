import 'package:flutter/material.dart';
import 'package:node_tutorials/servicios/api.dart';
import 'package:node_tutorials/modelos/modelo_ticket.dart';

class BorrarTickets extends StatefulWidget {
  const BorrarTickets({super.key});

  @override
  State<BorrarTickets> createState() => _BorrarTicketsState();
}

class _BorrarTicketsState extends State<BorrarTickets> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Borrar un ticket"),
      ),
      body: FutureBuilder(
          future: Api.getTicket(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              List<Ticket> tdata = snapshot.data;

              return ListView.builder(
                itemCount: tdata.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: const EdgeInsets.all(15.0),
                    padding: const EdgeInsets.all(3.0),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.blueAccent)),
                    child: Column(
                      children: [
                        Text("Titulo: ${tdata[index].titulo}"),
                        Text("Descripción: ${tdata[index].descripcion}"),
                        Text(
                            "Fecha de Vencimiento: ${tdata[index].fechaVencimiento}"),
                        Text(
                            "Fecha de Publicación: ${tdata[index].fechaPublicacion}"),
                        Text(
                            "Fecha de fin de Publicación: ${tdata[index].fechaFinPublicacion}"),
                        Text("Valor de compra: ${tdata[index].valorCompra}"),
                        Text("Categoria: ${tdata[index].categoria}"),
                        IconButton(
                          onPressed: () async {
                            await Api.deleteTicket(tdata[index].id);
                            tdata.removeAt(index);
                            setState(() {});
                          },
                          icon: const Icon(Icons.delete),
                        )
                      ],
                    ),
                  );
                },
              );
            }
          }),
    );
  }
}
