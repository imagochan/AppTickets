import 'package:apptickets/pantallas/pantalla_inicio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../servicios/api.dart';

//TODO:boolean para editar y sus respectivos casos, renombrar pantalla a solo formulario

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
  
  final List<String> list = <String>[
    'Comedia',
    'Historia',
    'Ficción',
    'Acción',
    'Drama'
  ];
  
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

  String? dropdownValue;

  var tituloController = TextEditingController();
  var descripcionController = TextEditingController();
  var valorCompraController = TextEditingController();

  var fechaVencimientoController = TextEditingController();
  var fechaPublicacionController = TextEditingController();
  var fechaFinPublicacionController = TextEditingController();

  // user defined function void _showDialog(BuildContext context) {
  void _showDialog(BuildContext context, String mensaje) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: const Text("Mensaje"),
          content: Text(mensaje),
          actions: <Widget>[
            ElevatedButton(
              child: const Text("Regresar al menu principal"),
              onPressed: () {
                //Navigator.of(context).pop();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const PantallaInicio()),
                  (Route<dynamic> route) => false,
                );
              },
            ),
          ],
        );
      },
    );
  }

  void submitData() {
    if (_formKey.currentState!.validate() &&
        fechaVencimiento.compareTo(fechaPublicacion) > 0 &&
        fechaVencimiento.compareTo(fechaFinPublicacion) < 0 &&
        fechaFinPublicacion.compareTo(fechaPublicacion) > 0) {
      //creamos una estructura de datos
      var data = {
        "titulo": tituloController.text,
        "descripcion": descripcionController.text,
        "fechaVencimiento": fechaVencimiento.toString(),
        "fechaPublicacion": fechaPublicacion.toString(),
        "fechaFinPublicacion": fechaFinPublicacion.toString(),
        "valorCompra": valorCompraController.text,
        "categoria": dropdownValue
      };
      //imprimimos los datos para checar que este en orden
      print(data);
      //llamamos a la api de crear tickets
      //TODO: bool isSuccesful = Api.addTicket(data);
      Api.addTicket(data);
      _showDialog(context,"Se ha creado un ticket");
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Revise los datos del ticket')),
      );
      if (!(fechaVencimiento.compareTo(fechaPublicacion) > 0 ||
          fechaVencimiento.compareTo(fechaFinPublicacion) < 0)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text(
                  'La fecha de vencimiento debe estar entre el inicio y fin de la fecha de publicacion')),
        );
      }
      if (!(fechaFinPublicacion.compareTo(fechaPublicacion) > 0)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text(
                  'La fecha de fin de publicación debe ser posterior a la de inicio')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.

    var botonCrearTicket = Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: ElevatedButton(
          onPressed: () {
            submitData();
          },
          child: const Text('Crear Ticket'),
        ),
      ),
    );

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
    );

    Future<void> llamarDatePicker(DateTime date, TextEditingController controller) async {
      final DateTime? dateTime = await showDatePicker(
                      context: context,
                      initialDate: date,
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2030),
                    );
                    if (dateTime != null) {
                      setState(() {
                        date = DateUtils.dateOnly(dateTime);
                        controller.text =
                            date.toString();
                      });
                    }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Crear un Ticket"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                form_field_widget(
                  controller: tituloController,
                  hintText: "Ingrese un Titulo",
                  labelText: "Titulo",
                ),
                const SizedBox(
                  height: 10,
                ),
                form_field_widget(
                  controller: descripcionController,
                  hintText: "Ingrese una Descripción",
                  labelText: "Descripción",
                ),
                const SizedBox(
                  height: 10,
                ),
                valorCompraWidget(valorCompraController: valorCompraController),
                const SizedBox(
                  height: 10,
                ),
                form_date_field_widget(fecha: fechaVencimiento, controller: fechaVencimientoController, llamarDatePicker: llamarDatePicker, texto: "Fecha de vencimiento",),
                const SizedBox(
                  height: 10,
                ),
                form_date_field_widget(fecha: fechaPublicacion, controller: fechaPublicacionController, llamarDatePicker: llamarDatePicker, texto: "Fecha de publicación",),
                const SizedBox(
                  height: 10,
                ),
                form_date_field_widget(fecha: fechaFinPublicacion, controller: fechaFinPublicacionController, llamarDatePicker: llamarDatePicker, texto: "Fecha de fin publicación",),
                const SizedBox(
                  height: 10,
                ),
                selectorCategoria,
                botonCrearTicket,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
//TODO: mover clases a archivos
class form_date_field_widget extends StatelessWidget {
  const form_date_field_widget({
    super.key,
    required this.fecha,
    required this.controller,
    required this.llamarDatePicker,
    required this.texto,
  });

  final DateTime fecha;
  final TextEditingController controller;
  final Function llamarDatePicker;
  final String texto;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: () async {
        llamarDatePicker(fecha, controller);
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

class valorCompraWidget extends StatelessWidget {
  const valorCompraWidget({
    super.key,
    required this.valorCompraController,
  });

  final TextEditingController valorCompraController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: valorCompraController,
      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))],
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      decoration: const InputDecoration(
        hintText: "Ingrese un Valor de compra",
        labelText: "Valor de compra",
        icon: Icon(Icons.money),
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor introduzca un numero decimal';
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
