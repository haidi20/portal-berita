import 'package:flutter/material.dart';
import 'package:HolidayPackage/services/data/api.dart';
import 'package:HolidayPackage/services/model/Post.dart';
import 'package:HolidayPackage/screens/detailPost/detail_post.dart';
import 'package:HolidayPackage/screens/mainScreen/post_screen.dart';

class ShowListPost extends StatefulWidget {
  const ShowListPost({
    this.post,
    this.search,
    Key key,
  }) : super(key: key);

  final String search;
  final List<Post> post;

  @override
  _ShowListPostState createState() => _ShowListPostState();
}

class _ShowListPostState extends State<ShowListPost> {
  String search;
  List<Post> post;
  int currentPage = 1;
  final client = restClient();
  ScrollController scrollController = new ScrollController();

  bool onNotificati(ScrollNotification notification) {
    if (notification is ScrollUpdateNotification) {
      if (scrollController.position.maxScrollExtent > scrollController.offset &&
          scrollController.position.maxScrollExtent - scrollController.offset <=
              50) {
        setState(() {
          currentPage += 1;
        });
        client.getPostList(currentPage, '').then((val) {
          setState(() {
            post.addAll(val);
          });
        });
      }
    }
    return true;
  }

  void gotoDetailPost(id) {
    // print(id);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailPost(
          id: id,
        ),
      ),
    );
  }

  @override
  void initState() {
    post = widget.post;
    search = widget.search;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      onNotification: onNotificati,
      child: ListView.builder(
        itemCount: post.length,
        controller: scrollController,
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext c, int i) {
          return FlatButton(
            onPressed: () => gotoDetailPost(post[i].id),
            child: PostScreen(
              url: post[i].image,
              time: post[i].date,
              title: post[i].title,
              content: post[i].content,
            ),
          );
        },
      ),
    );
  }
}
