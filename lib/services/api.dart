import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Api {
  static const baseUrl = "";

  static addproduct(Map pdata) async {
    final res = await http.post(Uri.parse("uri"), body: pdata);

    try {
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
