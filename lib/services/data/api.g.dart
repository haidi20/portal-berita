// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _RestClient implements RestClient {
  _RestClient(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    this.baseUrl ??= 'https://youlead.id/wp-json/barav/v1';
  }

  final Dio _dio;

  String baseUrl;

  @override
  getPostList(paged, s) async {
    ArgumentError.checkNotNull(paged, 'paged');
    ArgumentError.checkNotNull(s, 's');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'paged': paged, r's': s};
    final _data = <String, dynamic>{};
    final Response<List<dynamic>> _result = await _dio.request('/posts',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    var value = _result.data
        .map((dynamic i) => Post.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }
}
