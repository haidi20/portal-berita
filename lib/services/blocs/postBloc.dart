import 'package:rxdart/rxdart.dart';
import 'package:HolidayPackage/services/models/postModels.dart';
import 'package:HolidayPackage/services/resouces/repository.dart';

class PostBloc {
  final _repository = Repository();
  final _postFetcher = PublishSubject<List<Post>>();

  Observable<List<Post>> get allPost => _postFetcher.stream;

  fetchAllPost() async {
    List<Post> post = await _repository.fetcPost();
    _postFetcher.sink.add(post);
  }

  dispose() {
    _postFetcher.close();
  }
}

final bloc = PostBloc();
