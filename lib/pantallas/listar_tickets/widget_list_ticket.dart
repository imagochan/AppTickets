import 'package:flutter/material.dart';
import '../../modelos/modelo_ticket.dart';

class ListTicketWidget extends StatefulWidget {
  //requerimos un snapshot
  const ListTicketWidget({super.key, required this.aSnapshot});

  final AsyncSnapshot<dynamic> aSnapshot;

  @override
  State<ListTicketWidget> createState() => _ListTicketWidgetState();
}

class _ListTicketWidgetState extends State<ListTicketWidget> {
  @override
  Widget build(BuildContext context) {
    //This is how you access parameters passed to another class
    List<Ticket> tdata = widget.aSnapshot.data;
    return ListView.builder(
      itemCount: tdata.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          margin: const EdgeInsets.all(15.0),
          padding: const EdgeInsets.all(3.0),
          decoration:
              BoxDecoration(border: Border.all(color: Colors.blueAccent)),
          child: Column(
            children: [
              Text("Titulo: ${tdata[index].titulo}"),
              Text("Descripción: ${tdata[index].descripcion}"),
              Text(
                  "Fecha de Vencimiento: ${tdata[index].fechaVencimiento.year}-${tdata[index].fechaVencimiento.month}-${tdata[index].fechaVencimiento.day}"),
              Text(
                  "Fecha de Publicación: ${tdata[index].fechaPublicacion.year}-${tdata[index].fechaPublicacion.month}-${tdata[index].fechaPublicacion.day}"),
              Text(
                  "Valor de la compra: ${tdata[index].valorCompra.toString()}"),
              Text("Categoria: ${tdata[index].categoria}"),
              Text("fechaCreacion: ${tdata[index].fechaCreacion.year}-${tdata[index].fechaCreacion.month}-${tdata[index].fechaCreacion.day}"),
            ],
          ),
        );
      },
    );
  }
}
