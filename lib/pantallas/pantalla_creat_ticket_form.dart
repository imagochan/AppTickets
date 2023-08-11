import 'package:flutter/material.dart';

class CrearTicketForm extends StatefulWidget {
  const CrearTicketForm({super.key});

  @override
  State<CrearTicketForm> createState() => _CrearTicketFormState();
}

class _CrearTicketFormState extends State<CrearTicketForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pantalla Form Crear Ticket"),
      ),
      body: const SingleChildScrollView(
        child: Center(
          child: Padding(padding: EdgeInsets.all(8),
          child: FormularioCrearTicket(),
          ),
        ),
      ),
    );
  }
}

class FormularioCrearTicket extends StatefulWidget {
  const FormularioCrearTicket({super.key});

  @override
  State<FormularioCrearTicket> createState() => _FormularioCrearTicketState();
}

class _FormularioCrearTicketState extends State<FormularioCrearTicket> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Enter your email',
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              icon: Icon(Icons.person),
              hintText: 'What do people call you?',
              labelText: 'Name *',
            ),
            onSaved: (String? value) {
              // This optional block of code can be used to run
              // code when the user saves the form.
            },
            validator: (String? value) {
              return (value != null && value.contains('@')) ? 'Do not use the @ char.' : null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                // Validate will return true if the form is valid, or false if
                // the form is invalid.
                if (_formKey.currentState!.validate()) {
                  // Process data.
                }
              },
              child: const Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}