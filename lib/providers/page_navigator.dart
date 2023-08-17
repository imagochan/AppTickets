import 'package:flutter/material.dart';

void cambiarPantalla(Widget destinationPage, BuildContext context){
    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => destinationPage));
  }