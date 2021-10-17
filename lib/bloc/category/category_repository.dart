import '../../services/api_provider.dart';

class CategoryRepository {
  ApiProvider appApiProvider = ApiProvider();

  Future<List<dynamic>> list() => appApiProvider.getList();
}
