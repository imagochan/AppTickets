import 'package:flutter/material.dart';

import '../../modelos/modelo_categoria.dart';

// final List<String> list = <String>[
//   'Comedia',
//   'Historia',
//   'Ficción',
//   'Acción',
//   'Drama',
//   'ALL'
// ];

class DropdownMenuCategory extends StatefulWidget {
  const DropdownMenuCategory(
      {super.key, required this.retorno, required this.listaCategorias});

  final Function(Categoria miCategoria) retorno;
  final List<Categoria> listaCategorias;

  @override
  State<DropdownMenuCategory> createState() => _DropdownMenuCategoryState();
}

class _DropdownMenuCategoryState extends State<DropdownMenuCategory> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: DropdownButtonFormField<Categoria>(
          // validator: (value) {
          //   //if (value.isEmpty) {
          //   //  return 'Por favor seleccione una categoria';
          //   //}
          //   return null;
          // },
          isExpanded: true,
          hint: const Text("Elija una categoría"),
          //value: widget.unaCategoria,
          value: widget
              .listaCategorias.first, //ojo necesitamos un valor por defecto
          icon: const Icon(Icons.arrow_downward),
          elevation: 16,
          onChanged: (Categoria? value) {
            //setState(() {
            //  dropdownValue = value!;
            //});
            //widget.dropdownValue = value!;
            widget.retorno(value!);
          },
          //cambiar list. a widget.unaLista que voy a pasar al boton
          items: widget.listaCategorias
              .map<DropdownMenuItem<Categoria>>((Categoria value) {
            return DropdownMenuItem<Categoria>(
              value: value,
              child: Text(value.categoriaNombre),
            );
          }).toList(),
        ),
      ),
    );
  }
}
