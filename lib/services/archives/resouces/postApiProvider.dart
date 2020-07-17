import 'dart:core';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' show Client;
import 'package:HolidayPackage/services/models/postModels.dart';

class PostApiProvider {
  Client client = Client();

  Future<List<Post>> fetchPost(url) async {
    final response = await client.get(url);

    if (response.statusCode == 200) {
      return compute(postFromJson, response.body);
    } else {
      throw Exception("Failed to load");
    }
  }
}
