import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ninucco/models/battle_comment_info_model.dart';

class BattleApiCommentService {
  static const String baseUrl = "https://dummyjson.com";

  static Future<List<BattleCommentInfoModel>> getBattleComments(
      int battleId) async {
    List<BattleCommentInfoModel> battleInstances = [];
    final url = Uri.parse('$baseUrl/users');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final battles = jsonDecode(response.body)["users"];
      for (var battle in battles) {
        final instance = BattleCommentInfoModel.fromJson(battle);
        battleInstances.add(instance);
      }
      return battleInstances;
    }
    throw Error();
  }
}
