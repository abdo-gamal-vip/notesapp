import 'package:http/http.dart' as http;
import 'dart:convert';

class Crud {
  getRequset(String url) async {
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var responsebody = jsonDecode(response.body);
        return responsebody;
      } else {
        print("error ${response.statusCode}");
      }
    } catch (e) {
      print("catch error $e");
    }
  }

  postRequset(String url, Map data) async {
    try {
      var response = await http.post(Uri.parse(url), body: data);
      if (response.statusCode == 200) {
        var responsebody = jsonDecode(response.body);
        return responsebody;
      } else {
        print("errorrrrr ${response.statusCode}");
      }
    } catch (e) {
      print("catch error $e");
    }
  }
}
