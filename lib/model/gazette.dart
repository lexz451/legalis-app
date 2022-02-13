import 'package:legalis/model/normative.dart';

class Gazette {
  String id;
  String name;
  String file;
  String type;
  String date;
  int number;
  // ignore: non_constant_identifier_names
  int download_count;
  List<Normative> normatives;

  Gazette(
      {required this.id,
      required this.name,
      required this.file,
      required this.type,
      required this.date,
      required this.number,
      // ignore: non_constant_identifier_names
      required this.download_count,
      required this.normatives})
      : super();

  factory Gazette.fromMap(Map<String, dynamic> data) {
    var _normatives = data['normatives'] as List<Map<String, dynamic>>;
    return Gazette(
        id: data['id'],
        name: data['name'],
        file: data['file'],
        type: data['type'],
        date: data['date'],
        number: data['number'],
        download_count: data['download_count'],
        normatives: _normatives.map((e) => Normative.fromMap(e)).toList());
  }
}
