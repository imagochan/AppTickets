import 'package:apptickets/pantallas/shared_widgets/widget_form_text_field.dart';
import 'package:flutter/material.dart';

class PantallaRegistrarCliente extends StatefulWidget {
  const PantallaRegistrarCliente({super.key});

  @override
  State<PantallaRegistrarCliente> createState() =>
      _PantallaRegistrarClienteState();
}

class _PantallaRegistrarClienteState extends State<PantallaRegistrarCliente> {
  final _formKey = GlobalKey<FormState>();

  var nombreCompletoController = TextEditingController();
  var correoElectronicoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FormTextField(
                  controller: nombreCompletoController,
                  hintText: "Ingrese su nombre completo",
                  labelText: "Nombre completo"),
              FormTextField(
                  controller: correoElectronicoController,
                  hintText: "Ingrese un correo electrónico",
                  labelText: "Correo electrónico"),
            ],
          ),
        ),
      ),
    );
  }
}