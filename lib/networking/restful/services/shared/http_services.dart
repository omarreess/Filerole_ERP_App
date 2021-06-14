import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class HttpServices {
    String ? token;
  HttpServices({this.token});


    Map<String, String> getHeader() {
    return {
      "Content-Type": "application/json",
      'Authorization': 'Bearer ${token??''}',
    };
  }

  ///POST Method
    Future<http.Response?> post({
    required String url,
    required Map<String, dynamic> body,
  }) async {
    try {
      final response =
          await http.post(Uri.parse(url), headers: getHeader(), body: json.encode(body));
      return response;
    } catch (error) {
      return null;
    }
  }

  ///GET Method
    Future<http.Response?> get({
    required String url,
    required Map<String, dynamic> parameters,
  }) async {
    try {
      final response = await http.get(Uri.parse(url), headers: getHeader());

      return response;
    } catch (error) {
      return null;
    }
  }
}
