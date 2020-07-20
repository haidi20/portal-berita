import 'dart:core';
import 'package:flutter/material.dart';
import 'package:HolidayPackage/screens/mainScreen/show_list.dart';
import 'package:HolidayPackage/services/data/api.dart';
import 'package:HolidayPackage/services/model/Post.dart';
import 'package:HolidayPackage/screens/mainScreen/header_screen.dart';

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
  String search = '';
  final client = restClient();

  void handleSearch(e) {
    setState(() {
      search = e;
    });
  }

  @override
  void initState() {
    super.initState();
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
            HeaderScreen(handleSearch: handleSearch),
            Expanded(
              flex: 8,
              child: Container(
                // color: Colors.grey,
                child: FutureBuilder(
                  future: client.getPostList(1, ""),
                  builder: (BuildContext c, AsyncSnapshot<List<Post>> s) {
                    // print(s.data);

                    if (s.hasError) {
                      return Center(
                        child: Text("salah ${s.error.toString()}"),
                      );
                    } else if (s.connectionState == ConnectionState.done) {
                      return new ShowListPost(post: s.data, search: search);
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
