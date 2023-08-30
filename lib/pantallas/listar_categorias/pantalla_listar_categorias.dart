import 'package:apptickets/pantallas/crear_o_actualizar_categorias/pantalla_crear_o_actualizar_categorias.dart';
import 'package:apptickets/servicios/api_categorias.dart';
import 'package:flutter/material.dart';

import '../../modelos/modelo_categoria.dart';

class PantallaListarCategorias extends StatefulWidget {
  const PantallaListarCategorias({super.key});

  @override
  State<PantallaListarCategorias> createState() =>
      _PantallaListarCategoriasState();
}

class _PantallaListarCategoriasState extends State<PantallaListarCategorias> {
  void updateList() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
          future: ApiCategorias.getCategorias(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return const Text("hubo un error");
            }
            if (snapshot.hasData) {
              List<Categoria> listaCategorias = snapshot.data;
              return ListView.builder(
                  itemCount: listaCategorias.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.indigo)),
                      child: Column(
                        children: [
                          Text(
                              "Categoria: ${listaCategorias[index].categoriaNombre}"),
                          IconButton(
                              onPressed: () async {
                                await ApiCategorias.borrarCategoria(
                                    listaCategorias[index].id);
                                setState(() {});
                              },
                              icon: const Icon(Icons.delete)),
                          IconButton(
                              onPressed: () async {
                                await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            PantallaCrearOActualizarCategorias(
                                              unaCategoria:
                                                  listaCategorias[index],
                                              esCrearOActualizar: false,
                                            )));
                                if (!mounted) return;
                                setState(() {});
                              },
                              icon: const Icon(Icons.edit))
                        ],
                      ),
                    );
                  });
            }
            return const Text("No hay conexión con el servidor");
          }),
    );
  }
}
