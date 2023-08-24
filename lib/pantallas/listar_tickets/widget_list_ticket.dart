import 'package:apptickets/pantallas/listar_tickets/widget_delete_button.dart';
import 'package:flutter/material.dart';
import '../../modelos/modelo_ticket.dart';

class ListTicketWidget extends StatefulWidget {
  //requerimos un snapshot
  const ListTicketWidget({super.key, 
  required this.aSnapshot, 
  required this.aCallBack
  });

  final AsyncSnapshot<dynamic> aSnapshot;
  final Function() aCallBack;

  @override
  State<ListTicketWidget> createState() => _ListTicketWidgetState();
}

class _ListTicketWidgetState extends State<ListTicketWidget> {

  // int indexListaTicketABorrar = 0;

  // void getIndex(int index){
  //   indexListaTicketABorrar = index;
  // }

  // List<Ticket> getListTicket(List<Ticket> losTickets){
  //   losTickets.removeAt(indexListaTicketABorrar);
  //   return losTickets;
  // }

  @override
  Widget build(BuildContext context) {
    //This is how you access parameters passed to another class
    List<Ticket> tdata = widget.aSnapshot.data;
    // tdata = getListTicket(tdata);
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
                  "Fecha de Vencimiento: ${tdata[index].fechaVencimiento.day}-${tdata[index].fechaVencimiento.month}-${tdata[index].fechaVencimiento.year}"),
              Text(
                  "Fecha de Publicación: ${tdata[index].fechaPublicacion.day}-${tdata[index].fechaPublicacion.month}-${tdata[index].fechaPublicacion.year}"),
              Text(
                  "Valor de la compra: ${tdata[index].valorCompra.toString()}"),
              Text("Categoria: ${tdata[index].categoria}"),
              Text("fechaCreacion: ${tdata[index].fechaCreacion.day}-${tdata[index].fechaCreacion.month}-${tdata[index].fechaCreacion.year}"),
              DeleteButtonWidget(miTicket: tdata[index],retorno: widget.aCallBack)
            ],
          ),
        );
      },
    );
  }
}
