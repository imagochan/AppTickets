class Ticket {
  final String? id;
  final String? titulo;
  final String? descripcion;
  final String? fechaVencimiento; //format to datetime before using
  final String? fechaPublicacion;
  final String? fechaFinPublicacion;
  var valorCompra;
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
