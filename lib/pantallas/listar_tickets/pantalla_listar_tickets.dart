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
                  ),
                  Expanded(
                      child: ListView.builder(
                    itemBuilder: (context, index) {
                      return Container(
                        width: double.infinity,
                        height: 100.0,
                        child: Text(index.toString()),
                      );
                    },
                    itemCount: 150,
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

// var column = Column(
//   children: [
//     Row(
//       children: [
//         valorCompraWidget(
//           valorCompraController: valorCompraStartController,
//           hintText: "Ingrese un inicio de compra",
//           labelText: "valor compra start",
//         ),
//         valorCompraWidget(
//           valorCompraController: valorCompraEndController,
//           hintText: "Ingrese un fin de compra",
//           labelText: "valor compra End",
//         ),
//       ],
//     ),
//     const SizedBox(
//       height: 10,
//     ),
//     form_field_widget(
//         controller: busquedaController,
//         hintText: "ingrese nombre de ticket",
//         labelText: "nombre de ticket"),
//     selectorCategoria,
//     const SizedBox(
//       height: 10,
//     ),
//     //when you try to use a ListView/GridView inside a Column, there are many ways of solving it, I am listing few here.
//     //Wrap ListView in Expande maybe
//     //widget_form_date_field(fecha: fechaVencimiento, controller: fechaVencimientoController, llamarDatePicker: llamarDatePicker, texto: "Fecha de vencimiento",),
//     //widget_form_date_field(fecha: fecha, controller: controller, llamarDatePicker: llamarDatePicker, texto: texto),

//     // widget_form_date_field(
//     //     fechaStart: fechaVencimientoStart,
//     //     fechaEnd: fechaVencimientoEnd,
//     //     controller: fechaVencimientoRangoController,
//     //     llamarDatePicker: llamarDateRangePicker,
//     //     texto: "fecha de vencimiento rango fecha"),

//     const SizedBox(
//       height: 10,
//     ),
//     widget_form_date_field(
//         fechaStart: fechaPublicacionStart,
//         fechaEnd: fechaPublicacionEnd,
//         controller: fechaPublicacionRangoController,
//         llamarDatePicker: llamarDateRangePicker,
//         texto: "fecha de publicacion rango fecha"),
//     const SizedBox(
//       height: 10,
//     ),
//     ElevatedButton(
//         onPressed: () {
//           setState(() {
//             unNombre = busquedaController
//                 .text; //para pasar el titulo del ticket a buscar
//             print("antes de dropdownvalue y un nombre prints");
//             print(dropdownValue);
//             print(unNombre);

//             //OJO AQUI DEBERIA SETEAR CONTROLLERS .TEXTS A LAS VARIABLES GLOBALES A PASAR EN LA API!!

//             //need this to re-run // call setState
//           });
//         },
//         child: Text("filtrar")),
//     const SizedBox(
//       height: 10,
//     ),
//   ],
// );
