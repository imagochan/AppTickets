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
      body: FutureBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Text("hubo un error");
          }
          if (snapshot.hasData) {
            return Column(
              children: [
                Placeholder()
              ],
            );
          }
          return const Text("No hay conexión con el servidor");
        } ),
    );
  }
}