import 'dart:core';
import 'dart:async';
import 'package:HolidayPackage/services/models/postModels.dart';
import 'package:HolidayPackage/services/resouces/postApiProvider.dart';

class Repository {
  final postApiProvider = PostApiProvider();

  Future<List<Post>> fetcPost() => postApiProvider.fetchPost();
}
