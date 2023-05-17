import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ninucco/models/elo_rank_info_model.dart';
import 'package:ninucco/models/point_rank_info_model.dart';
import 'package:ninucco/models/user_rank_info_model.dart';

class UserRankApiService {
  static const String baseUrl = "https://k8a605.p.ssafy.io/api/rank";

  static Future<List<UserRankInfoModel>> getUserRanks() async {
    List<UserRankInfoModel> userRankInstances = [];
    final url = Uri.parse('$baseUrl/battle');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final userRanks = jsonDecode(response.body)["data"]["battleRanking"];
      for (var userRank in userRanks) {
        final instance = UserRankInfoModel.fromJson(userRank);
        userRankInstances.add(instance);
      }
      return userRankInstances;
    }
    throw Error();
  }

  static Future<List<PointRankInfoModel>> getPointRanks() async {
    List<PointRankInfoModel> userRankInstances = [];
    final url = Uri.parse('$baseUrl/point');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final userRanks = jsonDecode(response.body)["data"]["pointRanking"];
      for (var userRank in userRanks) {
        final instance = PointRankInfoModel.fromJson(userRank);
        userRankInstances.add(instance);
      }
      return userRankInstances;
    }
    throw Error();
  }

  static Future<List<EloRankInfoModel>> getEloRanks() async {
    List<EloRankInfoModel> userRankInstances = [];
    final url = Uri.parse('$baseUrl/elo');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final userRanks = jsonDecode(response.body)["data"]["eloRanking"];
      for (var userRank in userRanks) {
        final instance = EloRankInfoModel.fromJson(userRank);
        userRankInstances.add(instance);
      }
      return userRankInstances;
    }
    throw Error();
  }

  static Future<List<UserRankInfoModel>> getTop5UserRanks() async {
    List<UserRankInfoModel> userRankInstances = [];
    final url = Uri.parse('$baseUrl/battle');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final userRanks = jsonDecode(response.body)["data"]["battleRanking"];
      int i = 0;
      for (var userRank in userRanks) {
        if (i == 3) {
          break;
        }
        final instance = UserRankInfoModel.fromJson(userRank);
        userRankInstances.add(instance);
        i++;
      }
      return userRankInstances;
    }
    throw Error();
  }
}
