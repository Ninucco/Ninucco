import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ninucco/models/user_rank_info_model.dart';

class UserRankApiService {
  static const String baseUrl = "https://dummyjson.com";

  static Future<List<UserRankInfoModel>> getUserRanks() async {
    List<UserRankInfoModel> userRankInstances = [];
    final url = Uri.parse('$baseUrl/users');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final userRanks = jsonDecode(response.body)["users"];
      for (var userRank in userRanks) {
        final instance = UserRankInfoModel.fromJson(userRank);
        userRankInstances.add(instance);
      }
      return userRankInstances;
    }
    throw Error();
  }
}
