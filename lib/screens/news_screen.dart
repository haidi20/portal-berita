import 'dart:convert';

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

    print(data[0]['id']);
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
                        title: '${item["id"]}',
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
