import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      // height: 80,
      // width: double.infinity,
      margin: EdgeInsets.only(bottom: 10.0, right: 10.0),
      color: Color(0xFFF6F9FD),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Center(
              child: Container(
                width: width * 0.20,
                height: height * 0.10,
                // margin: EdgeInsets.all(14),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(7),
                  child: _showImage(url, context),
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
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Text(time,
                      style: TextStyle(
                        color: Colors.blue,
                      )),
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

  _showImage(url, context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return CachedNetworkImage(
      imageUrl: '$url',
      fit: BoxFit.cover,
      placeholder: (BuildContext context, String url) => Container(
        width: width * 0.30,
        height: height * 0.20,
        child: Image(
          fit: BoxFit.cover,
          image: AssetImage('images/notfound.jpg'),
        ),
      ),
    );
  }
}
