import 'dart:core';
import 'dart:convert';
import 'package:http/http.dart' as http;

const url = 'https://youlead.id/wp-json/barav/v1/posts?paged=1';
const url2 = 'https://youlead.id/wp-json/barav/v1/posts?paged=2';

class News {
  Future fetchData() async {
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }

  Future moreData() async {
    http.Response response = await http.get(url2);

    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }
}
