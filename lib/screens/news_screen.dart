import 'dart:core';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:HolidayPackage/services/news.dart';
import 'package:HolidayPackage/screens/post_screen.dart';
import 'package:HolidayPackage/screens/header_screen.dart';

class NewsScreen extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
  News news = News();
  StreamController _dataController;

  getData() async {
    news.fetchData().then((res) async {
      _dataController.add(res);

      return res;
    });
  }

  String getTime(String dataTime) {
    DateTime date = DateTime.parse(dataTime);
    int differentDays = DateTime.now().difference(date).inDays;
    var differentNight = differentDays >= 2 ? differentDays - 1 : 0;

    return "$differentDays Days - $differentNight Nights";
  }

  String getContent(String content) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

    return content.replaceAll(exp, '');
  }

  String getUrl(int featured_media) {
    if (featured_media != 0) {
      return 'https://youlead.id/wp-json/wp/v2/media/$featured_media';
    } else {
      return null;
    }
  }

  @override
  void initState() {
    _dataController = new StreamController();
    getData();
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
            HeaderScreen(),
            Expanded(
              flex: 8,
              child: Container(
                // color: Colors.grey,
                child: StreamBuilder(
                  stream: _dataController.stream,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    // print('Has error: ${snapshot.hasError}');
                    // print('Has data: ${snapshot.hasData}');

                    if (snapshot.hasError) {
                      return Text(snapshot.error);
                    }

                    if (snapshot.hasData) {
                      return ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, i) {
                          // for (var item in snapshot.data)
                          return ListTile(
                            title: PostScreen(
                              url: getUrl(snapshot.data[i]['featured_media']),
                              time: getTime('${snapshot.data[i]['date_gmt']}'),
                              title: '${snapshot.data[i]["title"]["rendered"]}',
                              content: getContent(
                                  '${snapshot.data[i]["excerpt"]["rendered"]}'),
                            ),
                          );
                        },
                      );
                    }

                    if (!snapshot.hasData) {
                      return ListView(
                        scrollDirection: Axis.vertical,
                        children: <Widget>[
                          for (var i = 0; i < 10; i++)
                            PostScreen(
                              url: '',
                              time: '',
                              title: '',
                              content: '',
                            ),
                        ],
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
