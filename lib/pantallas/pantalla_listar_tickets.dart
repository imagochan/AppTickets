import 'package:flutter/material.dart';
import 'package:apptickets/servicios/api.dart';
import 'package:apptickets/modelos/modelo_ticket.dart';

class ListarTickets extends StatefulWidget {
  const ListarTickets({super.key});

  @override
  State<ListarTickets> createState() => _ListarTicketsState();
}


class _ListarTicketsState extends State<ListarTickets> {

  var busquedaController = TextEditingController();

  var fechaPublicacionRangoController = TextEditingController();

  //DateTime fechaVencimiento = DateUtils.addDaysToDate(DateTime.now(), 7);
  DateTime fechaPublicacionStart = DateUtils.addDaysToDate(DateTime.now(), 6);
  DateTime fechaPublicacionEnd = DateUtils.addDaysToDate(DateTime.now(), 8);

  var fechaVencimientoRangoController = TextEditingController();

  //DateTime fechaVencimiento = DateUtils.addDaysToDate(DateTime.now(), 7);
  DateTime fechaVencimientoStart = DateUtils.addDaysToDate(DateTime.now(), 6);
  DateTime fechaVencimientoEnd = DateUtils.addDaysToDate(DateTime.now(), 8);

  final List<String> list = <String>[
    'Comedia',
    'Historia',
    'Ficción',
    'Acción',
    'Drama'
  ];

  String? dropdownValue;
  String? unNombre;
  
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

    Future<void> llamarDateRangePicker(DateTime dateStart,DateTime dateEnd, TextEditingController controller) async {
      final DateTimeRange? dateTimeRange = await showDateRangePicker(
                      context: context,
                      //initialDate: date,
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2030),
                    );
                    if (dateTimeRange != null) {
                      setState(() {
                        dateStart = DateUtils.dateOnly(dateTimeRange.start);
                        dateEnd = DateUtils.dateOnly(dateTimeRange.end);
                        controller.text =
                            //date.toString();
                            "${dateStart}-${dateEnd}";
                      });
                    }
    }

    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
          //Llamamos a la API de recolectar tickets de forma asíncrona
          //Para desplegar los tickets dentro de la App
          future: Api.getTicket(dropdownValue,unNombre),
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
                  const SizedBox(height: 10,),
                  form_field_widget(controller: busquedaController, hintText: "ingrese nombre de ticket", labelText: "nombre de ticket"),
                  selectorCategoria,
                  const SizedBox(height: 10,),
                  //when you try to use a ListView/GridView inside a Column, there are many ways of solving it, I am listing few here.
                  //Wrap ListView in Expanded
                  //form_date_field_widget(fecha: fechaVencimiento, controller: fechaVencimientoController, llamarDatePicker: llamarDatePicker, texto: "Fecha de vencimiento",),
                  //form_date_field_widget(fecha: fecha, controller: controller, llamarDatePicker: llamarDatePicker, texto: texto),
                  form_date_field_widget(fechaStart: fechaVencimientoStart, fechaEnd: fechaVencimientoEnd, controller: fechaVencimientoRangoController, llamarDatePicker: llamarDateRangePicker, texto: "fecha de vencimiento rango fecha"),
                  const SizedBox(height: 10,),
                  form_date_field_widget(fechaStart: fechaPublicacionStart, fechaEnd: fechaPublicacionEnd, controller: fechaPublicacionRangoController, llamarDatePicker: llamarDateRangePicker, texto: "fecha de publicacion rango fecha"),
                  const SizedBox(height: 10,),
                  ElevatedButton(onPressed: (){setState(() {
                    unNombre = busquedaController.text;//para pasar el titulo del ticket a buscar
                    print("antes de dropdownvalue y un nombre prints");
                    print(dropdownValue);
                    print(unNombre);
                    //need this to re-run // call setState
                  });}, child: Text("filtrar")),
                  const SizedBox(height: 10,),
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
                              Text("fechaCreacion: ${tdata[index].fechaCreacion.toString()}"),
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

class form_date_field_widget extends StatelessWidget {
  const form_date_field_widget({
    super.key,
    required this.fechaStart,
    required this.fechaEnd,
    required this.controller,
    required this.llamarDatePicker,
    required this.texto,
  });

  final DateTime fechaStart;
  final DateTime fechaEnd;
  final TextEditingController controller;
  final Function llamarDatePicker;
  final String texto;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: () async {
        llamarDatePicker(fechaStart,fechaEnd,controller);
      },
      readOnly: true,
      controller: controller,
      decoration: InputDecoration(
        hintText: texto,
        labelText: texto,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        icon: const Icon(Icons.edit_calendar),
        border: const OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor seleccione una fecha';
        }
        return null;
      },
    );
  }
}

class form_field_widget extends StatelessWidget {
  const form_field_widget({
    super.key,
    required this.controller,
    required this.hintText,
    required this.labelText,
  });

  final TextEditingController controller;
  final String hintText;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        icon: const Icon(Icons.title),
        border: const OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor introduzca un texto';
        }
        return null;
      },
    );
  }
}
