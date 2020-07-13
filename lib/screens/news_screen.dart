import 'dart:core';
import 'package:flutter/material.dart';
import 'package:HolidayPackage/services/news.dart';
import 'package:HolidayPackage/screens/post_screen.dart';
import 'package:HolidayPackage/screens/header_screen.dart';

class HolidayScreen extends StatelessWidget {
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
  _ContentPageState() {
    getData();
  }

  List data;

  void getData() async {
    News news = News();
    data = await news.fetchData();
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

  String getUrl(int featuredMedia) {
    // print(featuredMedia);

    if (featuredMedia != 0) {
      return "https://youlead.id/wp-json/wp/v2/media/$featuredMedia";
    } else {
      return '';
    }
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
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: <Widget>[
                    for (var item in data)
                      PostScreen(
                        url: getUrl(item['featured_media']),
                        time: getTime('${item['date_gmt']}'),
                        title: '${item["title"]["rendered"]}',
                        content: getContent('${item["excerpt"]["rendered"]}'),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
