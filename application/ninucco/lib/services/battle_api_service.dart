import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ninucco/models/battle_info_model.dart';
import 'package:ninucco/models/battle_post_model.dart';
import 'package:image/image.dart' as IMG;
import 'package:http_parser/http_parser.dart';

class BattleApiService {
  static const String baseUrl = "https://k8a605.p.ssafy.io/api/battle";

  static Future<List<BattleInfoModel>> getBattles(String battleStatus) async {
    List<BattleInfoModel> battleInstances = [];
    final url = Uri.parse('$baseUrl/list?option=latest&status=$battleStatus');
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

  static void postBattle(BattlePostModel battlePost) {
    final url = Uri.parse(baseUrl);
    final request = http.MultipartRequest("POST", url);
    request.fields["applicantId"] = battlePost.memberAId;
    request.fields["opponentId"] = battlePost.memberBId;
    request.fields["title"] = battlePost.question;

    IMG.Image? img = IMG.decodeImage(battlePost.memberAImage.readAsBytesSync());

    var multipartFile = http.MultipartFile.fromBytes(
      'applicantImage',
      IMG.encodePng(img!),
      filename: 'image.png',
      contentType: MediaType.parse('image/png'),
    );
    request.files.add(multipartFile);

    request.send();
  }
}
