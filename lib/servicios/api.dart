import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:apptickets/modelos/modelo_ticket.dart';

//Clase que contiene métodos para interactuar con la API del servidor

class Api {
  //IP del servidor de Tickets
  static const baseUrl = "http://127.0.0.1:2000/api/";

  //Método para comunicarse con la API de agregar tickets del servidor
  static addTicket(Map tdata) async {
    //Creamos la URL de la API
    var url = Uri.parse("${baseUrl}add_ticket");

    try {
      //Enviamos una solicitud POST con la información del ticket a la API
      final res = await http.post(url, body: tdata);

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
    //Iniciamos una lista de tickets vacía
    List<Ticket> tickets = [];

    //Creamos la URL de la API
    var url = Uri.parse("${baseUrl}get_ticket");

    try {
      //Enviamos una solicitud GET a la API
      final res = await http.get(url);
      if (res.statusCode == 200) {
        //Declaramos una variable para almacenar la información recibida
        var data = jsonDecode(res.body);

        //añadimos a la lista de tickets la información recibida de la API
        data['tickets'].forEach(
          (value) => {
            tickets.add(Ticket(
                value['id'],
                value['titulo'],
                value['descripcion'],
                value['fechaVencimiento'],
                value['fechaPublicacion'],
                value['fechaFinPublicacion'],
                value['valorCompra'],
                value['categoria'])),
          },
        );
        return tickets;
      } else {
        //
      }
    } catch (e) {
      debugPrint(e.toString()); //foundation.dart
    }
  }

  //Método para comunicarse con la API de actualizar tickets del servidor
  static updateTicket(id, body) async {
    //Configuramos la URL a usar junto con el id del ticket a actualizar
    var url = Uri.parse("${baseUrl}update_ticket/$id");

    //Enviamos una solicitud POST al servidor conteniendo
    //el id del ticket a actualizar
    final res = await http.post(url, body: body);
    if (res.statusCode == 200) {
      //
    } else {
      //
    }
  }

    //Método para comunicarse con la API de borrar tickets del servidor
  static deleteTicket(id) async {
    //Configuramos la URL a usar junto con el ID del ticket a borrar
    var url = Uri.parse("${baseUrl}delete_ticket/$id");

    //Enviamos una solicitud POST al servidor conteniendo
    //El id del ticket a borrar
    final res = await http.post(url);

    if (res.statusCode == 204) {
      //Asegurar que la transacción se ejecute correctamente
      //confirmando que el body no este vacío
      if (res.body.isNotEmpty) {
        json.decode(res.body);
      }
    } else {
      //
    }
  }
}
