import 'package:http/http.dart' as http;
import 'dart:convert';

const url = 'https://youlead.id/wp-json/barav/v1/posts?paged=1';

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

  Future fetchImage(url) async {
    if (url != null) {
      http.Response response = await http.get(url);

      if (response.statusCode == 200) {
        String dataDecode = response.body;

        return jsonDecode(dataDecode)['guid']['rendered'];
      } else {
        print(response.statusCode);
      }
    } else {
      return null;
    }
  }
}
