//modelo para una categoria

class Categoria {
  final String categoriaNombre;
  final String id;

  Categoria(
    {
      required this.categoriaNombre,
      required this.id
    }
  );

  factory Categoria.fromJson(Map<String,dynamic> parametro) => Categoria(
    categoriaNombre: parametro['categoriaNombre'], 
    id: parametro['id']
  );

  List<Categoria> fromJsonToList(List<dynamic> list) =>
  List<Categoria>.from(list.map((e) => Categoria.fromJson(e)));

  factory Categoria.empty() => Categoria(
    categoriaNombre: '',
    id: ''
  );

}