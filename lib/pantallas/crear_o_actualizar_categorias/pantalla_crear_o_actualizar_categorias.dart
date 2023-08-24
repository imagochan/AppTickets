import 'package:apptickets/pantallas/crear_o_actualizar_categorias/widget_submit_category_button.dart';
import 'package:flutter/material.dart';

import '../shared_widgets/widget_form_text_field.dart';

class PantallaCrearOActualizarCategorias extends StatefulWidget {
  const PantallaCrearOActualizarCategorias({super.key});

  @override
  State<PantallaCrearOActualizarCategorias> createState() => _PantallaCrearOActualizarCategoriasState();
}

class _PantallaCrearOActualizarCategoriasState extends State<PantallaCrearOActualizarCategorias> {

  TextEditingController categoriaController = TextEditingController();

  void submitCategory(){

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Form(
          child: Column(
            children: [
              FormTextField(controller: categoriaController, hintText: "Ingrese una categoria", labelText: "Categoria",),
              SubmitCategoryButton(),
            ],
          ),
        ),
      ),
    );
  }
}