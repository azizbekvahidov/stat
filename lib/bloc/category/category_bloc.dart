import 'package:rxdart/rxdart.dart';
import './category_repository.dart';

class CategoryBloc {
  CategoryRepository repo = CategoryRepository();
  final _dataFetcher = PublishSubject<List<dynamic>>();

  Stream<List<dynamic>> get categoryList => _dataFetcher.stream;

  fetchData() async {
    List<dynamic> response = await repo.list();
    _dataFetcher.sink.add(response);
  }

  dispose() {
    _dataFetcher.close();
  }
}

final categoryBloc = CategoryBloc();
