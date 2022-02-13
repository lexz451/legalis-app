import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:legalis/model/normative.dart';
import 'package:legalis/model/paged.dart';
import 'package:legalis/services/api_service.dart';

class NormativeRepository {
  final ApiService apiService = ApiService();

  Future<Paged<Normative>> fetchByDirectoryId(int directoryId) async {
    var _res = await apiService
        .get("normativas", params: {'directory': directoryId.toString()});
    return Paged<Normative>.fromMap(_res, Normative.fromMap);
  }
}
