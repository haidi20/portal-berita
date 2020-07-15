import 'dart:core';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' show Client;
import 'package:HolidayPackage/services/models/postModels.dart';

class PostApiProvider {
  Client client = Client();
  final _url = 'https://youlead.id/wp-json/barav/v1/posts?paged=1';

  Future<List<Post>> fetchPost() async {
    print("masuk");

    final response = await client.get(_url);

    if (response.statusCode == 200) {
      return compute(postFromJson, response.body);
    } else {
      throw Exception("Failed to load");
    }
  }
}
