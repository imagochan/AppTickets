import 'package:flutter/material.dart';

//import 'modelo_categoria.dart';

class BundleFiltros {
  num valorCompraStart;
  num valorCompraEnd;
  DateTime fechaCreacionStart;
  DateTime fechaCreacionEnd;
  DateTime fechaPublicacionStart;
  DateTime fechaPublicacionEnd;
  String categoriaID;
  String titulo;
  bool esFechaCreacionOPublicidad;

  BundleFiltros({
    required this.valorCompraStart,
    required this.valorCompraEnd,
    required this.fechaCreacionStart,
    required this.fechaCreacionEnd,
    required this.fechaPublicacionStart,
    required this.fechaPublicacionEnd,
    required this.categoriaID,
    required this.titulo,
    required this.esFechaCreacionOPublicidad,
  });

  factory BundleFiltros.fromJson(Map<String, dynamic> parametro) =>
      BundleFiltros(
          valorCompraStart: parametro["valorCompraStart"],
          valorCompraEnd: parametro["valorCompraEnd"],
          fechaCreacionStart: parametro["fechaCreacionStart"],
          fechaCreacionEnd: parametro["fechaCreacionEnd"],
          fechaPublicacionStart: parametro["fechaPublicacionStart"],
          fechaPublicacionEnd: parametro["fechaPublicacionEnd"],
          categoriaID: parametro["categoria"],
          titulo: parametro["titulo"],
          esFechaCreacionOPublicidad: parametro["esFechaCreacionOPublicidad"]);

  List<BundleFiltros> fromJsonToList(List<dynamic> list) =>
      List<BundleFiltros>.from(list.map((x) => BundleFiltros.fromJson(x)));

  //caso bundle empty recomendable en vez de nulos
  factory BundleFiltros.empty() => BundleFiltros(
      valorCompraStart: 0,
      valorCompraEnd: 0,
      fechaCreacionStart: DateUtils.addMonthsToMonthDate(DateTime.now(), -2),
      fechaCreacionEnd: DateUtils.addMonthsToMonthDate(DateTime.now(), 2),
      fechaPublicacionStart: DateUtils.addMonthsToMonthDate(DateTime.now(), -2),
      fechaPublicacionEnd: DateUtils.addMonthsToMonthDate(DateTime.now(), 2),
      categoriaID: '',
      titulo: '',
      esFechaCreacionOPublicidad: true);
}
