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
                  future: postRepository.fetchData(5),
                  builder: (BuildContext c, AsyncSnapshot<List<Post>> s) {
                    if (s.hasError) {
                      return Center(
                        child: Text("salah ${s.error.toString()}"),
                      );
                    } else if (s.connectionState == ConnectionState.done) {
                      List<Post> profiles = s.data;
                      print(profiles);
                      return Center(
                        child: Text("ada data"),
                      );
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
