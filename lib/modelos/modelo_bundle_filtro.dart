import 'package:flutter/material.dart';

class BundleFiltros {
  num valorCompraStart;
  num valorCompraEnd;
  DateTime fechaCreacionStart;
  DateTime fechaCreacionEnd;
  DateTime fechaPublicacionStart;
  DateTime fechaPublicacionEnd;
  String categoria;
  String titulo;
  bool esFechaCreacionOPublicidad;

  BundleFiltros({
    required this.valorCompraStart,
    required this.valorCompraEnd,
    required this.fechaCreacionStart,
    required this.fechaCreacionEnd,
    required this.fechaPublicacionStart,
    required this.fechaPublicacionEnd,
    required this.categoria,
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
          categoria: parametro["categoria"],
          titulo: parametro["titulo"],
          esFechaCreacionOPublicidad: parametro["esFechaCreacionOPublicidad"]
          );

  List<BundleFiltros> fromJsonToList(List<dynamic> list) =>
      List<BundleFiltros>.from(list.map((x) => BundleFiltros.fromJson(x)));

  //caso bundle empty recomendable en vez de nulos
  factory BundleFiltros.empty() => BundleFiltros(
    valorCompraStart:0.0,
    valorCompraEnd:0.0,
    fechaCreacionStart:DateUtils.addMonthsToMonthDate(DateTime.now(), -1),
    fechaCreacionEnd:DateUtils.addMonthsToMonthDate(DateTime.now(), 1),
    fechaPublicacionStart:DateUtils.addMonthsToMonthDate(DateTime.now(), -1),
    fechaPublicacionEnd:DateUtils.addMonthsToMonthDate(DateTime.now(), 1),
    categoria:'ALL',
    titulo:'',
    esFechaCreacionOPublicidad: true
  );
}
