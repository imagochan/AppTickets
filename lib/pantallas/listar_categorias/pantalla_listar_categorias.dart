import 'package:flutter/material.dart';

class PantallaListarCategorias extends StatefulWidget {
  const PantallaListarCategorias({super.key});

  @override
  State<PantallaListarCategorias> createState() => _PantallaListarCategoriasState();
}

class _PantallaListarCategoriasState extends State<PantallaListarCategorias> {

  void updateList(){
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Placeholder(),
    );
  }
}