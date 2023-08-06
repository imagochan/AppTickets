import 'package:flutter/material.dart';
import 'package:node_tutorials/edit_ticket.dart';
import 'package:node_tutorials/services/api.dart';
import 'package:node_tutorials/model/ticket_model.dart';

class UpdateTickets extends StatelessWidget {
  const UpdateTickets({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
                        Text("${tdata[index].titulo}"),
                        Text("${tdata[index].descripcion}"),
                        Text("${tdata[index].fechaVencimiento}"),
                        Text("${tdata[index].fechaPublicacion}"),
                        Text("${tdata[index].fechaFinPublicacion}"),
                        Text("${tdata[index].valorCompra}"),
                        Text("${tdata[index].categoria}"),
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      PantallaActualizarTicket(
                                          data: tdata[index]),
                                ));
                          },
                          icon: const Icon(Icons.edit),
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