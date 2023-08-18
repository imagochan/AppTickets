import 'package:apptickets/pantallas/pantalla_inicio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../servicios/api.dart';

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
  void _showDialog(BuildContext context) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text("Mensaje"),
          content: Text("Se ha creado un ticket"),
          actions: <Widget>[
            ElevatedButton(
              child: Text("Regresar al menu principal"),
              onPressed: () {
                //Navigator.of(context).pop();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => PantallaInicio()),
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
      //bool isSuccesful = Api.addTicket(data);
      Api.addTicket(data);
      _showDialog(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Revise los datos del ticket')),
      );
      if (!(fechaVencimiento.compareTo(fechaPublicacion) > 0 ||
          fechaVencimiento.compareTo(fechaFinPublicacion) < 0)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  'La fecha de vencimiento debe estar entre el inicio y fin de la fecha de publicacion')),
        );
      }
      if (!(fechaFinPublicacion.compareTo(fechaPublicacion) > 0)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
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
        padding: EdgeInsets.symmetric(vertical: 16),
        child: ElevatedButton(
          onPressed: () {
            submitData();
          },
          child: Text('Crear Ticket'),
        ),
      ),
    );

    var selectorCategoria = Center(
      child: DropdownButtonFormField<String>(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor seleccione una categoria';
          }
          return null;
        },
        isExpanded: true,
        hint: Text("Elija una categoría"),
        value: dropdownValue,
        icon: Icon(Icons.arrow_downward),
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

    return Scaffold(
      appBar: AppBar(
        title: Text("Crear un Ticket"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                form_field_widget(
                  controller: tituloController,
                  hintText: "Ingrese un Titulo",
                  labelText: "Titulo",
                ),
                SizedBox(
                  height: 10,
                ),
                form_field_widget(
                  controller: descripcionController,
                  hintText: "Ingrese una Descripción",
                  labelText: "Descripción",
                ),
                SizedBox(
                  height: 10,
                ),
                valorCompraWidget(valorCompraController: valorCompraController),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  onTap: () async {
                    final DateTime? dateTime = await showDatePicker(
                      context: context,
                      initialDate: fechaVencimiento,
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2030),
                    );
                    if (dateTime != null) {
                      setState(() {
                        fechaVencimiento = DateUtils.dateOnly(dateTime);
                        fechaVencimientoController.text =
                            fechaVencimiento.toString();
                      });
                    }
                  },
                  readOnly: true,
                  controller: fechaVencimientoController,
                  decoration: InputDecoration(
                    //helperText: "Fecha de vencimiento",
                    hintText: "Fecha de vencimiento",
                    labelText: "Fecha de vencimiento",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    icon: Icon(Icons.edit_calendar),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor seleccione una fecha';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  onTap: () async {
                    final DateTime? dateTime = await showDatePicker(
                      context: context,
                      initialDate: fechaPublicacion,
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2030),
                    );
                    if (dateTime != null) {
                      setState(() {
                        fechaPublicacion = DateUtils.dateOnly(dateTime);
                        fechaPublicacionController.text =
                            fechaPublicacion.toString();
                      });
                    }
                  },
                  readOnly: true,
                  controller: fechaPublicacionController,
                  decoration: InputDecoration(
                    //helperText: "Fecha de publicación",
                    hintText: "Fecha de publicación",
                    labelText: "Fecha de publicación",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    icon: Icon(Icons.edit_calendar),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor seleccione una fecha';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  onTap: () async {
                    final DateTime? dateTime = await showDatePicker(
                      context: context,
                      initialDate: fechaFinPublicacion,
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2030),
                    );
                    if (dateTime != null) {
                      setState(() {
                        fechaFinPublicacion = DateUtils.dateOnly(dateTime);
                        fechaFinPublicacionController.text =
                            fechaFinPublicacion.toString();
                      });
                    }
                  },
                  readOnly: true,
                  controller: fechaFinPublicacionController,
                  decoration: InputDecoration(
                    //helperText: "Fecha de fin de publicación",
                    hintText: "Fecha de fin de publicación",
                    labelText: "Fecha de fin de publicación",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    icon: Icon(Icons.edit_calendar),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor seleccione una fecha';
                    }
                    return null;
                  },
                ),
                SizedBox(
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

class valorCompraWidget extends StatelessWidget {
  valorCompraWidget({
    super.key,
    required this.valorCompraController,
  });

  final TextEditingController valorCompraController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: valorCompraController,
      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))],
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        hintText: "Ingrese un Valor de compra",
        //helperText: "Valor de compra",
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
  form_field_widget({
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
        icon: Icon(Icons.title),
        border: OutlineInputBorder(),
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
