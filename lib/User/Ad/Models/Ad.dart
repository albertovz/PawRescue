class Ad {
  // final String titulo;
  final String title;
  final String descriptionAd;
  final String ubication;
  final String datePublication;
  final bool statusAd;
  // final String genero;
  // final int edad;
  // final String descripcion;
  // final String ubicacion;
  // final String fechaPublicacion;
  // final String estadoAnuncio;

  Ad({
    // required this.titulo,
    required this.title,
    required this.descriptionAd,
    required this.ubication,
    required this.datePublication,
    required this.statusAd,
    // required this.genero,
    // required this.edad,
    // required this.descripcion,
    // required this.ubicacion,
    // required this.fechaPublicacion,
    // required this.estadoAnuncio,
  });

  factory Ad.fromJson(Map<String, dynamic> json) {
    return Ad(
      // titulo: json['title'],
      title: json['title'],
      descriptionAd: json['descriptionAd'],
      ubication: json['ubication'],
      datePublication: json['datePublication'],
      statusAd: json['statusAd'],
      // genero: json['gender'],
      // edad: json['age'],
      // descripcion: json['descriptionAd'],
      // ubicacion: json['ubicacion'],
      // fechaPublicacion: json['fechaPublicacion'],
      // estadoAnuncio: json['estadoAnuncio'],
    );
  }
}