import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ninucco/models/battle_betting_request_model.dart';

class BettingApiService {
  static const String baseUrl = "https://k8a605.p.ssafy.io/api/battle";

  static void postBetting(BattleBettingRequestModel bettingPost) {
    final url = Uri.parse('$baseUrl/bet');
    final response = http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "battleId": bettingPost.battleId,
        "betMoney": bettingPost.betMoney,
        "betSide": bettingPost.betSide,
        "memberId": bettingPost.memberId
      }),
    );
  }

  static Future<bool> checkBetting(int battleId, String memberId) async {
    final url = Uri.parse('$baseUrl/$battleId/bet?memberId=$memberId');
    final response = await http.get(url);
    final check = jsonDecode(response.body)["data"]["validate"];
    return check;
  }
}
