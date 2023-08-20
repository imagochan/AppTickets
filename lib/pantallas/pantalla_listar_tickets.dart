import 'package:flutter/material.dart';
import 'package:apptickets/servicios/api.dart';
import 'package:apptickets/modelos/modelo_ticket.dart';

class ListarTickets extends StatefulWidget {
  const ListarTickets({super.key});

  @override
  State<ListarTickets> createState() => _ListarTicketsState();
}


class _ListarTicketsState extends State<ListarTickets> {

  final List<String> list = <String>[
    'Comedia',
    'Historia',
    'Ficción',
    'Acción',
    'Drama'
  ];

  String? dropdownValue;
  
  @override
  Widget build(BuildContext context) {

    var selectorCategoria = Center(
      //TODO: reemplazar lista de categorias viejas por llamada a la API
      child: DropdownButtonFormField<String>(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor seleccione una categoria';
          }
          return null;
        },
        isExpanded: true,
        hint: const Text("Elija una categoría"),
        value: dropdownValue,
        icon: const Icon(Icons.arrow_downward),
        elevation: 16,
        onChanged: (String? value) {
          //setState(() {
          //  dropdownValue = value!;
          //});
          dropdownValue = value!;
        },
        items: list.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );

    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
          //Llamamos a la API de recolectar tickets de forma asíncrona
          //Para desplegar los tickets dentro de la App
          future: Api.getTicket(dropdownValue),
          //print("futuro");
          //print(future);
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            //Mostramos una pantalla de carga mientras esperamos la información.

            //Tipo.tipo1.miextension;

            //TODO: variantes de !snapshot.connectionState == ConnectionState.none
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(
                child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Text("hubo un error");
            }
            if (snapshot.hasData) {
              List<Ticket> tdata = snapshot.data;
              return Column(
                children: [
                  selectorCategoria,
                  //when you try to use a ListView/GridView inside a Column, there are many ways of solving it, I am listing few here.
                  //Wrap ListView in Expanded
                  ElevatedButton(onPressed: (){setState(() {
                    print(dropdownValue);
                    //need this to re-run // call setState
                  });}, child: Text("filtrar")),
                  Expanded(
                    child: ListView.builder(
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
                                  "Fecha de Vencimiento: ${tdata[index].fechaVencimiento.year}-${tdata[index].fechaVencimiento.month}-${tdata[index].fechaVencimiento.day}"),
                              Text(
                                  "Fecha de Publicación: ${tdata[index].fechaPublicacion.year}-${tdata[index].fechaPublicacion.month}-${tdata[index].fechaPublicacion.day}"),
                              Text(
                                  "Fecha de fin de Publicación: ${tdata[index].fechaFinPublicacion.year}-${tdata[index].fechaFinPublicacion.month}-${tdata[index].fechaFinPublicacion.day}"),
                              Text(
                                  "Valor de la compra: ${tdata[index].valorCompra.toString()}"),
                              Text("Categoria: ${tdata[index].categoria}"),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            }     
            return Text("no data?");
          }),
    );
  }
}
