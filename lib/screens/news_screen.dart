import 'dart:core';
import 'package:flutter/material.dart';
import 'package:HolidayPackage/services/data/api.dart';
import 'package:HolidayPackage/services/model/Post.dart';
import 'package:HolidayPackage/screens/post_screen.dart';
import 'package:HolidayPackage/screens/header_screen.dart';

// import 'package:HolidayPackage/services/blocs/counterBloc.dart';

class NewsScreen extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Portal Berita',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ContentPage(),
    );
  }
}

class ContentPage extends StatefulWidget {
  ContentPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ContentPageState createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {
  // CounterBloc _counterBloc = CounterBloc(0);
  PostRepository postRepository;

  @override
  void initState() {
    super.initState();
    postRepository = PostRepository();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // agar ketika qwerty muncul.. page content tidak naik ke atas
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            HeaderScreen(),
            Expanded(
              flex: 8,
              child: Container(
                // color: Colors.grey,
                child: FutureBuilder(
                  future: postRepository.fetchData(1),
                  builder: (BuildContext c, AsyncSnapshot<List<Post>> s) {
                    if (s.hasError) {
                      return Center(
                        child: Text("salah ${s.error.toString()}"),
                      );
                    } else if (s.connectionState == ConnectionState.done) {
                      return new ShowListPost(post: s.data);
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ShowListPost extends StatefulWidget {
  const ShowListPost({
    this.post,
    Key key,
  }) : super(key: key);

  final List<Post> post;

  @override
  _ShowListPostState createState() => _ShowListPostState();
}

class _ShowListPostState extends State<ShowListPost> {
  ScrollController scrollController = new ScrollController();
  List<Post> post;
  int currentPage = 1;

  bool onNotificati(ScrollNotification notification) {
    if (notification is ScrollUpdateNotification) {
      if (scrollController.position.maxScrollExtent > scrollController.offset &&
          scrollController.position.maxScrollExtent - scrollController.offset <=
              50) {
        print('End Scroll');
        setState(() {
          currentPage += 1;
        });
        PostRepository().fetchData(currentPage + 1).then((val) {
          setState(() {
            post.addAll(val);
          });
        });
        print(currentPage);
      }
    }
    return true;
  }

  @override
  void initState() {
    post = widget.post;
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
          return ListTile(
            title: PostScreen(
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
