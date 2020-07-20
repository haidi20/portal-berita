import 'dart:core';
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:HolidayPackage/services/model/Post.dart';

part 'api.g.dart';

@RestApi(baseUrl: "https://youlead.id/wp-json/barav/v1")
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET("/posts")
  Future<List<Post>> getPostList(
    @Query("paged") int paged,
    @Query("s") String s,
  );
}

RestClient restClient({String header}) {
  final dio = Dio();
  dio.options.headers["Content-type"] =
      header == null || header.isEmpty ? "application/json" : header;

  dio.options.connectTimeout = 65000;
  RestClient client = RestClient(dio);

  return client;
}
