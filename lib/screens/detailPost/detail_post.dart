import 'package:html/parser.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:cached_network_image/cached_network_image.dart';

class DetailPost extends StatelessWidget {
  DetailPost({this.id, this.title, this.content, this.image});

  final int id;
  final String title, content, image;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: NotificationListener(
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                pinned: true,
                expandedHeight: 300.0,
                title: Text(""),
                flexibleSpace: FlexibleSpaceBar(
                  titlePadding: EdgeInsets.only(left: 40.0, bottom: 16.0),
                  title: Text(
                    title,
                    style: TextStyle(
                      shadows: <Shadow>[
                        Shadow(
                          offset: Offset(1.0, 1.0),
                          blurRadius: 3.0,
                          color: Colors.black,
                        ),
                        Shadow(
                          offset: Offset(1.0, 1.0),
                          blurRadius: 8.0,
                          color: Colors.black,
                        ),
                      ],
                      fontSize: 15.0,
                    ),
                  ),
                  background: _getImage(),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.all(10),
                        child: Html(
                          data: """$content""",
                          defaultTextStyle: TextStyle(
                            fontSize: 17.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _getImage() {
    return CachedNetworkImage(
      imageUrl: image,
      fit: BoxFit.cover,
      placeholder: (BuildContext context, String url) => Container(
        child: Image(
          fit: BoxFit.cover,
          image: AssetImage('images/notfound.jpg'),
        ),
      ),
    );
  }
}
