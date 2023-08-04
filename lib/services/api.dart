import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Api {
  //static const baseUrl = "http://192.168.0.254/api/";
  static const baseUrl = "http://localhost:4185/api/";

  static addproduct(Map pdata) async {
    print(pdata);
    var url = Uri.parse(baseUrl + "add_product");

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

  static getProduct() async {
    var url = Uri.parse("${baseUrl}get_product");
    try {
      final res = await http.get(url);
      if (res.statusCode == 200) {
        //
      } else {
        //
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
