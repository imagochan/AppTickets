import 'package:apptickets/modelos/modelo_bundle_filtro.dart';
import 'package:apptickets/pantallas/listar_tickets/widget_date.dart';
import 'package:apptickets/pantallas/listar_tickets/widget_dropdown_menu_category.dart';
import 'package:apptickets/pantallas/listar_tickets/widget_form_text_field.dart';
import 'package:apptickets/pantallas/listar_tickets/widget_text_valor_compra.dart';
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

  String? dropdownValue;
  final valorCompraStartController = TextEditingController();
  final valorCompraEndController = TextEditingController();
  final tituloController = TextEditingController();

  DateTime? fechaCreacionStart = DateUtils.addDaysToDate(DateTime.now(), 6);
  DateTime? fechaCreacionEnd = DateUtils.addDaysToDate(DateTime.now(), 8);
  DateTime? fechaPublicacionStart = DateUtils.addDaysToDate(DateTime.now(), 6);
  DateTime? fechaPublicacionEnd = DateUtils.addDaysToDate(DateTime.now(), 8);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick an option'),
      ),
      body: Center(
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
                          valorCompraStart: valorCompraStartController
                                  .text.isNotEmpty
                              ? double.parse(valorCompraStartController.text)
                              : null,
                          valorCompraEnd:
                              valorCompraEndController.text.isNotEmpty
                                  ? double.parse(valorCompraEndController.text)
                                  : null,
                          fechaCreacionStart: fechaCreacionStart,
                          fechaCreacionEnd: fechaCreacionEnd,
                          fechaPublicacionStart: fechaPublicacionStart,
                          fechaPublicacionEnd: fechaPublicacionEnd,
                          categoria: dropdownValue,
                          titulo: tituloController.text));
                },
                child: const Text('Seleccionar filtros'),
              ),
            ),
            Padding(
              //LIMPIAR LA SELECCION para resetear filtros
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  // Cierra la pantalla y regresa "Nope!" como el resultado
                  Navigator.pop(context, 'Nope.');
                },
                child: const Text('Nope.'),
              ),
            ),
            FormDateField(
                firstDate: DateTime.now(),
                chosenDate: fechaCreacionStart,
                controller: fechaCreacionStartController,
                texto: "Inicio del rango de fecha de creación"),
            FormDateField(
                firstDate: DateTime.now(),
                chosenDate: fechaCreacionEnd,
                controller: fechaCreacionEndController,
                texto: "Fin del rango de fecha de creación"),
            FormDateField(
                firstDate: DateTime.now(),
                chosenDate: fechaPublicacionStart,
                controller: fechaPublicacionStartController,
                texto: "Inicio del rango de fecha de publicación"),
            FormDateField(
                firstDate: DateTime.now(),
                chosenDate: fechaPublicacionEnd,
                controller: fechaPublicacionEndController,
                texto: "Fin del rango de fecha de creación"),
            DropdownMenuCategory(dropdownValue: dropdownValue),
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
}
