import 'package:apptickets/pantallas/crear_o_actualizar_tickets/widget_submit_button.dart';
import 'package:apptickets/pantallas/pantalla_inicio.dart';
import 'package:apptickets/pantallas/shared_widgets/widget_dropdown_menu_category.dart';
import 'package:flutter/material.dart';
import '../../modelos/modelo_categoria.dart';
import '../../modelos/modelo_ticket.dart';
import '../../servicios/api.dart';
import '../../servicios/api_categorias.dart';
import '../shared_widgets/widget_date.dart';
import '../shared_widgets/widget_form_text_field.dart';
import '../shared_widgets/widget_text_valor_compra.dart';

// Create a Form widget.
class FormCrearEditarTicket extends StatefulWidget {
  const FormCrearEditarTicket(
      {super.key, required this.esCrearOActualizar, required this.unTicket});

  final bool esCrearOActualizar;
  final Ticket unTicket;

  @override
  FormCrearEditarTicketState createState() {
    return FormCrearEditarTicketState();
  }
}

// Create a corresponding State class.
// This class holds unTicket related to the form.
class FormCrearEditarTicketState extends State<FormCrearEditarTicket> {
  @override
  void initState() {
    //Inicializamos los widgets con sus datos actuales
    super.initState();

    if (!widget.esCrearOActualizar) {
      //esto solo actualiza los campos de texto
      //aun debo de actualizar las variables que de verdad se mandan a la API
      tituloController.text = widget.unTicket.titulo.toString();
      descripcionController.text = widget.unTicket.descripcion.toString();
      fechaVencimientoController.text =
          widget.unTicket.fechaVencimiento.toString();
      fechaVencimiento = widget.unTicket.fechaVencimiento;
      fechaPublicacionController.text =
          widget.unTicket.fechaPublicacion.toString();
      fechaPublicacion = widget.unTicket.fechaPublicacion;
      valorCompraController.text = widget.unTicket.valorCompra.toString();
      unaCategoriaID = widget.unTicket.categoriaID;
    }
  }

  void getFechaVencimiento(DateTime fechaTarget) {
    fechaVencimiento = fechaTarget;
  }

  void getFechaPublicacion(DateTime fechaTarget) {
    fechaPublicacion = fechaTarget;
  }

  void getCategoria(Categoria categoria) {
    unaCategoriaID = categoria.id;
  }

  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<FormCrearEditarTicketState>.
  final _formKey = GlobalKey<FormState>();

  //Variables a enviar que no son tipo string
  DateTime fechaVencimiento =
      DateUtils.addDaysToDate(DateUtils.dateOnly(DateTime.now()), 14);
  DateTime fechaPublicacion =
      DateUtils.addDaysToDate(DateUtils.dateOnly(DateTime.now()), 7);
  DateTime fechaCreacion = DateUtils.dateOnly(DateTime.now());
  String unaCategoriaID = '';

  //Controllers
  var tituloController = TextEditingController();
  var descripcionController = TextEditingController();
  var valorCompraController = TextEditingController();
  var fechaVencimientoController = TextEditingController();
  var fechaPublicacionController = TextEditingController();

  //Funcion mostrar dialogo
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
                  MaterialPageRoute(
                      builder: (context) => const PantallaInicio()),
                  (Route<dynamic> route) => false,
                );
              },
            ),
          ],
        );
      },
    );
  }

  //Funcion mandar datos a la API
  void submitData() {
    if (widget.esCrearOActualizar) {
      if (_formKey.currentState!.validate() &&
          fechaVencimiento.compareTo(fechaPublicacion) > 0) {
        //creamos una estructura de datos
        var unTicket = {
          "titulo": tituloController.text,
          "descripcion": descripcionController.text,
          "fechaVencimiento": fechaVencimiento.toString(),
          "fechaPublicacion": fechaPublicacion.toString(),
          "valorCompra": valorCompraController.text,
          "categoriaID": unaCategoriaID,
          "fechaCreacion": fechaCreacion.toString()
        };

        //imprimimos los datos para checar que este en orden
        debugPrint(unTicket.toString());

        //llamamos a la api de crear tickets
        Api.addTicket(unTicket);
        _showDialog(context, "Se ha creado un ticket");
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Revise los datos del ticket')),
        );
        if (!(fechaVencimiento.compareTo(fechaPublicacion) > 0)) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text(
                    'La fecha de vencimiento debe ser posterior a la fecha de publicacion')),
          );
        }
      }
    } else {
      Api.updateTicket(widget.unTicket.id, {
        "titulo": tituloController.text,
        "descripcion": descripcionController.text,
        "fechaVencimiento": fechaVencimiento.toString(),
        "fechaPublicacion": fechaPublicacion.toString(),
        "valorCompra": valorCompraController.text,
        "categoriaID": unaCategoriaID
      });
      Navigator.pop(context);
    }
  }

  // List<Categoria> listaDeCategorias = ApiCategorias
  //     .getCategorias(); //esto necesitara async? SI, necesitamos un future builder

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.esCrearOActualizar
            ? "Crear un Ticket"
            : "Actualizar un Ticket"),
      ),
      body: FutureBuilder(
          future: ApiCategorias.getCategorias(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return const Text("hubo un error");
            }
            if (snapshot.hasData) {
              List<Categoria> listaDeCategorias = snapshot.data;
              //esto es necesario para que exista un valor por defecto,
              //ya que el dropdown no hace nada si no se toca o interactua
              unaCategoriaID = listaDeCategorias.first.id;
              debugPrint(listaDeCategorias.toString());
              return SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FormTextField(
                          controller: tituloController,
                          hintText: "Ingrese un Titulo",
                          labelText: "Titulo",
                        ),
                        FormTextField(
                          controller: descripcionController,
                          hintText: "Ingrese una Descripción",
                          labelText: "Descripción",
                        ),
                        ValorCompraWidget(
                            valorCompraController: valorCompraController,
                            hintText: "Ingrese un valor de compra",
                            labelText: "Valor de compra"),
                        FormDateField(
                          fecha: fechaPublicacion,
                          controller: fechaPublicacionController,
                          // llamarDatePicker: llamarDatePicker,
                          retorno: getFechaPublicacion,
                          texto: "Fecha de publicación",
                        ),
                        FormDateField(
                          fecha: fechaVencimiento,
                          controller: fechaVencimientoController,
                          // llamarDatePicker: llamarDatePicker,
                          retorno: getFechaVencimiento,
                          texto: "Fecha de vencimiento",
                        ),
                        DropdownMenuCategory(
                            retorno: getCategoria,
                            listaCategorias: listaDeCategorias),
                        SubmitTicketButton(
                          submitData: submitData,
                          esCrearOActualizar: widget.esCrearOActualizar,
                        )
                      ],
                    ),
                  ),
                ),
              );
            }
            return const Text(
                "No hay conexión con el servidor"); //can be improved
          }),
    );
  }
}
