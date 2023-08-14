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

  DateTime fechaVencimiento = DateTime.now();
  DateTime fechaPublicacion = DateTime.now();
  DateTime fechaFinPublicacion = DateTime.now();
  String? categoriaSeleccionada;

  var fechaVencimientoController = TextEditingController();

  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.send),
                  hintText: 'Hint Text',
                  helperText: 'Helper Text',
                  counterText: '0 characters',
                  border: OutlineInputBorder(),
                ),
              ),
              TextFormField(
                decoration: const InputDecoration(hintText: "titulo"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(hintText: "descripcion"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: ElevatedButton(
                  onPressed: () {
                    // Validate returns true if the form is valid, or false otherwise.
                    if (_formKey.currentState!.validate()) {
                      // If the form is valid, display a snackbar. In the real world,
                      // you'd often call a server or save the information in a database.
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data')),
                      );
                    }
                  },
                  child: const Text('Submit'),
                ),
              ),
              Text(
                  "${fechaVencimiento.year} - ${fechaVencimiento.month.toString().padLeft(2, '0')} - ${fechaVencimiento.day}"),
              Text(fechaVencimiento.toString()),
              Text("hola"),
              Text(DateTime.parse('2023-08-13').toString()),
              Text(DateTime.parse(
                      "${fechaVencimiento.year}-${fechaVencimiento.month.toString().padLeft(2, '0')}-${fechaVencimiento.day}")
                  .toString()),
              Text(DateUtils.dateOnly(fechaVencimiento).toString()),
              Text("hola2"),
              ElevatedButton(
                  onPressed: () async {
                    final DateTime? dateTime = await showDatePicker(
                      context: context,
                      initialDate: fechaVencimiento,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(3000),
                    );
                    if (dateTime != null) {
                      setState(() {
                        fechaVencimiento = dateTime;
                        fechaVencimientoController.text = dateTime.toString();
                      });
                    }
                  },
                  child: const Text("Choose Date")),
              Row(
                children: [
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 2,
                    child: Text("Fecha de vencimiento: $fechaVencimiento"),
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
                          if (dateTime != null) {
                            setState(() {
                              fechaVencimiento = dateTime;
                              fechaVencimientoController.text =
                                  dateTime.toString();
                            });
                          }
                        },
                        icon: const Icon(Icons.edit_calendar)),
                  )
                ],
              ),
              Row(
                children: [
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 2,
                    child: Text("Fecha de publicación: $fechaPublicacion"),
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
                              fechaPublicacion = dateTime;
                            });
                          }
                        },
                        icon: const Icon(Icons.edit_calendar)),
                  )
                ],
              ),
              Row(
                children: [
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 2,
                    child: Text(
                        "Fecha de fin de publicación: $fechaFinPublicacion"),
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
                              fechaFinPublicacion = dateTime;
                            });
                          }
                        },
                        icon: const Icon(Icons.edit_calendar)),
                  )
                ],
              ),
              TextFormField(
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))
                ],
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(hintText: "Valor de compra"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              DropdownButton<String>(
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
