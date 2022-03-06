class Directory {
  final int? id;
  final String? name;
  final String? icon;
  final List<Directory>? children;

  const Directory({this.id, this.name, this.icon, this.children});

  factory Directory.fromMap(Map<String, dynamic> map) {
    final children = map['children'] as List<dynamic>;
    return Directory(
        id: map['id'],
        name: map['name'],
        icon: map['icon'],
        children: children.map((e) => Directory.fromMap(e)).toList());
  }
}
