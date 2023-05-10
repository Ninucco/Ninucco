import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ninucco/models/battle_info_model.dart';

class BattleApiService {
  static const String baseUrl = "https://k8a605.p.ssafy.io/api/battle";

  static Future<List<BattleInfoModel>> getBattles() async {
    List<BattleInfoModel> battleInstances = [];
    final url = Uri.parse('$baseUrl/list?option=latest');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final battles = jsonDecode(response.body)["data"]["battleList"];
      for (var battle in battles) {
        final instance = BattleInfoModel.fromJson(battle);
        battleInstances.add(instance);
      }
      return battleInstances;
    }
    throw Error();
  }

  static Future<BattleInfoModel> getBattlesById(int battleId) async {
    final url = Uri.parse('$baseUrl/$battleId');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final battle = jsonDecode(response.body)["data"];
      final instance = BattleInfoModel.fromJson(battle);
      return instance;
    }
    throw Error();
  }
}
