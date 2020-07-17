import 'dart:core';
import 'dart:async';
import 'package:http/http.dart' show Client;
import 'package:HolidayPackage/services/model/Post.dart';

class PostRepository {
  Client client = Client();

  Future<List<Post>> fetchData(int perpage) async {
    var url = 'https://youlead.id/wp-json/barav/v1/posts?per_page=$perpage';

    final response = await client.get(url);
    if (response.statusCode == 200) {
      return postFromJson(response.body);
    } else {
      throw Exception('Faild to load');
    }
  }
}
