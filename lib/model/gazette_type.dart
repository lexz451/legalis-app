class GazetteType {
  String type;
  int count;

  GazetteType(this.type, this.count);

  factory GazetteType.fromMap(Map<String, dynamic> data) {
    return GazetteType(data['type'], data['count']);
  }
}
