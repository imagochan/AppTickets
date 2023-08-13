import 'package:flutter/material.dart';

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

  DateTime selectedDate = DateTime.now();

  var fechaVencimientoController = TextEditingController();

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
                  "${selectedDate.year} - ${selectedDate.month.toString().padLeft(2, '0')} - ${selectedDate.day}"),
              Text(selectedDate.toString()),
              Text("hola"),
              Text(DateTime.parse('2023-08-13').toString()),
              Text(DateTime.parse(
                      "${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day}")
                  .toString()),
              Text(DateUtils.dateOnly(selectedDate).toString()),
              Text("hola2"),
              ElevatedButton(
                  onPressed: () async {
                    final DateTime? dateTime = await showDatePicker(
                      context: context,
                      initialDate: selectedDate,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(3000),
                    );
                    if (dateTime != null) {
                      setState(() {
                        selectedDate = dateTime;
                        fechaVencimientoController.text = dateTime.toString();
                      });
                    }
                  },
                  child: const Text("Choose Date")),
              Row(
                children: [
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 5,
                    child: TextFormField(
                      decoration: const InputDecoration(
                          hintText: "fecha de vencimiento"),
                      controller: fechaVencimientoController,
                    ),
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 1,
                    child: IconButton(
                        onPressed: () async {
                          final DateTime? dateTime = await showDatePicker(
                            context: context,
                            initialDate: selectedDate,
                            firstDate: DateTime(2000),
                            lastDate: DateTime(3000),
                          );
                          if (dateTime != null) {
                            setState(() {
                              selectedDate = dateTime;
                              fechaVencimientoController.text =
                                  dateTime.toString();
                            });
                          }
                        },
                        icon: const Icon(Icons.edit_calendar)),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
