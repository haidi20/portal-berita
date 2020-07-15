import 'dart:core';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:HolidayPackage/screens/post_screen.dart';
import 'package:HolidayPackage/screens/header_screen.dart';
import 'package:HolidayPackage/services/blocs/postBloc.dart';
import 'package:HolidayPackage/services/models/postModels.dart';

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
  var random = new Random();
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  ScrollController _scrollController = new ScrollController();

  String getTime(String dataTime) {
    DateTime date = DateTime.parse(dataTime);
    int differentDays = DateTime.now().difference(date).inDays;
    var differentNight = differentDays >= 2 ? differentDays - 1 : 0;

    return "$differentDays Days - $differentNight Nights";
  }

  @override
  void initState() {
    bloc.fetchAllPost();
    super.initState();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
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
                  stream: bloc.allPost,
                  builder: (context, AsyncSnapshot<List<Post>> snapshot) {
                    if (snapshot.hasData) {
                      return _showing(snapshot);
                    } else if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _showing(snapshot) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: snapshot.data.length,
      itemBuilder: (context, int index) {
        return ListTile(
          title: PostScreen(
            url: '${snapshot.data[index].image}',
            // time:
            //     getTime('${snapshot.data[index]['date_gmt']}'),
            title: '${snapshot.data[index].title}',
            content: snapshot.data[index].content,
          ),
        );
      },
    );
  }
}
