import 'package:apptickets/modelos/modelo_bundle_filtro.dart';
import 'package:apptickets/modelos/modelo_categoria.dart';
import 'package:apptickets/pantallas/shared_widgets/widget_date.dart';
import 'package:apptickets/pantallas/shared_widgets/widget_dropdown_menu_category.dart';
import 'package:apptickets/pantallas/shared_widgets/widget_form_text_field.dart';
import 'package:apptickets/pantallas/listar_tickets/widget_radio_buttons.dart';
import 'package:apptickets/pantallas/shared_widgets/widget_text_valor_compra.dart';
import 'package:apptickets/servicios/api_categorias.dart';
import 'package:flutter/material.dart';

class SelectionScreen extends StatefulWidget {
  const SelectionScreen({super.key});

  @override
  State<SelectionScreen> createState() => _SelectionScreenState();
}

class _SelectionScreenState extends State<SelectionScreen> {
  final fechaCreacionStartController = TextEditingController();
  final fechaCreacionEndController = TextEditingController();
  final fechaPublicacionStartController = TextEditingController();
  final fechaPublicacionEndController = TextEditingController();

  String categoriaEscogidaID = '';

  final valorCompraStartController = TextEditingController();
  final valorCompraEndController = TextEditingController();
  final tituloController = TextEditingController();

  DateTime fechaCreacionStart =
      DateUtils.addMonthsToMonthDate(DateTime.now(), -1);
  DateTime fechaCreacionEnd = DateUtils.addMonthsToMonthDate(DateTime.now(), 1);
  DateTime fechaPublicacionStart =
      DateUtils.addMonthsToMonthDate(DateTime.now(), -1);
  DateTime fechaPublicacionEnd =
      DateUtils.addMonthsToMonthDate(DateTime.now(), 1);

  void getCategoria(Categoria categoria) {
    categoriaEscogidaID = categoria.id;
  }

  void getfechaCreacionStart(DateTime fechaTarget) {
    fechaCreacionStart = fechaTarget;
  }

  void getfechaCreacionEnd(DateTime fechaTarget) {
    fechaCreacionEnd = fechaTarget;
  }

  void getfechaPublicactionStart(DateTime fechaTarget) {
    fechaPublicacionStart = fechaTarget;
  }

  void getfechaPublicactionEnd(DateTime fechaTarget) {
    fechaPublicacionEnd = fechaTarget;
  }

  var _first = true;

  void getRadioSelection(bool mySelection) {
    _first = mySelection;
    setState(() {});
  }

  // List<Categoria> listaDeCategorias = ApiCategorias
  //     .getCategorias(); //esto necesitara async? SI LO NECESITA, DEBE SER AWAIT, CREAR UN FUTURE BUILDER

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Escoja sus filtros'),
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
              listaDeCategorias.add(Categoria(categoriaNombre: 'Todas', id: ''));
              //esto es necesario para que exista un valor por defecto,
              //ya que el dropdown no hace nada si no se toca o interactua
              categoriaEscogidaID = listaDeCategorias.last.id;
              debugPrint(listaDeCategorias.toString());
                return SingleChildScrollView(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: () {
                              // Cierra la pantalla y regresa "Yep!" como el resultado
                              Navigator.pop(
                                  context,
                                  BundleFiltros(
                                      valorCompraStart:
                                          valorCompraStartController
                                                  .text.isNotEmpty
                                              ? double.parse(
                                                  valorCompraStartController
                                                      .text)
                                              : 0,
                                      valorCompraEnd: valorCompraEndController
                                              .text.isNotEmpty
                                          ? double.parse(
                                              valorCompraEndController.text)
                                          : 0,
                                      //inicio de mes a fin de mes para default
                                      fechaCreacionStart: fechaCreacionStart,
                                      fechaCreacionEnd: fechaCreacionEnd,
                                      fechaPublicacionStart:
                                          fechaPublicacionStart,
                                      fechaPublicacionEnd: fechaPublicacionEnd,
                                      categoriaID: categoriaEscogidaID, //ojo
                                      titulo: tituloController.text,
                                      esFechaCreacionOPublicidad: _first));
                            },
                            child: const Text('Seleccionar filtros'),
                          ),
                        ),
                        RadioExample(retorno: getRadioSelection),
                        AnimatedCrossFade(
                          duration: const Duration(milliseconds: 250),
                          firstChild: Column(
                            children: [
                              FormDateField(
                                  fecha: fechaCreacionStart,
                                  retorno: getfechaCreacionStart,
                                  controller: fechaCreacionStartController,
                                  texto:
                                      "Inicio del rango de fecha de creación"),
                              FormDateField(
                                  retorno: getfechaCreacionEnd,
                                  fecha: fechaCreacionEnd,
                                  controller: fechaCreacionEndController,
                                  texto: "Fin del rango de fecha de creación"),
                            ],
                          ),
                          secondChild: Column(
                            children: [
                              FormDateField(
                                  retorno: getfechaPublicactionStart,
                                  fecha: fechaPublicacionStart,
                                  controller: fechaPublicacionStartController,
                                  texto:
                                      "Inicio del rango de fecha de publicación"),
                              FormDateField(
                                  retorno: getfechaPublicactionEnd,
                                  fecha: fechaPublicacionEnd,
                                  controller: fechaPublicacionEndController,
                                  texto:
                                      "Fin del rango de fecha de publicación"),
                            ],
                          ),
                          crossFadeState: _first
                              ? CrossFadeState.showFirst
                              : CrossFadeState.showSecond,
                        ),
                        DropdownMenuCategory(
                            retorno: getCategoria,
                            listaCategorias: listaDeCategorias),
                        ValorCompraWidget(
                          hintText: "Inicio del rango de valor de compra",
                          labelText: "Inicio del rango de valor de compra",
                          valorCompraController: valorCompraStartController,
                        ),
                        ValorCompraWidget(
                          hintText: "Fin del rango de valor de compra",
                          labelText: "Fin del rango de valor de compra",
                          valorCompraController: valorCompraEndController,
                        ),
                        FormTextField(
                            controller: tituloController,
                            hintText: "Ingrese un titulo de ticket a buscar",
                            labelText: "Titulo de ticket a buscar")
                      ],
                    ),
                  ),
                );
              }
              return const Text("No hay conexión con el servidor");
            }));
  }
}
