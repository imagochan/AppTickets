import 'package:flutter/material.dart';

final List<String> list = <String>[
  'Comedia',
  'Historia',
  'Ficción',
  'Acción',
  'Drama',
  'ALL'
];

class DropdownMenuCategory extends StatefulWidget {
  const DropdownMenuCategory({super.key, required this.retorno, required this.unaCategoria});

  final Function(String miCategoria) retorno;
  final String unaCategoria;

  @override
  State<DropdownMenuCategory> createState() => _DropdownMenuCategoryState();
}

class _DropdownMenuCategoryState extends State<DropdownMenuCategory> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: DropdownButtonFormField<String>(
          // validator: (value) {
          //   //if (value.isEmpty) {
          //   //  return 'Por favor seleccione una categoria';
          //   //}
          //   return null;
          // },
          isExpanded: true,
          hint: const Text("Elija una categoría"),
          value: widget.unaCategoria,
          icon: const Icon(Icons.arrow_downward),
          elevation: 16,
          onChanged: (String? value) {
            //setState(() {
            //  dropdownValue = value!;
            //});
            //widget.dropdownValue = value!;
            widget.retorno(value!);
          },
          items: list.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }
}
