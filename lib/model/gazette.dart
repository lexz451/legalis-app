import 'package:legalis/model/normative.dart';

class Gazette {
  String id;
  String? name;
  String? file;
  String? type;
  String? date;
  num? number;
  num? downloadCount;
  List<Normative>? normatives;

  Gazette(
      {required this.id,
      this.name,
      this.file,
      this.type,
      this.date,
      this.number,
      this.downloadCount,
      this.normatives});

  factory Gazette.fromMap(Map<String, dynamic> data) {
    final _normatives = data['normatives'] ?? [];
    return Gazette(
        id: data['id'],
        name: data['name'],
        file: data['file'],
        type: data['type'],
        date: data['date'],
        number: data['number'],
        downloadCount: data['download_count'],
        normatives:
            List<Normative>.from(_normatives.map((e) => Normative.fromMap(e))));
  }
}
