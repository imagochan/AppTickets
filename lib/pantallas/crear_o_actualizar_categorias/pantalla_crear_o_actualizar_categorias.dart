import 'package:apptickets/pantallas/crear_o_actualizar_categorias/widget_submit_category_button.dart';
import 'package:apptickets/servicios/api_categorias.dart';
import 'package:flutter/material.dart';

import '../shared_widgets/widget_form_text_field.dart';

class PantallaCrearOActualizarCategorias extends StatefulWidget {
  const PantallaCrearOActualizarCategorias({super.key});

  @override
  State<PantallaCrearOActualizarCategorias> createState() => _PantallaCrearOActualizarCategoriasState();
}

class _PantallaCrearOActualizarCategoriasState extends State<PantallaCrearOActualizarCategorias> {

  TextEditingController categoriaController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void submitCategory(){
    //hacer logica de llamar a la api de crear categoria
    if (_formKey.currentState!.validate()){
      ApiCategorias.agregarCategoria(categoriaController.text);
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('se ha creado una categoria')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Revise los datos de la categoria')),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              FormTextField(controller: categoriaController, hintText: "Ingrese una categoria", labelText: "Categoria",),
              SubmitCategoryButton(retorno: submitCategory),
            ],
          ),
        ),
      ),
    );
  }
}