import 'package:http/http.dart' as http;
import 'dart:convert';

class Crud {
  getRequest(String url) async {
    try {
      var responce = await http.get(Uri.parse(url));
      if (responce.statusCode == 200) {
        var responcebody = jsonDecode(responce.body);
        return responcebody;
      } else {
        print("error ${responce.statusCode}");
      }
    } catch (e) {
      print("error catch $e");
    }
  }

  postRequest(String url, Map data) async {
    try {
      var responce = await http.post(Uri.parse(url), body: data);
      if (responce.statusCode == 200) {
        var responcebody = jsonDecode(responce.body);
        return responcebody;
      } else {
        print("error ${responce.statusCode}");
      }
    } catch (e) {
      print("error catch $e");
    }
  }
}
