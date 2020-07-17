import 'dart:core';
import 'dart:convert';

List<Post> postFromJson(String str) {
  final jsonData = json.decode(str);
  return new List<Post>.from(jsonData.map((item) => Post.fromJson(item)));
}

String postToJson(List<Post> data) {
  final dyn = new List<dynamic>.from(data.map((item) => item.toJson()));
  return json.encode(dyn);
}

String filterContent(String content) {
  RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

  return content.replaceAll(exp, '').replaceAll('&nbsp;', '');
}

String setTime(String dataTime) {
  DateTime date = DateTime.parse(dataTime);
  int differentDays = DateTime.now().difference(date).inDays;
  var differentNight = differentDays >= 2 ? differentDays - 1 : 0;

  return "$differentDays Days - $differentNight Nights";
}

class Post {
  String date;
  String title;
  String content;
  var image;

  Post({
    this.date,
    this.title,
    this.content,
    this.image,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    var date = setTime(json["date"]);
    var content = filterContent(json["content"]);

    return new Post(
      date: date,
      title: json["title"],
      content: content,
      image: json["featured_image"]["large"],
    );
  }

  // factory Playing.fromRawJson(String str) => Playing.fromJson(json.decode(str));

  Map<String, dynamic> toJson() => {
        "date": date,
        "title": title,
        "content": content,
        "image": image,
      };
}
