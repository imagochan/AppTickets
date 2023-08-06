import 'package:flutter/material.dart';
import 'package:node_tutorials/services/api.dart';
import 'package:node_tutorials/model/ticket_model.dart';

class PantallaActualizarTicket extends StatefulWidget {
  final Ticket data;
  const PantallaActualizarTicket({super.key, required this.data});

  @override
  State<PantallaActualizarTicket> createState() =>
      _PantallaActualizarTicketState();
}

class _PantallaActualizarTicketState extends State<PantallaActualizarTicket> {
  var tituloController = TextEditingController();
  var descripcionController = TextEditingController();
  var fechaVencimientoController = TextEditingController();
  var fechaPublicacionController = TextEditingController();
  var fechaFinPublicacionController = TextEditingController();
  var valorCompraController = TextEditingController();
  var categoriaController = TextEditingController();

  @override
  void initState() {
    //initializing stuff with their current values
    super.initState();
    tituloController.text = widget.data.titulo.toString();
    descripcionController.text = widget.data.descripcion.toString();
    fechaVencimientoController.text = widget.data.fechaVencimiento.toString();
    fechaPublicacionController.text = widget.data.fechaPublicacion.toString();
    fechaFinPublicacionController.text =
        widget.data.fechaFinPublicacion.toString();
    valorCompraController.text = widget.data.valorCompra.toString();
    categoriaController.text = widget.data.categoria.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ingrese datos del ticket a crear"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: tituloController,
                  decoration: const InputDecoration(
                    hintText: "ingrese el titulo del ticket",
                  ),
                ),
                TextField(
                  controller: descripcionController,
                  decoration: const InputDecoration(
                      hintText: "Ingrese la descripción del ticket"),
                ),
                TextField(
                  controller: fechaVencimientoController,
                  decoration: const InputDecoration(
                    hintText: "Ingrese la fecha de vencimiento del ticket",
                  ),
                ),
                TextField(
                  controller: fechaPublicacionController,
                  decoration: const InputDecoration(
                      hintText: "Ingrese la fecha de publicación del ticket"),
                ),
                TextField(
                  controller: fechaFinPublicacionController,
                  decoration: const InputDecoration(
                      hintText:
                          "Ingrese la fecha de fin de publicación del ticket"),
                ),
                TextField(
                  controller: valorCompraController,
                  decoration: const InputDecoration(
                      hintText: "Ingrese el valor de compra del ticket"),
                ),
                TextField(
                  controller: categoriaController,
                  decoration: const InputDecoration(
                      hintText: "Ingrese la categoria del ticket"),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      Api.updateTicket(widget.data.id, {
                        "titulo": tituloController.text,
                        "descripcion": descripcionController.text,
                        "fechaVencimiento": fechaVencimientoController.text,
                        "fechaPublicacion": fechaPublicacionController.text,
                        "fechaFinPublicacion":
                            fechaFinPublicacionController.text,
                        "valorCompra": valorCompraController.text,
                        "categoria": categoriaController.text
                      });
                    },
                    child: const Text("Actualizar ticket"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
