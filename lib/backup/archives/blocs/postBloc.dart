import 'dart:async';
// import 'dart:convert';
// import 'package:async/async.dart';
import 'package:rxdart/rxdart.dart';
import 'package:HolidayPackage/services/models/postModels.dart';
import 'package:HolidayPackage/services/resouces/repository.dart';

class PostBloc {
  final _repository = Repository();
  final _postFetcher = PublishSubject<List<Post>>();

  int _perpage = 5;
  bool loading = false;
  BehaviorSubject<int> _initialPerpage;
  BehaviorSubject<bool> _initialLoading;
  Observable<List<Post>> get allPost => _postFetcher.stream;

  PostBloc() {
    _initialPerpage = BehaviorSubject<int>(seedValue: _perpage);
    _initialLoading = BehaviorSubject<bool>(seedValue: loading);
  }

  fetchPost() async {
    String url = 'https://youlead.id/wp-json/barav/v1/posts?per_page=$_perpage';

    List<Post> post = await _repository.fetchPost(url);
    _postFetcher.sink.add(post);
    print("memunculkan data");
    await new Future.delayed(const Duration(milliseconds: 500));
    _initialLoading.sink.add(false);
    print("loading false");
  }

  addMorePost() async {
    _perpage += 5;
    _initialLoading.sink.add(true);
    print("loading true");

    _initialPerpage.sink.add(_perpage);
  }

  dispose() {
    _postFetcher.close();
    _initialLoading.close();
    _initialPerpage.close();
  }
}

final bloc = PostBloc();
