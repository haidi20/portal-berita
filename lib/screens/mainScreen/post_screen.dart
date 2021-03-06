import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PostScreen extends StatelessWidget {
  PostScreen({
    @required this.time,
    @required this.image,
    @required this.title,
    @required this.content,
  });

  var image;
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
                  child: _showImage(image, context),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 7,
            child: Container(
              // color: Colors.red,
              padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    overflow: TextOverflow.ellipsis,
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
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Text(
                    content,
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

  _showImage(image, context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return CachedNetworkImage(
      imageUrl: image,
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
