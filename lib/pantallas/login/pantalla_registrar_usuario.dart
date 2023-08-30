import 'package:apptickets/pantallas/login/widget_campo_email.dart';
import 'package:apptickets/pantallas/login/widget_campo_telefono.dart';
import 'package:apptickets/pantallas/shared_widgets/widget_campo_fecha.dart';
import 'package:apptickets/pantallas/shared_widgets/widget_campo_texto.dart';
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
  var telefonoController = TextEditingController();

  DateTime fechaNacimiento = DateUtils.addMonthsToMonthDate(
      DateUtils.dateOnly(DateTime.now()), -12 * 18);

  void getFechaNacimiento(DateTime fechaRetornada) {
    fechaNacimiento = fechaRetornada;
  }

  var fechaNacimientoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registrar cliente"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CampoTexto(
                    controller: nombreCompletoController,
                    hintText: "Ingrese su nombre completo",
                    labelText: "Nombre completo"),
                CampoCorreoElectronico(
                    correoElectronicoController: correoElectronicoController,
                    hintText: "Ingrese un correo electrónico",
                    labelText: "Correo electrónico"),
                CampoTelefono(
                    telefonoController: telefonoController,
                    hintText: "Ingrese un número de teléfono",
                    labelText: "Número de teléfono"),
                CampoFecha(
                    retorno: getFechaNacimiento,
                    controller: fechaNacimientoController,
                    texto: "Fecha de nacimiento",
                    fecha: fechaNacimiento),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
