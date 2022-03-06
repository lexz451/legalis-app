class Topic {
  int count;
  String name;

  Topic(this.name, this.count);

  factory Topic.fromMap(Map<String, dynamic> data) {
    return Topic(data['name'], data['count']);
  }
}
