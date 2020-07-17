import 'package:flutter/material.dart';
import 'package:cache_image/cache_image.dart';

class PostScreen extends StatelessWidget {
  PostScreen({
    @required this.url,
    @required this.time,
    @required this.title,
    @required this.content,
  });

  var url;
  final String title, content, time;

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
                margin: EdgeInsets.all(14),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(7),
                  child: _showImage(url),
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
                    time,
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

  _showImage(url) {
    if (url == false) {
      return FadeInImage(
        fit: BoxFit.cover,
        placeholder: AssetImage('images/placeholder.png'),
        image: AssetImage('images/notfound.jpg'),
      );
    } else {
      return FadeInImage(
        // fit: BoxFit.cover,
        placeholder: AssetImage('images/placeholder.png'),
        image: CacheImage('$url'),
      );
    }
  }
}
