import 'package:apptickets/pantallas/crear_o_actualizar_categorias/widget_submit_category_button.dart';
import 'package:apptickets/servicios/api_categorias.dart';
import 'package:flutter/material.dart';

import '../../modelos/modelo_categoria.dart';
import '../shared_widgets/widget_form_text_field.dart';

class PantallaCrearOActualizarCategorias extends StatefulWidget {
  const PantallaCrearOActualizarCategorias({
    super.key,
    required this.esCrearOActualizar,
    required this.unaCategoria
  });

  final bool esCrearOActualizar;
  final Categoria unaCategoria;

  @override
  State<PantallaCrearOActualizarCategorias> createState() => _PantallaCrearOActualizarCategoriasState();
}

class _PantallaCrearOActualizarCategoriasState extends State<PantallaCrearOActualizarCategorias> {

  String categoriaID='';

  @override
  void initState(){
    super.initState();
    if (!widget.esCrearOActualizar) {
      categoriaController.text = widget.unaCategoria.categoriaNombre;
      categoriaID = widget.unaCategoria.id;
    }
  }

  //Controllers
  TextEditingController categoriaController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void submitCategory(){
    //hacer logica de llamar a la api de crear categoria
    if (widget.esCrearOActualizar) {
      //creando...
      if (_formKey.currentState!.validate()){
        var unaCategoria = {
          "categoriaNombre":categoriaController.text
        };
        ApiCategorias.agregarCategoria(unaCategoria);
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('se ha creado una categoria')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Revise los datos de la categoria')),
        );
      }
    } else {
      //actualizando...
      ApiCategorias.actualizarCategoria(
        widget.unaCategoria.id,
        {
          "categoria":widget.unaCategoria.categoriaNombre
        }
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.esCrearOActualizar?"Crear una categoria":"Actualizar una categoria"),
      ),
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