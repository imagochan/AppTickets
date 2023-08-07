import 'package:apptickets/pantallas/pantalla_inicio.dart';
import 'package:flutter/material.dart';
import 'package:apptickets/servicios/api.dart';

class CrearTicket extends StatefulWidget {
  const CrearTicket({super.key});

  @override
  State<CrearTicket> createState() => _CrearTicketState();
}

//Declaramos controladores para los widget dentro de esta pantalla
//para acceder al estado del widget y sus propiedades

class _CrearTicketState extends State<CrearTicket> {
  var tituloController = TextEditingController();
  var descripcionController = TextEditingController();
  var fechaVencimientoController = TextEditingController();
  var fechaPublicacionController = TextEditingController();
  var fechaFinPublicacionController = TextEditingController();
  var valorCompraController = TextEditingController();
  var categoriaController = TextEditingController();

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
                //Al pulsar el botón, recolectamos la información de los widgets
                ElevatedButton(
                    onPressed: () {
                      var data = {
                        "titulo": tituloController.text,
                        "descripcion": descripcionController.text,
                        "fechaVencimiento": fechaVencimientoController.text,
                        "fechaPublicacion": fechaPublicacionController.text,
                        "fechaFinPublicacion":
                            fechaFinPublicacionController.text,
                        //"valorCompra": num.parse(valorCompraController.text),
                        "valorCompra": valorCompraController.text,
                        "categoria": categoriaController.text
                      };
                      //Enviamos la información del ticket usando la API del servidor
                      Api.addTicket(data);
                      //Redirigimos al usuario a la pantalla de inicio
                      //utilizamos el método pushandremoveuntil
                      //para que el usuario no retroceda a una vista desactualizada
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PantallaInicio()),
                        (Route<dynamic> route) => false,
                      );
                    },
                    child: const Text("Crear ticket"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
