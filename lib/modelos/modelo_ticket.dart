//Modelo de un ticket a utilizar en la App

class Ticket {
  final String? id;
  final String? titulo;
  final String? descripcion;
  final DateTime? fechaVencimiento; //format to datetime before using
  final DateTime? fechaPublicacion;
  final DateTime? fechaFinPublicacion;
  final num? valorCompra;
  //final String? imagenTicket;
  final String? categoria;

  Ticket(
      this.id,
      this.titulo,
      this.descripcion,
      this.fechaVencimiento,
      this.fechaPublicacion,
      this.fechaFinPublicacion,
      this.valorCompra,
      this.categoria);
}
