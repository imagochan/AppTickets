import 'package:apptickets/pantallas/pantalla_inicio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../servicios/api.dart';

const List<String> list = <String>[
  'Comedia',
  'Historia',
  'Ficción',
  'Acción',
  'Drama'
];

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  DateTime fechaVencimiento = DateUtils.addDaysToDate(DateTime.now(), 7);
  DateTime fechaPublicacion = DateUtils.dateOnly(DateTime.now());
  DateTime fechaFinPublicacion = DateUtils.addDaysToDate(DateTime.now(), 14);

//  String? categoriaSeleccionada;

  String dropdownValue = list.first;

  var tituloController = TextEditingController();
  var descripcionController = TextEditingController();
  var valorCompraController = TextEditingController();

  var fechaVencimientoController = TextEditingController();

  // user defined function void _showDialog(BuildContext context) {
  void _showDialog(BuildContext context) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: const Text("Message"),
          content: const Text("Hello World"),
          actions: <Widget>[
            ElevatedButton(
              child: const Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Scaffold(
      appBar: AppBar(
        title: const Text("Crear un ticket"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: tituloController,
                  decoration: const InputDecoration(
                    hintText: "Titulo",
                    helperText: "Titulo",
                    icon: Icon(Icons.title),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor introduzca un texto';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  onTap: () {
                    _showDialog(context);
                  },
                  readOnly: true,
                  controller: fechaVencimientoController,
                  decoration: const InputDecoration(
                    helperText: "Fecha de vencimiento",
                    icon: Icon(Icons.edit_calendar),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor introduzca una fecha';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  minLines: 3,
                  maxLines: 5,
                  keyboardType: TextInputType.multiline,
                  controller: descripcionController,
                  decoration: const InputDecoration(
                    hintText: "Descripción",
                    helperText: "Descripción",
                    icon: Icon(Icons.description),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor introduzca un texto';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: valorCompraController,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))
                  ],
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                    hintText: "Valor de compra",
                    helperText: "Valor de compra",
                    icon: Icon(Icons.money),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor introduzca un numero decimal';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 5,
                ),
                Center(
                  child: DropdownButton<String>(
                    hint: const Text("Elija una categoría"),
                    value: dropdownValue,
                    icon: const Icon(Icons.arrow_downward),
                    elevation: 16,
                    style: const TextStyle(color: Colors.deepPurple),
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (String? value) {
                      // This is called when the user selects an item.
                      setState(() {
                        dropdownValue = value!;
                      });
                    },
                    items: list.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(15.0),
                  padding: const EdgeInsets.all(3.0),
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black)),
                  child: Row(
                    children: [
                      const Flexible(
                        fit: FlexFit.tight,
                        flex: 2,
                        child: Text(
                          "Fecha de vencimiento:",
                          overflow: TextOverflow.clip,
                        ),
                      ),
                      Flexible(
                        fit: FlexFit.tight,
                        flex: 2,
                        child: Text(
                          "${fechaVencimiento.year}-${fechaVencimiento.month}-${fechaVencimiento.day}",
                          overflow: TextOverflow.clip,
                        ),
                      ),
                      Flexible(
                        fit: FlexFit.tight,
                        flex: 1,
                        child: IconButton(
                            onPressed: () async {
                              final DateTime? dateTime = await showDatePicker(
                                context: context,
                                initialDate: fechaVencimiento,
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2030),
                              );
                              if (dateTime != null &&
                                  fechaVencimiento.compareTo(fechaPublicacion) >
                                      0) {
                                setState(() {
                                  fechaVencimiento =
                                      DateUtils.dateOnly(dateTime);
                                });
                              }
                            },
                            icon: const Icon(Icons.edit_calendar)),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(15.0),
                  padding: const EdgeInsets.all(3.0),
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black)),
                  child: Row(
                    children: [
                      const Flexible(
                        fit: FlexFit.tight,
                        flex: 2,
                        child: Text(
                          "Fecha de publicacion:",
                          overflow: TextOverflow.clip,
                        ),
                      ),
                      Flexible(
                        fit: FlexFit.tight,
                        flex: 2,
                        child: Text(
                          "${fechaPublicacion.year}-${fechaPublicacion.month}-${fechaPublicacion.day}",
                          overflow: TextOverflow.clip,
                        ),
                      ),
                      Flexible(
                        fit: FlexFit.tight,
                        flex: 1,
                        child: IconButton(
                            onPressed: () async {
                              final DateTime? dateTime = await showDatePicker(
                                context: context,
                                initialDate: fechaPublicacion,
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2030),
                              );
                              if (dateTime != null) {
                                setState(() {
                                  fechaPublicacion =
                                      DateUtils.dateOnly(dateTime);
                                });
                              }
                            },
                            icon: const Icon(Icons.edit_calendar)),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(15.0),
                  padding: const EdgeInsets.all(3.0),
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black)),
                  child: Row(
                    children: [
                      const Flexible(
                        fit: FlexFit.tight,
                        flex: 2,
                        child: Text(
                          "Fecha de fin de publicacion:",
                          overflow: TextOverflow.clip,
                        ),
                      ),
                      Flexible(
                        fit: FlexFit.tight,
                        flex: 2,
                        child: Text(
                          "${fechaFinPublicacion.year}-${fechaFinPublicacion.month}-${fechaFinPublicacion.day}",
                          overflow: TextOverflow.clip,
                        ),
                      ),
                      Flexible(
                        fit: FlexFit.tight,
                        flex: 1,
                        child: IconButton(
                            onPressed: () async {
                              final DateTime? dateTime = await showDatePicker(
                                context: context,
                                initialDate: fechaFinPublicacion,
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2030),
                              );
                              if (dateTime != null) {
                                setState(() {
                                  fechaFinPublicacion =
                                      DateUtils.dateOnly(dateTime);
                                });
                              }
                            },
                            icon: const Icon(Icons.edit_calendar)),
                      )
                    ],
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: ElevatedButton(
                      onPressed: () {
                        // Validate returns true if the form is valid, or false otherwise.
                        if (_formKey.currentState!.validate() &&
                            fechaVencimiento.compareTo(fechaPublicacion) > 0 &&
                            fechaVencimiento.compareTo(fechaFinPublicacion) <
                                0 &&
                            fechaFinPublicacion.compareTo(fechaPublicacion) >
                                0) {
                          var data = {
                            "titulo": tituloController.text,
                            "descripcion": descripcionController.text,
                            "fechaVencimiento": fechaVencimiento.toString(),
                            "fechaPublicacion": fechaPublicacion.toString(),
                            "fechaFinPublicacion":
                                fechaFinPublicacion.toString(),
                            "valorCompra": valorCompraController.text,
                            "categoria": dropdownValue
                          };
                          print(data);
                          Api.addTicket(data);
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const PantallaInicio()),
                            (Route<dynamic> route) => false,
                          );
                          // If the form is valid, display a snackbar. In the real world,
                          // you'd often call a server or save the information in a database.
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Se ha creado un ticket')),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Revise los datos del ticket')),
                          );
                          if (!(fechaVencimiento.compareTo(fechaPublicacion) >
                                  0 ||
                              fechaVencimiento.compareTo(fechaFinPublicacion) <
                                  0)) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      'La fecha de vencimiento debe estar entre el inicio y fin de la fecha de publicacion')),
                            );
                          }
                          if (!(fechaFinPublicacion
                                  .compareTo(fechaPublicacion) >
                              0)) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      'La fecha de fin de publicación debe ser posterior a la de inicio')),
                            );
                          }
                        }
                      },
                      child: const Text('Crear Ticket'),
                    ),
                  ),
                ),
                Center(
                  child: GestureDetector(
                      onTap: () {
                        _showDialog(context);
                      },
                      child: const Text(
                        'Hello World',
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
