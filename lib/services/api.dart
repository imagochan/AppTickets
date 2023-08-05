import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:node_tutorials/model/product_model.dart';
import 'package:node_tutorials/model/ticket_model.dart';

class Api {
  //static const baseUrl = "http://192.168.0.254/api/";
  static const baseUrl = "http://127.0.0.1:2000/api/";

  static addproduct(Map pdata) async {
    print(pdata);
    var url = Uri.parse("${baseUrl}add_product");

    try {
      final res = await http.post(url, body: pdata);

      if (res.statusCode == 200) {
        var data = jsonDecode(res.body.toString());
        print(data);
      } else {
        print("failed to get response");
      }
    } catch (e) {
      debugPrint(e.toString()); //foundation.dart
    }
  }

  static addTicket(Map tdata) async {
    print(tdata);
    var url = Uri.parse("${baseUrl}add_ticket");

    try {
      final res = await http.post(url, body: tdata);

      if (res.statusCode == 200) {
        var data = jsonDecode(res.body.toString());
        print(data);
      } else {
        print("failed to get response");
      }
    } catch (e) {
      debugPrint(e.toString()); //foundation.dart
    }
  }

  static getProduct() async {
    List<Product> products = [];

    var url = Uri.parse("${baseUrl}get_product");

    try {
      final res = await http.get(url);
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);

        data['products'].forEach(
          (value) => {
            products.add(Product(value['pname'], value['pprice'],
                value['pdesc'], value['id'].toString())),
          },
        );
        return products;
        //print(data);
      } else {
        //
      }
    } catch (e) {
      print(e.toString());
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

        data['tickets'].forEach(
          (value) => {
            tickets.add(Ticket(
                value['tid'].toString(),
                value['ttitulo'],
                value['tdescripcion'],
                value['tfechaVencimiento'],
                value['tfechaPublicacion'],
                value['tfechaFinPublicacion'],
                value['tvalorCompra'],
                value['tcategoria'])),
          },
        );
        return tickets;
        //print(data);
      } else {
        //
      }
    } catch (e) {
      print(e.toString());
    }
  }

  //update put method

  static updateProduct(id, body) async {
    var url = Uri.parse("${baseUrl}update/$id");

    final res = await http.post(url, body: body);
    if (res.statusCode == 200) {
      print(jsonDecode(res.body));
    } else {
      print("failed to update data");
    }
  }

  //update post ticket

  static updateTicket(id, body) async {
    var url = Uri.parse("${baseUrl}update_ticket/$id");

    final res = await http.post(url, body: body);
    if (res.statusCode == 200) {
      print(jsonDecode(res.body));
    } else {
      print("failed to update ticket");
    }
  }

  // delete method

  static deleteProduct(id) async {
    var url = Uri.parse("${baseUrl}delete/$id");

    final res = await http.post(url);

    if (res.statusCode == 204) {
      if (res.body.isNotEmpty) {
        json.decode(res.body);
      }
    } else {
      print("failed to delete");
    }
  }
}
