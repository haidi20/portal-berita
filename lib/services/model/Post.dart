import 'dart:convert';

class Post {
  int id;
  var image;
  String title, date, content, shortContent;

  Post({
    this.id,
    this.date,
    this.title,
    this.image,
    this.content,
    this.shortContent,
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json['id'],
        title: json['title'],
        image: json['featured_image']['large'],
        content: _filterContent(json['content']),
        shortContent: _filterShortContent(json['content']),
        date: _setTime(json['date'], json['category'], json['author']),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date": date,
        "title": title,
        "image": image,
        "content": content,
        "shortContent": shortContent,
      };

  @override
  String toString() =>
      'Post{id: $id, title: $title, date: $date,' +
      'image: $image, content: $content shortContent: $shortContent}';
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

String _filterShortContent(String content) {
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

String _filterContent(String content) {
  RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
  // replaceAll(new RegExp(r"\s+"), "")

  // return content.replaceAll(exp, '').replaceAll('&nbsp;', '').trim();
  return content;
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
