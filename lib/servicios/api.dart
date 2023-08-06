import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:apptickets/modelos/modelo_ticket.dart';

class Api {
  static const baseUrl = "http://127.0.0.1:2000/api/";

  //add ticket
  static addTicket(Map tdata) async {
    //print(tdata);
    var url = Uri.parse("${baseUrl}add_ticket");

    try {
      final res = await http.post(url, body: tdata);

      if (res.statusCode == 200) {
        //var data = jsonDecode(res.body.toString());
        //print(data);
      } else {
        //print("failed to get response");
      }
    } catch (e) {
      debugPrint(e.toString()); //foundation.dart
    }
  }

  // get ticket
  static getTicket() async {
    List<Ticket> tickets = [];

    var url = Uri.parse("${baseUrl}get_ticket");

    try {
      final res = await http.get(url);
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);

        //print(data);

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
        //print(data);
      } else {
        //
      }
    } catch (e) {
      //print(e.toString());
    }
  }

  //update ticket
  static updateTicket(id, body) async {
    var url = Uri.parse("${baseUrl}update_ticket/$id");

    final res = await http.post(url, body: body);
    if (res.statusCode == 200) {
      //print(jsonDecode(res.body));
    } else {
      //print("failed to update ticket");
    }
  }

  //delete ticket
  static deleteTicket(id) async {
    var url = Uri.parse("${baseUrl}delete_ticket/$id");

    final res = await http.post(url);

    if (res.statusCode == 204) {
      if (res.body.isNotEmpty) {
        json.decode(res.body);
      }
    } else {
      //print("Fallo el borrado de ticket");
    }
  }
}
