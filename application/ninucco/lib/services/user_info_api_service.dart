import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:ninucco/models/member_model.dart';
import 'package:ninucco/providers/auth_provider.dart';

class UserInfoApiService {
  static const String baseUrl = "https://dummyjson.com";

  static Future<MemberModel> memberRegist(String memberId) async {
    Map<String, String> data = {
      'id': '314',
      'nickname': 'traceoflight',
      'url': 'https://avatars.githubusercontent.com/u/'
    };

    final url = Uri.parse('$baseUrl/member/regist');
    final response = await http.post(url,
        headers: {'Content-Type': 'application/json'}, body: json.encode(data));
    if (response.statusCode == 200) {
      MemberModel member = MemberModel.fromJson(json);

      final userInfo = jsonDecode(response.body)["data"];
      return userRankInstances;
    }
    throw Error();
  }
}
