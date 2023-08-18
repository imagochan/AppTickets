enum CategoriaPelicula { accion, aventura, comedia, drama, fantasia,
 historico,horror,musical,crimen,ciencia,terror,oeste }

extension CategoriaExtension on CategoriaPelicula {
  String get miextension {
    switch (this) {
      case CategoriaPelicula.accion:
        return "Acción";
      case CategoriaPelicula.aventura:
        return "Aventura";
      case CategoriaPelicula.comedia:
        return "Comedia";
      case CategoriaPelicula.drama:
        return "Drama";
      case CategoriaPelicula.fantasia:
        return "Fantasia";
      case CategoriaPelicula.historico:
        return "Histórico";
      case CategoriaPelicula.horror:
        return "Horror";
      case CategoriaPelicula.musical:
        return "Musical";
      case CategoriaPelicula.crimen:
        return "Crimen";
      case CategoriaPelicula.ciencia:
        return "Ciencia";
      case CategoriaPelicula.terror:
        return "Terror";
      case CategoriaPelicula.oeste:
        return "Oeste";
    }
  }
}