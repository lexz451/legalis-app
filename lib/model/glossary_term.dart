class GlossaryTerm {
  int id;
  String term;
  String? description;

  GlossaryTerm({required this.id, required this.term, this.description});

  factory GlossaryTerm.fromMap(Map<String, dynamic> data) {
    return GlossaryTerm(
        id: data['id'],
        term: data['termino'],
        description: data['description']);
  }
}
