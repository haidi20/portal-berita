import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:cached_network_image/cached_network_image.dart';

class DetailPost extends StatelessWidget {
  DetailPost({this.id, this.title, this.content, this.image});

  final int id;
  final String title, content, image;
  ScrollController scrollController = new ScrollController();

  bool onNotification(ScrollNotification notification) {
    if (notification is ScrollUpdateNotification) {
      if (scrollController.position.maxScrollExtent > scrollController.offset &&
          scrollController.position.maxScrollExtent - scrollController.offset <=
              50) {}
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              pinned: true,
              expandedHeight: 300.0,
              title: Text(""),
              flexibleSpace: FlexibleSpaceBar(
                background: _getImage(),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Expanded(
                    flex: 2,
                    child: Text(title),
                  ),
                  Expanded(
                    child: Html(
                      data: """$content""",
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _getImage() {
    return CachedNetworkImage(
      imageUrl: image,
      fit: BoxFit.cover,
      placeholder: (BuildContext context, String url) => Container(
        // width: width * 0.30,
        // height: height * 0.20,
        child: Image(
          fit: BoxFit.cover,
          image: AssetImage('images/notfound.jpg'),
        ),
      ),
    );
  }
}
