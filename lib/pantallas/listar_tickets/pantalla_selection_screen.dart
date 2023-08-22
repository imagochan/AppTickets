import 'package:apptickets/pantallas/listar_tickets/widget_date.dart';
import 'package:apptickets/pantallas/listar_tickets/widget_dropdown_menu_category.dart';
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
                  Navigator.pop(context, 'Yep!');
                },
                child: const Text('Yep!'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  // Cierra la pantalla y regresa "Nope!" como el resultado
                  Navigator.pop(context, 'Nope.');
                },
                child: const Text('Nope.'),
              ),
            ),
            FormDateField(fecha: DateTime.now(), controller: fechaCreacionStartController, texto: "Inicio del rango de fecha de creación"),
            FormDateField(fecha: DateTime.now(), controller: fechaCreacionEndController, texto: "Fin del rango de fecha de creación"),
            FormDateField(fecha: DateTime.now(), controller: fechaPublicacionStartController, texto: "Inicio del rango de fecha de publicación"),
            FormDateField(fecha: DateTime.now(), controller: fechaPublicacionEndController, texto: "Fin del rango de fecha de creación"),
            DropdownMenuCategory(dropdownValue: dropdownValue),
            ValorCompraWidget(hintText: "Inicio del rango de valor de compra",labelText: "Inicio del rango de valor de compra",valorCompraController: valorCompraStartController,),
            ValorCompraWidget(hintText: "Fin del rango de valor de compra",labelText: "Fin del rango de valor de compra",valorCompraController: valorCompraEndController,),
          ],
        ),
      ),
    );
  }
}
