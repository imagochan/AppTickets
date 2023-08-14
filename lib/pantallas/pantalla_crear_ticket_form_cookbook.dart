import 'package:apptickets/pantallas/pantalla_inicio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  DateTime fechaPublicacion = DateTime.now();
  DateTime fechaFinPublicacion = DateUtils.addDaysToDate(DateTime.now(), 14);

  String? categoriaSeleccionada;

  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ingrese datos del ticket a crear"),
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
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
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
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueAccent)),
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
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueAccent)),
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
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueAccent)),
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
                          // If the form is valid, display a snackbar. In the real world,
                          // you'd often call a server or save the information in a database.
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Se ha creado un ticket')),
                          );
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const PantallaInicio()),
                            (Route<dynamic> route) => false,
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Revise los datos del ticket')),
                          );
                        }
                      },
                      child: const Text('Crear Ticket'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
