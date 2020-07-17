import 'dart:convert';

class Post {
  String title;

  Post({this.title});

  factory Post.fromJson(Map<String, dynamic> json) =>
      Post(title: json['title']);

  Map<String, dynamic> toJson() => {"title": title};

  @override
  String toString() => 'Post{title: $title}';
}

List<Post> postFromJson(String jsonData) {
  final data = json.decode(jsonData);

  return List<Post>.from(data.map((item) => Post.fromJson(item)));
}

String postToJson(Post data) {
  final jsonData = data.toJson();

  return json.encode(jsonData);
}
