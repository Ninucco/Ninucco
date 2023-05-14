import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ninucco/models/user_detail_model.dart';
import 'package:ninucco/models/user_model.dart';

class UserService {
  static Future<UserDetailData> getUserDetailById(String userName) async {
    const String baseUrl = "https://k8a605.p.ssafy.io/api/member";
    final url = Uri.parse('$baseUrl/$userName');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final userDetail = jsonDecode(response.body);

      return UserDetailData.fromJson(userDetail['data']);
    }
    throw Error();
  }

  static Future<List<UserModel>> searchUserByNickname(String keyword) async {
    const String baseUrl = "https://k8a605.p.ssafy.io/api/member/search";
    List<UserModel> userList = [];
    final url = Uri.parse('$baseUrl/$keyword');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final memberList = jsonDecode(response.body)["data"]['memberList'];

      for (var member in memberList) {
        final instance = UserModel.fromJson(member);
        userList.add(instance);
      }
      return userList;
    }
    throw Error();
  }

  static Future<bool> existNickName(String nickname) async {
    final url = Uri.parse(
        "https://k8a605.p.ssafy.io/api/member/regist/nickname/?nickname=$nickname");
    final response = await http.get(url);

    return jsonDecode(response.body)['data']['validate'];
  }
}
