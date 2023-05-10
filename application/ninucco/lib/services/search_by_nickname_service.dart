import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ninucco/models/user_model.dart';

class UserSearchApiService {
  static const String baseUrl = "https://k8a605.p.ssafy.io/api/member/search";

  static Future<List<UserModel>> searchUserByNickname(String keyword) async {
    List<UserModel> userList = [];
    final url = Uri.parse('$baseUrl/$keyword');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final memberList = jsonDecode(response.body)["data"]['memberList'];
      if (memberList != null) {
        for (var member in memberList) {
          final instance = UserModel.fromJson(member);
          userList.add(instance);
        }
      }
      return userList;
    }
    throw Error();
  }
}
