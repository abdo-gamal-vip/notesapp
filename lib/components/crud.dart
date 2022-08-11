import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:notesapp/constant/linkapi.dart';

import '../main.dart';

class Crud {
  getRequset(String url, Map<String, dynamic> map) async {
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

  deleten(nn_id, context) async {
    var response = await postRequset(deletelink, {
      "n_id": nn_id,
    });
    if (response["status"] == "success") {
      return Navigator.of(context).pushReplacementNamed("home");
    }
    print("$nn_id");
  }
}
