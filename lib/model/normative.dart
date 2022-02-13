class Normative {
  String id;
  String name;
  String? text;
  String? gazette;
  List<String> keywords = [];
  List<String> tags = [];
  String? organism;
  String? state;
  String? summary;
  String? normtype;
  int? year;
  int? number;

  Normative({
    required this.id,
    required this.name,
    this.text,
    this.summary,
    this.year,
    this.normtype,
    this.number,
    this.tags = const [],
    this.keywords = const [],
    this.gazette,
    this.organism,
    this.state,
  }) : super();

  factory Normative.fromMap(Map<String, dynamic> data) {
    var _keywords = data['keywords'] as List<dynamic>;
    var _tags = data['tags'] as List<dynamic>;
    return Normative(
        id: data['id'],
        name: data['name'],
        text: data['text'],
        gazette: data['gazette'],
        keywords: List<String>.from(_keywords.map((e) => e.toString())),
        tags: List<String>.from(_tags.map((e) => e.toString())),
        organism: data['organism'],
        state: data['state'],
        summary: data['summary'],
        year: data['year'],
        normtype: data['normtype'],
        number: data['number']);
  }

  static Normative fromJsonModel(Map<String, dynamic> json) =>
      Normative.fromMap(json);
}
