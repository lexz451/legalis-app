import 'dart:io';

class ConnectivityService {
  Future<bool> isConnected() async {
    var isConnected = false;
    try {
      final res = await InternetAddress.lookup("www.google.com");
      if (res.isNotEmpty) {
        isConnected = true;
      }
    } on SocketException catch (e) {
      print("Connectivity error: " + e.message);
      isConnected = false;
    }
    return isConnected;
  }
}
