import 'package:http/http.dart' as http;
import 'dart:convert';

const url = 'https://youlead.id/wp-json/wp/v2/posts/?per_page=10';

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
}
