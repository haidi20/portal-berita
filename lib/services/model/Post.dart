import 'dart:convert';

class Post {
  var image;
  String title, date, content;

  Post({this.title, this.date, this.content, this.image});

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        title: json['title'],
        date: _setTime(json['date']),
        image: json['featured_image']['large'],
        content: _filterContent(json['content']),
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "title": title,
        "image": image,
        "content": content,
      };

  @override
  String toString() =>
      'Post{title: $title, date: $date, image: $image, content: $content}';
}

List<Post> postFromJson(String jsonData) {
  final data = json.decode(jsonData);

  return List<Post>.from(data.map((item) => Post.fromJson(item)));
}

String postToJson(Post data) {
  final jsonData = data.toJson();

  return json.encode(jsonData);
}

String _setTime(String dataTime) {
  DateTime date = DateTime.parse(dataTime);
  int differentDays = DateTime.now().difference(date).inDays;
  var differentNight = differentDays >= 2 ? differentDays - 1 : 0;

  return "$differentDays Days - $differentNight Nights";
}

String _filterContent(String content) {
  RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

  return content.replaceAll(exp, '').replaceAll('&nbsp;', '');
}
