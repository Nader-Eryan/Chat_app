import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class Api {
  Future<dynamic> get({required String uri, @required String? token}) async {
    http.Response response = await http.get(Uri.parse(uri));
    if (token != null) {
      headers.addAll({'Authorization': 'Bearer $token'});
    }
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(
          'There is a problem with the request! ${response.statusCode}');
    }
  }

  Map<String, String> headers = {};
  Future<dynamic> post(
      {required String url,
      @required dynamic body,
      @required String? token}) async {
    if (token != null) {
      headers.addAll({'Authorization': 'Bearer $token'});
    }
    http.Response response =
        await http.post(Uri.parse(url), body: body, headers: headers);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(
          'There is a problem with the statusCode ${response.statusCode} with body ${jsonDecode(response.body)}');
    }
  }

  Future<dynamic> put(
      {required String url,
      @required dynamic body,
      @required String? token}) async {
    headers.addAll({'Content-Type': 'application/json; charset=utf-8'});
    if (token != null) {
      headers.addAll({'Authorization': 'Bearer $token'});
    }
    print('url= $url  body= $body  token= $token');
    http.Response response = await http.put(Uri.parse(url),
        body: json.encode(body), headers: headers);

    if (response.statusCode == 200) {
      Map<String, dynamic> data = await jsonDecode(response.body);
      print(data);
      return data;
    } else {
      throw Exception(
          'There is a problem with the statusCode ${response.statusCode} with body ${jsonDecode(response.body)}');
    }
  }
}
