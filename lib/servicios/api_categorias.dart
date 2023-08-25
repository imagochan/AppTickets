import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiCategorias {
  static const baseUrl = "http://127.0.0.1:2000/api/";

  //Método para comunicarse con la API de agregar tickets del servidor
  static agregarCategoria(String categoria) async {
    //Creamos la URL de la API
    var url = Uri.parse("${baseUrl}crear_categoria");

    try {
      //Enviamos una solicitud POST con la información del ticket a la API
      final res = await http.post(url, body: categoria);

      if (res.statusCode == 200) {
        //
      } else {
        //
      }
    } catch (e) {
      debugPrint(e.toString()); //foundation.dart
    }
  }
}