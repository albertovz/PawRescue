class Mascota {
  // final String titulo;
  final String imagen;
  final String nombre;
  final String tipoAnimal;
  final String raza;
  final String color;
  final String genero;
  final int edad;
  // final String descripcion;
  // final String ubicacion;
  // final String fechaPublicacion;
  // final String estadoAnuncio;

  Mascota({
    // required this.titulo,
    required this.imagen,
    required this.nombre,
    required this.tipoAnimal,
    required this.raza,
    required this.color,
    required this.genero,
    required this.edad,
    // required this.descripcion,
    // required this.ubicacion,
    // required this.fechaPublicacion,
    // required this.estadoAnuncio,
  });

  factory Mascota.fromJson(Map<String, dynamic> json) {
    return Mascota(
      // titulo: json['title'],
      imagen: json['imgPet'],
      nombre: json['name'],
      tipoAnimal: json['type'],
      raza: json['race'],
      color: json['color'],
      genero: json['gender'],
      edad: json['age'],
      // descripcion: json['descriptionAd'],
      // ubicacion: json['ubicacion'],
      // fechaPublicacion: json['fechaPublicacion'],
      // estadoAnuncio: json['estadoAnuncio'],
    );
  }
}