import 'dart:convert';

import './network_service.dart';

class ApiProvider {
  NetworkService net = NetworkService();

  Future<List<dynamic>> getList() async {
    try {
      final response =
          await net.get('http://1055.chess.for.uz/api/statistics/category');
      if (response.statusCode == 200) {
        var res = json.decode(utf8.decode(response.bodyBytes));
        return res;
      } else {
        throw Exception("error fetching users");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
