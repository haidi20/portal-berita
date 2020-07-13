import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cache_image/cache_image.dart';

class PostScreen extends StatelessWidget {
  PostScreen({
    @required this.time,
    @required this.title,
    @required this.content,
    @required this.url,
  }) {
    getImage();
  }

  String sourceImage;

  final String url;
  final String title, content, time;
  final String words = "Lorem ipsum dolor sit amet, conse...";

  Future getImage() async {
    if (url != '') {
      http.Response response = await http.get(url);

      if (response.statusCode == 200) {
        String dataDecode = response.body;
        sourceImage = jsonDecode(dataDecode)['guid']['rendered'];

        print(sourceImage);
      } else {
        print(response.statusCode);
      }
    } else {
      print('tidak ada');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 80,
      color: Color(0xFFF6F9FD),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Center(
              child: Container(
                margin: EdgeInsets.all(16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(7),
                  child: _showImage(sourceImage),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 7,
            child: Container(
              margin: EdgeInsets.only(top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "$title",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Text(
                    "$time",
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                  Text(
                    "$content",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Color(0xFF94979B),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

@override
Widget _showImage(sourceImage) {
  if (sourceImage != null) {
    return FadeInImage(
      fit: BoxFit.cover,
      placeholder: AssetImage('images/placeholder.png'),
      image:
          CacheImage('https://youlead.id/wp-content/uploads/2019/10/KPK.jpg'),
    );
  } else {
    return FadeInImage(
      fit: BoxFit.cover,
      placeholder: AssetImage('images/placeholder.png'),
      image: AssetImage('images/notfound.jpg'),
    );
  }
}
