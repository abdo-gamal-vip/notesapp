import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:notesapp/constant/linkapi.dart';
import '../main.dart';
import 'package:path/path.dart';

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

  deleten(
    nn_id,
    context,
  ) async {
    var response =
        await postRequset(deletelink, {"n_id": nn_id, "imagename": "imagename"});
    if (response["status"] == "success") {
      return await Navigator.of(context).pushReplacementNamed("home");
    }
    print("$nn_id");
  }

  bookmark(
    nn_id,
    context,
    String bookmark,
  ) async {
    var response = await postRequset(addbooklink, {
      "n_id": nn_id,
      "n_bookmark": bookmark,
    });
    if (response["status"] == "success") {
      return await Navigator.of(context).pushReplacementNamed("home");
    }
    print("$nn_id");
  }
}

postRequsetFile(String url, Map data, File file) async {
  try {
    var requset = await http.MultipartRequest("POST", Uri.parse(url));
    var lenght = await file.length();
    var stream = http.ByteStream(file.openRead());
    var mulitPartFile = await http.MultipartFile("file", stream, lenght,
        filename: basename(file.path));
    requset.files.add(mulitPartFile);
    data.forEach((key, value) {
      requset.fields[key] = value;
    });
    var myrequest = await requset.send();
    var response = await http.Response.fromStream(myrequest);
    if (myrequest.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print("error ${myrequest.statusCode}");
    }
  } catch (e) {
    print("catch error $e");
  }
}
