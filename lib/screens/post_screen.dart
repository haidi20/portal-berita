import 'package:flutter/material.dart';
import 'package:cache_image/cache_image.dart';

class PostScreen extends StatelessWidget {
  PostScreen({@required this.title});

  final String title;
  final String words = "Lorem ipsum dolor sit amet, conse...";

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
                  child: FadeInImage(
                    fit: BoxFit.cover,
                    placeholder: AssetImage('images/placeholder.png'),
                    image: CacheImage(
                        'https://youlead.id/wp-content/uploads/2019/10/KPK.jpg'),
                  ),
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
                    "7 Days - 6 Nights",
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                  Text(
                    "$words",
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
