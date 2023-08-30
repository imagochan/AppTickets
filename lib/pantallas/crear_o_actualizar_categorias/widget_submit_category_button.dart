import 'package:flutter/material.dart';

class SubmitCategoryButton extends StatefulWidget {
  const SubmitCategoryButton(
      {super.key, required this.retorno, required this.esCrearOActualizar});

  final Function() retorno;
  final bool esCrearOActualizar;

  @override
  State<SubmitCategoryButton> createState() => _SubmitCategoryButtonState();
}

class _SubmitCategoryButtonState extends State<SubmitCategoryButton> {
  //llamamos a la api de crear categorias

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () =>
            widget.retorno(), //retorno execution should go inside {} or =>
        child: Text(widget.esCrearOActualizar
            ? "Crear categoria"
            : "Actualizar categoria"),
      ),
    ));
  }
}
