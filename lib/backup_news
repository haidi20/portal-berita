import 'dart:core';
import 'dart:async';
import 'dart:math';
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
  StreamController _dataController = new StreamController.broadcast();
  ScrollController _scrollController = new ScrollController();

  var random = new Random();
  var refreshKey = GlobalKey<RefreshIndicatorState>();

  void getData() async {
    news.fetchData().then((res) async {
      _dataController.add(res);
    });
  }

  void handleShowMoreContent() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      print('end scrolling');
      news.moreData().then((res) async {
        _dataController.add(res);
      });
    }
  }

  String getTime(String dataTime) {
    DateTime date = DateTime.parse(dataTime);
    int differentDays = DateTime.now().difference(date).inDays;
    var differentNight = differentDays >= 2 ? differentDays - 1 : 0;

    return "$differentDays Days - $differentNight Nights";
  }

  String getContent(String content) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

    return content.replaceAll(exp, '').replaceAll('&nbsp;', '');
  }

  Future refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 2));

    getData();

    return null;
  }

  @override
  void initState() {
    super.initState();

    _dataController = new StreamController();
    _scrollController.addListener(() {
      handleShowMoreContent();
    });
    getData();
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
                    List data = [];

                    if (snapshot.hasError) {
                      return Text(snapshot.error);
                    }

                    if (snapshot.hasData) {
                      for (var item in snapshot.data) {
                        data.add(item);
                      }

                      return RefreshIndicator(
                        key: refreshKey,
                        onRefresh: refreshList,
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: snapshot.data.length,
                          controller: _scrollController,
                          itemBuilder: (context, i) {
                            return ListTile(
                              title: PostScreen(
                                url: '${data[i]["featured_image"]["large"]}',
                                // time:
                                //     getTime('${data[i]['date_gmt']}'),
                                title: '${data[i]["title"]}',
                                content: getContent('${data[i]["content"]}'),
                              ),
                            );
                          },
                        ),
                      );
                    }

                    if (!snapshot.hasData) {
                      return ListView(
                        scrollDirection: Axis.vertical,
                        children: <Widget>[
                          for (var i = 0; i < 10; i++)
                            PostScreen(
                              url: '',
                              // time: '',
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
