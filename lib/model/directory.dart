class Directory {
  Directory({required this.id, required this.name, this.icon, this.children})
      : super();

  final int id;
  final String name;
  final String? icon;
  final List<Directory>? children;

  factory Directory.fromMap(Map<String, dynamic> data) {
    var _children = data['children'] as List<dynamic>;
    return Directory(
        id: data['id'],
        name: data['name'],
        icon: data['icon'],
        children: _children.map((e) => Directory.fromMap(e)).toList());
  }
}
