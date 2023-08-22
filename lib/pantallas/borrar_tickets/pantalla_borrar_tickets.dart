import 'package:flutter/material.dart';
import 'package:apptickets/servicios/api.dart';
import 'package:apptickets/modelos/modelo_ticket.dart';

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
          //Llamamos a la API de recolectar tickets de forma asíncrona
          //Para desplegar los tickets dentro de la App
          future: Api.getTicket(
              "unaCategoriaDummy",
              "untitulodummy",
              DateTime.now(),
              DateTime.now(),
              DateTime.now(),
              DateTime.now(),
              0.0,
              0.0),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            //Mostramos una pantalla de carga mientras esperamos la información.
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
              //Si recibimos datos, procedemos a desplegarlos
            } else {
              //Agregamos los datos recibidos a una lista
              //para manipular mas facilmente la información
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
                          //Al pulsar el botón de borrado
                          //llamamos a la API de borrado enviandole el id del ticket a borrar
                          onPressed: () async {
                            await Api.deleteTicket(tdata[index].id);
                            tdata.removeAt(index);
                            //Refrescamos la pantalla luego de borrar el ticket
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
