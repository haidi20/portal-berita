import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cache_image/cache_image.dart';
import 'package:HolidayPackage/services/news.dart';

class PostScreen extends StatelessWidget {
  PostScreen({
    @required this.url,
    @required this.time,
    @required this.title,
    @required this.content,
  }) {
    _dataController = new StreamController();
    getImage();
  }

  News news = News();
  StreamController _dataController;
  final String title, content, time, url;

  void getImage() {
    news.fetchImage(url).then((res) async {
      _dataController.add(res);

      return res;
    });
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
                  child: _showImage(_dataController),
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
Widget _showImage(_dataController) {
  return StreamBuilder(
    stream: _dataController.stream,
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      if (snapshot.hasError) {
        return Text(snapshot.error);
      }

      if (snapshot.hasData) {
        return FadeInImage(
          fit: BoxFit.cover,
          placeholder: AssetImage('images/placeholder.png'),
          image: CacheImage('${snapshot.data}'),
        );
      }

      if (!snapshot.hasData) {
        return FadeInImage(
          fit: BoxFit.cover,
          placeholder: AssetImage('images/placeholder.png'),
          image: AssetImage('images/notfound.jpg'),
        );
      }
    },
  );
}
