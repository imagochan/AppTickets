import 'package:flutter/material.dart';

enum FechaFiltro { fechaCreacion, fechaPublicacion }

class RadioExample extends StatefulWidget {
  const RadioExample({super.key});

  @override
  State<RadioExample> createState() => _RadioExampleState();
}

class _RadioExampleState extends State<RadioExample> {
  FechaFiltro? _fecha = FechaFiltro.fechaCreacion;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: const Text('Filtrar por fecha de creación'),
          leading: Radio<FechaFiltro>(
            value: FechaFiltro.fechaCreacion,
            groupValue: _fecha,
            onChanged: (FechaFiltro? value) {
              setState(() {
                _fecha = value;
              });
            },
          ),
        ),
        ListTile(
          title: const Text('Filtrar por fecha de publicación'),
          leading: Radio<FechaFiltro>(
            value: FechaFiltro.fechaPublicacion,
            groupValue: _fecha,
            onChanged: (FechaFiltro? value) {
              setState(() {
                _fecha = value;
              });
            },
          ),
        ),
      ],
    );
  }
}