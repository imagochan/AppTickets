import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../modelos/modelo_categoria.dart';

class ApiCategorias {
  static const baseUrl = "http://127.0.0.1:2000/api/";

  //Método para comunicarse con la API de agregar tickets del servidor
  static agregarCategoria(Map mapCategoria) async {
    //Creamos la URL de la API
    var url = Uri.parse("${baseUrl}crear_categoria");

    try {
      //Enviamos una solicitud POST con la información del ticket a la API
      final res = await http.post(url, body: mapCategoria);

      if (res.statusCode == 200) {
        //
      } else {
        //
      }
    } catch (e) {
      debugPrint(e.toString()); //foundation.dart
    }
  }

  //Método para comunicarse con la API de obtener tickets del servidor
  static getTicket() async {
    
    //Iniciamos una lista de categorías vacía
    List<Categoria> listaCategorias = [];
    
    var url = Uri.parse(
        "${baseUrl}get_categorias");

    debugPrint(url.toString());

    try {
      //Enviamos una solicitud GET a la API
      final res = await http.get(url);
      if (res.statusCode == 200) {
        //print("peticion get funciono");
        //Declaramos una variable para almacenar la información recibida
        var data = jsonDecode(res.body);

        //print("the data looks like this");
        //print(data);

        //añadimos a la lista de tickets la información recibida de la API
        data['categorias'].forEach(
          (value) => {
            listaCategorias.add(Categoria(
                id: value['id'],
                categoriaNombre: value['categoriaNombre'],
            )),
          },
        );
        return listaCategorias;
      } else {
        //
      }
    } catch (e) {
      debugPrint(e.toString()); //foundation.dart
    }
  }

}