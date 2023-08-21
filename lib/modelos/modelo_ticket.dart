//Modelo de un ticket a utilizar en la App

class Ticket {
  final String id;
  final String titulo;
  final String descripcion;
  final DateTime fechaVencimiento; //format to datetime before using
  final DateTime fechaPublicacion;
  final DateTime fechaFinPublicacion;
  final num valorCompra;
  //final String? imagenTicket;
  final String categoria;
  final DateTime fechaCreacion;

  Ticket(
      {required this.id,
      required this.titulo,
      required this.descripcion,
      required this.fechaVencimiento,
      required this.fechaPublicacion,
      required this.fechaFinPublicacion,
      required this.valorCompra,
      required this.categoria,
      required this.fechaCreacion});

  factory Ticket.fromJson(Map<String, dynamic> parametro) => Ticket(
      id: parametro["id"],
      titulo: parametro["titulo"],
      descripcion: parametro["descripcion"],
      fechaVencimiento: parametro["fechaVencimiento"],
      fechaPublicacion: parametro["fechaPublicacion"],
      fechaFinPublicacion: parametro["fechaFinPublicacion"],
      valorCompra: parametro["valorCompra"],
      categoria: parametro["categoria"],
      fechaCreacion:parametro["fechaCreacion"]
      );

  List<Ticket> fromJsonToList(List<dynamic> list) =>
      List<Ticket>.from(list.map((x) => Ticket.fromJson(x)));
}
