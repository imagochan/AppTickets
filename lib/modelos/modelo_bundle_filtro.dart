class BundleFiltros {
  num? valorCompraStart;
  num? valorCompraEnd;
  DateTime? fechaCreacionStart;
  DateTime? fechaCreacionEnd;
  DateTime? fechaPublicacionStart;
  DateTime? fechaPublicacionEnd;
  String? categoria;
  String? titulo;

  BundleFiltros({
    required this.valorCompraStart,
    required this.valorCompraEnd,
    required this.fechaCreacionStart,
    required this.fechaCreacionEnd,
    required this.fechaPublicacionStart,
    required this.fechaPublicacionEnd,
    required this.categoria,
    required this.titulo,
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
          titulo: parametro["titulo"]);

  List<BundleFiltros> fromJsonToList(List<dynamic> list) =>
      List<BundleFiltros>.from(list.map((x) => BundleFiltros.fromJson(x)));
}
