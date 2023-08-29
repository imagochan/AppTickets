//Modelo de un ticket a utilizar en la App

//import 'package:apptickets/modelos/modelo_categoria.dart';
import 'package:flutter/material.dart';

class Ticket {
  final String id;
  final String titulo;
  final String descripcion;
  final DateTime fechaVencimiento; //format to datetime before using
  final DateTime fechaPublicacion;
  final num valorCompra;
  //final String? imagenTicket;
  final String categoriaID;
  final DateTime fechaCreacion;

  Ticket(
      {required this.id,
      required this.titulo,
      required this.descripcion,
      required this.fechaVencimiento,
      required this.fechaPublicacion,
      required this.valorCompra,
      required this.categoriaID,
      required this.fechaCreacion});

  factory Ticket.fromJson(Map<String, dynamic> parametro) => Ticket(
      id: parametro["id"],
      titulo: parametro["titulo"],
      descripcion: parametro["descripcion"],
      fechaVencimiento: DateTime.parse(parametro["fechaVencimiento"]),
      fechaPublicacion: DateTime.parse(parametro["fechaPublicacion"]),
      valorCompra: parametro["valorCompra"],
      //categoria: Categoria.fromJson(parametro['categoria']), //sintaxis valida
      categoriaID: parametro['categoriaID'], //sintaxis valida
      fechaCreacion: DateTime.parse(parametro["fechaCreacion"]));

  static List<Ticket> fromJsonToList(List<dynamic> list) => //debe ser estatico
      List<Ticket>.from(list.map((x) => Ticket.fromJson(x)));

  factory Ticket.empty() => Ticket(
        id: '0',
        titulo: '',
        descripcion: '',
        fechaVencimiento: DateUtils.addDaysToDate(DateTime.now(), 14),
        fechaPublicacion: DateUtils.addDaysToDate(DateTime.now(), 7),
        categoriaID: '',
        valorCompra: 0,
        fechaCreacion: DateTime.now(),
      );
}
