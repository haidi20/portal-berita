import 'dart:convert';

class Post {
  var image;
  String title, date, content;

  Post({this.title, this.date, this.content, this.image});

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        title: json['title'],
        date: _setTime(json['date'], json['category'], json['author']),
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

String _setTime(String dataTime, category, author) {
  DateTime date = DateTime.parse(dataTime);

  return "${date.day} ${nameMonts[date.month]} ${date.year}, $category, $author";
}

String _filterContent(String content) {
  RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
  // replaceAll(new RegExp(r"\s+"), "")

  return content
          .replaceAll(exp, '')
          .replaceAll('&nbsp;', '')
          .replaceAll("/n", "")
          .trim()
          .substring(0, 23) +
      "...";
}

List nameMonts = [
  "Januari",
  "Februari",
  "Maret",
  "April",
  "Mei",
  "Juni",
  "Juli",
  "Agustus",
  "September",
  "Oktober",
  "November",
  "Desember",
];
