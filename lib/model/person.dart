class Person {
  int id;
  String name;
  String? description;
  String? imagen;

  Person(
      {required this.id,
      required this.name,
      required this.description,
      required this.imagen});

  factory Person.fromMap(Map<String, dynamic> data) {
    return Person(
        id: data['id'],
        name: data['nombre'],
        description: data['descripcion'],
        imagen: data['imagen']);
  }
}
