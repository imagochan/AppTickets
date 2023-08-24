// import 'package:flutter/material.dart';
// //Al pulsar el botón de editar
// //enviamos el índice del ticket a actualizar y
// //redirigimos al usuario a la pantalla de edición de tickets

// class UpdateButtonWidget extends StatefulWidget {
//   const UpdateButtonWidget({super.key});

//   @override
//   State<UpdateButtonWidget> createState() => _UpdateButtonWidgetState();
// }

// class _UpdateButtonWidgetState extends State<UpdateButtonWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return IconButton(
//                           onPressed: () {
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) =>
//                                       PantallaActualizarTicket(
//                                           data: tdata[index]),
//                                 ));
//                           },
//                           icon: const Icon(Icons.edit),
//                         );
//   }
// }

//   @override
//   void initState() {
//     //Inicializamos los widgets con sus datos actuales
//     super.initState();
//     tituloController.text = widget.data.titulo.toString();
//     descripcionController.text = widget.data.descripcion.toString();
//     fechaVencimientoController.text = widget.data.fechaVencimiento.toString();
//     fechaPublicacionController.text = widget.data.fechaPublicacion.toString();
//     valorCompraController.text = widget.data.valorCompra.toString();
//     categoriaController.text = widget.data.categoria.toString();
//   }

//   ElevatedButton(
//                     //Al pulsar el botón de actualizar ticket
//                     //Enviamos la información del ticket a la API y
//                     //redirigimos al usuario a la pantalla de inicio
//                     onPressed: () {
//                       Api.updateTicket(widget.data.id, {
//                         "titulo": tituloController.text,
//                         "descripcion": descripcionController.text,
//                         "fechaVencimiento": fechaVencimientoController.text,
//                         "fechaPublicacion": fechaPublicacionController.text,
//                         "fechaFinPublicacion":
//                             fechaFinPublicacionController.text,
//                         "valorCompra": valorCompraController.text,
//                         "categoria": categoriaController.text
//                       });
//                       Navigator.pushAndRemoveUntil(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => const PantallaInicio()),
//                         (Route<dynamic> route) => false,
//                       );
//                     },
//                     child: const Text("Actualizar ticket"))